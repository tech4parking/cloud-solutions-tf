import json
import boto3
from datetime import datetime

bedrock = boto3.client('bedrock-runtime')
dynamodb = boto3.client('dynamodb')
iot_data = boto3.client('iot-data')

def lambda_handler(event, context):
    # Get data from IoT Core
    response = iot_data.get_thing_shadow(
        thingName='humidity_sensor'
    )
    
    payload = json.loads(response['payload'].read())
    state = payload['state']['reported']

    average_moisture = state['averageMoisture']
    current_state = state.get('state', 'unknown')

    prompt = f"""
    Você é um especialista em agricultura. Sua resposta final deverá ser um conjunto completo e detalhado de recomendações para otimizar a saúde e produção das plantas. 
    Utilize o contexto fornecido, os documentos relevantes e o input do usuário para elaborar suas recomendações.
    Contexto: Estamos monitorando a umidade do solo para uma plantação.
    Documento relevante: A umidade atual do solo é {average_moisture} e o estado é {current_state}.
    Usuário: Com base nessa umidade, quais são suas recomendações para otimizar a saúde, de acordo com esta valor de umidade ?
    Assistente:
    """

    response = bedrock.invoke_model(
        modelId='ai21.j2-mid-v1',
        body=json.dumps({
            "prompt": prompt,
            "maxTokens": 512,
            "temperature": 0.7,
            "topP": 1,
            "stopSequences": [],
            "countPenalty": {"scale": 0},
            "presencePenalty": {"scale": 0},
            "frequencyPenalty": {"scale": 0}
        })
    )

    bedrock_response = json.loads(response['body'].read())
    recommendations = bedrock_response['completions'][0]['data']['text']

    # Store the data in DynamoDB
    dynamodb.put_item(
        TableName='MoistureRecommendations',
        Item={
            'id': {'S': str(context.aws_request_id)},
            'averageMoisture': {'N': str(average_moisture)},
            'state': {'S': current_state},
            'recommendations': {'S': recommendations},
            'date': {'S': datetime.now().isoformat()}
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps({
            'averageMoisture': average_moisture,
            'state': current_state,
            'recommendations': recommendations
        })
    }
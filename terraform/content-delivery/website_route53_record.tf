resource "aws_route53_record" "www_record" {
  zone_id = aws_route53_zone.tech4parking_zone.id
  name    = "www.tech4parking.com.br"
  type    = "A"
  alias {
    # LOAD BALANCER
    name                   = var.website_load_balancer_dns_name
    zone_id                = var.website_lb_zone_id

    # CLOUDFRONT
    # name                   = aws_cloudfront_distribution.tech4parking_distribution.domain_name
    # zone_id                = aws_cloudfront_distribution.tech4parking_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

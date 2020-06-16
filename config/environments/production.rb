# frozen_string_literal: true

Jets.application.configure do
  # Lambda config
  config.prewarm.enable = true
  config.function.timeout = 45 # api gateway has an implicit timeout of 30 secs
  config.function.memory_size = 1536

  # VPC Config
  #   freshtrak_cscbus vpc-06b80390c45f8e8e0
  #   Must be deployed to private subnets that have access
  #   to a NAT Gateway. When deployed to public subnets
  #   the lambda seems to just timeout.
  config.function.vpc_config = {
    subnet_ids: %w[subnet-0dcec794080e1b017],
    security_group_ids: %w[sg-03d1217e55919958e]
  }

  # API Gateway config
  config.cors = 'https://freshtrak.com'

  config.domain.cert_arn =
    'arn:aws:acm:us-east-2:903047886911:certificate/' \
    '2b493199-576f-4c87-8d7e-d6e08fdf1932'
  config.domain.hosted_zone_name = 'freshtrak.com'
  config.domain.hosted_zone_id = '/hostedzone/Z08199011R108JA1EOCH7'
  config.domain.name = 'registration-api.freshtrak.com'
end

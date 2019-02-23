# AWS SETTINGS
aws_target_bucket="everstories.cryptizens.io"
aws_profile="cryptizens"

# BUILD ALL FILES
npm run build

# UPLOAD ALL BUILT SITE FILES TO S3
aws s3 cp dist/ s3://$aws_target_bucket/dist --recursive --profile $aws_profile
aws s3 cp index.html s3://$aws_target_bucket/index.html --profile $aws_profile
aws s3 cp social.png s3://$aws_target_bucket/social.png --profile $aws_profile

region                   = "ap-south-1"
environment              = "dev"
bucket_name              = "ishant-poc-terraform"
dynamodb_name            = "ishant-poc-terraform"
dynamo_kms_master_key_id = "" // if you want to give your own CMK key then speify the arn else it will use default aws managed dynamo kms key

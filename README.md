# aws-lambda-active-record-psql

Use this template to build a lambda function that supports Active Record with Postgresql

## Usage

1. Build the docker image
   `make image`
2. Install dependencies
   `make install`
3. Create a lambda function using ruby 2.7 runtime
4. Edit `lambda_function.rb`
5. Edit make file and replace `[YOUR_FUNCTIONA_NAME]` with you AWS Lambda Function name
6. Make sure you have the AWS CLI installed and correctly configured
7. Upload the function to AWS
   `make deploy`
8. Invoke the function
   `make invoke`

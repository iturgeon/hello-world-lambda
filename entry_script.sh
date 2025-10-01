#!/bin/sh

# AWS_LAMBDA_RUNTIME_API is empty or not set
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
	# not running on aws lambda infrastructure, so use the RIE with the RIC
	# Note the $@ will be your CMD from the docker run command
	exec /usr/local/bin/aws-lambda-rie /usr/local/bin/npx aws-lambda-ric $@
else
	# Running on aws lambda infrastructure
	# Note the $@ will be your CMD from the docker run command
	exec /usr/local/bin/npx aws-lambda-ric $@
fi

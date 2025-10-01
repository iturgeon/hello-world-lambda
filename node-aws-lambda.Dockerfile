FROM public.ecr.aws/lambda/nodejs:20

# Set the working directory within the container
WORKDIR ${LAMBDA_TASK_ROOT}

# Copy package.json and package-lock.json (if present) to the working directory
COPY index.js ./

# Define the command that Lambda executes when the function is invoked
# The path/to/name of the javascript file with the file extension replaced with 'handler'
# ex: index.js -> index.handler, or main.js -> main.handler
CMD [ "index.handler" ]

# build using this (covers both platforms)
# docker buildx build --platform linux/amd64,linux/arm64 --no-cache -t hello-world-node-lambda -f node.Dockerfile .

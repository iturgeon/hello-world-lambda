## Hello World Lambda

An ultra simple starting point for testing and building Docker based Lambda function containers.
I needed this when I wanted to quickly build out an AWS infrastructure that included several Lambda API functions and just needed a placeholder to get started.

These images will be perfect as placeholders, but will also serve as an example on how to build out your own lambda function containers if you're having doubts, like I do every time I walk away and return to this.

## Nodejs

You can run these directly from builds on Docker Hub published here <https://hub.docker.com/r/iturgeon/hello-world-lambda>

```
docker run -p 9000:8080 iturgeon/hello-world-lambda:node-alpine
or
docker run -p 9000:8080 iturgeon/hello-world-lambda:node-aws-lambda
```

## Sending a request to the RIE

The runtime emulator responds to requests like this:

```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
# {"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"message\":\"Hello World from Lambda!\",\"timestamp\":\"2025-10-01T01:08:43.416Z\",\"event\":{}}"}%
```

## AWS Lambda Node

size: 410MB

### Build

```
docker buildx build -t hello-world:node-aws-lambda --load -f ./node-aws-lambda.Dockerfile .
```

### Run your build

```
docker run --rm -p 9000:8080 hello-world:node-aws-lambda

```

## Alpine Node

size: 155MB
NOTE: This image would be 588MB if not using staged builds

```
docker buildx build -t hello-world:node-alpine --load -f ./node-alpine.Dockerfile .
docker run --rm -p 9000:8080 hello-world:alpine
```

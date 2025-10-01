FROM node:20-alpine AS ric

# needed JUST to build aws-lambda-ric
# ~367MB
RUN apk add --no-cache autoconf automake cmake libtool binutils gcc g++ make python3 py3-setuptools

# aws-lambda-ric has a hard requirement on libexecinfo-dev
# It was removed from alpine in 3.17, but you can install it from the old repository
# ~676MB
RUN apk add --no-cache --update --repository=https://dl-cdn.alpinelinux.org/alpine/v3.16/main/ libexecinfo-dev

# install ric globally so the entry_script will just find it when it runs it with npx
# ~80MB
RUN npm install --global aws-lambda-ric@3.3.0


FROM node:20-alpine

# copy installed node modules
COPY --from=ric /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
# symlink the executable
RUN ln -s  /usr/local/lib/node_modules/aws-lambda-ric/bin/index.mjs /usr/local/bin/aws-lambda-ric

# The RIE Lambda Emulator can just be downloaded
# ~7.1MB
ADD --chmod=755 https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/local/bin/aws-lambda-rie

# This entry script allows you to run the RIE (emulator) or automatically run the RIC when running on lambda
COPY --chmod=755 ./entry_script.sh /entry_script.sh

# finally, we can copy our code in
COPY index.js ./index.js

# send commands through this script
ENTRYPOINT [ "/entry_script.sh" ]

# Define the command that Lambda executes when the function is invoked
# The path/to/name of the javascript file with the file extension replaced with 'handler'
# ex: index.js -> index.handler, or main.js -> main.handler
CMD ["index.handler"]

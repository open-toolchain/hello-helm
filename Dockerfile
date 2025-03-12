#  Copyright 2019,2025 IBM

# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.


# hadolint ignore=DL3007
FROM registry.access.redhat.com/ubi8/nodejs-20-minimal:latest
USER root

RUN microdnf -y upgrade && microdnf clean all
# Install the application
COPY package.json /app/package.json
COPY app.js /app/app.js
COPY utils.js /app/utils.js
WORKDIR /app
RUN npm install

ENV PORT 8080

USER 1001
EXPOSE 8080
CMD ["node", "app.js"]
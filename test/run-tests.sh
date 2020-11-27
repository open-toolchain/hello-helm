#!/bin/bash
# set -x
npm install
npm run start-server & npm run test-unit
npm run test-fvt
FILE_LOCATIONS="./test/unit-test.json;./test/fvt-test.json"
TEST_TYPES="unittest;fvt"

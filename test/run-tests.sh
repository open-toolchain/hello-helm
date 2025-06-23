#!/bin/bash
# set -x
exit_code=0
npm install
npm run start-server & npm run test-unit || exit_code=$?
mv ./test/jest-junit.xml ./test/unit-test.xml
npm run test-fvt || exit_code=$?
mv ./test/jest-junit.xml ./test/fvt-test.xml
FILE_LOCATIONS="./test/unit-test.xml;./test/fvt-test.xml"
TEST_TYPES="unittest;fvt"
exit $exit_code

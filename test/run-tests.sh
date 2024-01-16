#!/bin/bash
# set -x
npm install
npm run start-server & npm run test-unit
mv ./test/jest-junit.xml ./test/unit-test.xml
npm run test-fvt
mv ./test/jest-junit.xml ./test/fvt-test.xml
FILE_LOCATIONS="./test/unit-test.xml;./test/fvt-test.xml"
TEST_TYPES="unittest;fvt"

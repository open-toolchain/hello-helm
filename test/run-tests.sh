#!/bin/bash
# set -x
npm install
npm run start-server & npm run test-unit
npm run test-fvt
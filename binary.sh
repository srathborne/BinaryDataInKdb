#!/bin/bash

cd files
python -m SimpleHTTPServer 8000 &
cd ..

~/q/l32/q binary.q

trap 'jobs -p | xargs kill' EXIT


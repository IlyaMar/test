#!/bin/bash

for i in {1..30}; do
	echo "RUN #$i"
	#mvn package -T 6 || (echo "FAILURE ON RUN #$i" ; exit 1)
	mvn package -T 6 || exit 1
done
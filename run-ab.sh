#!/bin/bash

# Check if the number of repetitions is provided as a command-line argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_repetitions>"
    exit 1
fi

# Extract the number of repetitions from the command-line argument
repetitions=$1

# Your next statement that you want to repeat
for ((i=1; i<=repetitions; i++)); do
    echo "################## RUN: $i ##################"
    ab -n 10000 http://localhost:8080/hello
    echo "#############################################"
done

echo "FINISHED run Apache Bench!"
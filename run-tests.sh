#!/bin/bash
#
# Start spring webflux server and redirect output to spring-webflux.log
#
mvn spring-boot:run > spring-webflux.log &
PID_WEBFLUX=$!
#
# Wait until appear the message 'Started WebfluxDemoApplicationKt' in spring-webflux.log
#
sleep 1
while ! grep -m1 'Started WebfluxDemoApplicationKt' < spring-webflux.log; do
    sleep 1
done

timeout=30  # Set your desired timeout in seconds
elapsed_time=0
#
# Start Apache Bench for the number of times provided
#
./run-ab.sh 5 > ab.log &
PID_AB=$!
#
# Wait until appear the message 'FINISHED' or timeout reached.
#
sleep 1
while [ $elapsed_time -lt $timeout ]; do
    if grep -m1 'FINISHED run Apache Bench!' < ab.log; then
        break
    fi

    sleep 1
    ((elapsed_time++))
done
#
# If we reached the timeout than we have to kill AB process.
#
if [ $elapsed_time -ge $timeout ]; then
    echo "Timeout reached. Exiting script."
    kill $PID_AB
    wait $PID_AB
fi

# Gracefully terminate the Spring Boot application
kill $PID_WEBFLUX

# Wait for the process to exit
wait $PID_WEBFLUX

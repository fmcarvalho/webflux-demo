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
#
# Start Apache Bench
#
ab -n 20000 http://localhost:8080/hello > ab.log &
#
# Wait until appear the message 'Total' in ab.log
#
sleep 1
while ! grep -m1 'Total' < ab.log; do
    sleep 1
done

# Gracefully terminate the Spring Boot application
kill $PID_WEBFLUX


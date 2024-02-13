package com.example.webfluxdemo

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
open class WebfluxDemoApplication

fun main(args: Array<String>) {
    runApplication<WebfluxDemoApplication>(*args)
}

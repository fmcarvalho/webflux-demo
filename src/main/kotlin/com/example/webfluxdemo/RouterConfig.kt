package com.example.webfluxdemo

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.ParameterizedTypeReference
import org.springframework.http.MediaType
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.ok
import org.springframework.web.reactive.function.server.router
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono
import java.time.Duration

@Configuration
open class RouterConfig {
    val countries = Flux
        .fromArray(arrayOf("Portugal", "Spain", "Brazil", "Mozambique", "Australia"))
        .delayElements(Duration.ofMillis(1))

    @Bean
    open fun route() = router {
        GET("/hello", ::sayHello)
        GET("/events", ::events)
    }

    fun sayHello(request: ServerRequest): Mono<ServerResponse> {
        val htmlBody = "<html><body><p>Hello, WebFlux!</p></body></html>"
        return ok().contentType(MediaType.TEXT_HTML).bodyValue(htmlBody)
    }

    fun events(request: ServerRequest): Mono<ServerResponse> {
        val html = countries.map { "<p>$it</p>" }
        return ok()
            .contentType(MediaType.TEXT_HTML)
            .body(html, object : ParameterizedTypeReference<String>() {})
    }
}

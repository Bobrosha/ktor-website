package ru.project.zaicev.plugins

import freemarker.cache.ClassTemplateLoader
import freemarker.core.HTMLOutputFormat
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.application.install
import io.ktor.server.freemarker.FreeMarker
import io.ktor.server.freemarker.FreeMarkerContent
import io.ktor.server.response.respond
import io.ktor.server.routing.get
import io.ktor.server.routing.routing

fun Application.configureTemplating() {
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
        outputFormat = HTMLOutputFormat.INSTANCE
    }

    routing {
        get("/html-freemarker") {
            call.respond(FreeMarkerContent("index.ftl", mapOf("data" to IndexData(listOf(1, 2, 3))), ""))
        }
    }
}

data class IndexData(val items: List<Int>)

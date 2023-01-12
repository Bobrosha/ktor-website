package ru.project.zaicev

import io.ktor.server.application.*
import ru.project.zaicev.plugins.*

fun main(args: Array<String>): Unit =
    io.ktor.server.netty.EngineMain.main(args)

@Suppress("unused") // application.conf references the main function. This annotation prevents the IDE from marking it as unused.
fun Application.module() {
    configureAuthentication()
    configureMonitoring()
    configureTemplating()
    configureSecurity()
    configureRouting()
}

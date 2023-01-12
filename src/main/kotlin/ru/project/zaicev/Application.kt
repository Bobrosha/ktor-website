package ru.project.zaicev

import io.ktor.server.application.*
import ru.project.zaicev.cache.UserCache
import ru.project.zaicev.entity.UserEntity
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

    UserCache.addUser(UserEntity("1", "asd", "asd", 8))
}

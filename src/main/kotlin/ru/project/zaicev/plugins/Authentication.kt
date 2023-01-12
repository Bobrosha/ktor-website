package ru.project.zaicev.plugins

import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.application.install
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.Principal
import io.ktor.server.auth.UserIdPrincipal
import io.ktor.server.auth.authenticate
import io.ktor.server.auth.form
import io.ktor.server.auth.principal
import io.ktor.server.auth.session
import io.ktor.server.freemarker.FreeMarkerContent
import io.ktor.server.response.respond
import io.ktor.server.response.respondRedirect
import io.ktor.server.response.respondText
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.routing
import io.ktor.server.sessions.Sessions
import io.ktor.server.sessions.clear
import io.ktor.server.sessions.cookie
import io.ktor.server.sessions.sessions
import io.ktor.server.sessions.set
import ru.project.zaicev.cache.UserCache
import ru.project.zaicev.util.AuthenticationFlag

data class UserSession(val name: String, val count: Int) : Principal

fun Application.configureAuthentication() {
    install(Sessions) {
        cookie<UserSession>("user_session") {
            cookie.path = "/"
            cookie.maxAgeInSeconds = 60
        }
    }
    install(Authentication) {
        form("auth-form") {
            userParamName = "username"
            passwordParamName = "password"
            validate { credentials ->
                val userEntity = UserCache.getUserByUsername(credentials.name)
                if (userEntity != null && userEntity.password == credentials.password) {
                    UserIdPrincipal(credentials.name)
                } else {
                    null
                }
            }
            challenge {
                call.respond(FreeMarkerContent("authentication.ftl", mapOf("authFlag" to AuthenticationFlag.WrongPassword)))
            }
        }

        session<UserSession>("auth-session") {
            validate { session ->
                if (session.name.startsWith("admin")) {
                    session
                } else {
                    null
                }
            }
            challenge {
                call.sessions.clear<UserSession>()
                call.respond(FreeMarkerContent("authentication.ftl", mapOf("authFlag" to AuthenticationFlag.WrongPrivilege)))
            }
        }

        session<UserSession>("main-page") {
            validate { session ->
                if (session.name != null) {
                    session
                } else {
                    null
                }
            }
            challenge {
                call.respond(FreeMarkerContent("index.ftl", null))
            }
        }
    }

    routing {
        get("/login") {
            call.respond(FreeMarkerContent("authentication.ftl", model = null))
        }

        get("/registration") {
            call.respond(FreeMarkerContent("authentication.ftl", mapOf("authFlag" to AuthenticationFlag.Registration)))
        }

        authenticate("auth-form") {
            post("/login") {
                val userName = call.principal<UserIdPrincipal>()?.name.toString()
                call.sessions.set(UserSession(name = userName, count = 1))
                call.respond(FreeMarkerContent("index.ftl", mapOf("username" to userName)))
            }
        }

        authenticate("auth-session") {
            get("/showAllStatistics") {
                val userSession = call.principal<UserSession>()
                call.sessions.set(userSession?.copy(count = userSession.count + 1))
                call.respondText("Hello, ${userSession?.name}! Visit count is ${userSession?.count}.")
            }
        }

        get("/logout") {
            call.sessions.clear<UserSession>()
            call.respondRedirect("/login")
        }
    }
}
package ru.project.zaicev.plugins

import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.auth.authenticate
import io.ktor.server.auth.principal
import io.ktor.server.freemarker.FreeMarkerContent
import io.ktor.server.http.content.resources
import io.ktor.server.http.content.static
import io.ktor.server.request.receiveParameters
import io.ktor.server.response.respond
import io.ktor.server.response.respondRedirect
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.route
import io.ktor.server.routing.routing
import io.ktor.server.util.getOrFail
import ru.project.zaicev.cache.ResultList
import ru.project.zaicev.cache.UserCache
import ru.project.zaicev.entity.ResultEntity
import ru.project.zaicev.entity.UserEntity
import ru.project.zaicev.models.EventBlock
import ru.project.zaicev.util.AuthenticationFlag
import ru.project.zaicev.util.Privileges

fun Application.configureRouting() {
    routing {
        static("/static") {
            resources("files")
        }

        get("/") {
            call.respondRedirect("shulte")
        }

        route("shulte") {
            authenticate("main-page") {
                get {
                    val userSession = call.principal<UserSession>()

                    println("User session: $userSession")
                    if (userSession == null) {
                        call.respond(FreeMarkerContent("index.ftl", null))
                    } else {
                        call.respond(FreeMarkerContent("index.ftl", mapOf("username" to userSession.name)))
                    }
                }
            }

            post("registration") {
                val formParameters = call.receiveParameters()
                val username = formParameters.getOrFail("username")
                val password = formParameters.getOrFail("password")
                if (UserCache.getUserByUsername(username) != null) {
                    call.respond(
                        FreeMarkerContent(
                            "authentication.ftl",
                            mapOf("authFlag" to AuthenticationFlag.WrongUsername)
                        )
                    )
                } else {
                    UserCache.addUser(
                        UserEntity(
                            username = username,
                            password = password,
                            privileges = Privileges.CommonUser.code
                        )
                    )
                    call.respond(
                        FreeMarkerContent(
                            "authentication.ftl",
                            mapOf("authFlag" to AuthenticationFlag.ReLogin)
                        )
                    )
                }
            }

            get("instruction") {
                call.respond(
                    FreeMarkerContent(
                        "instruction.ftl", mapOf("listOfBlocks" to EventBlock.orderedList)
                    )
                )
            }


            get("startEvent") {
                call.respond(
                    FreeMarkerContent(
                        "event.ftl", mapOf("listOfBlocks" to EventBlock.orderedList.shuffled().withIndex().toList())
                    )
                )
            }

            post("retryEvent") {
                val formParameters = call.receiveParameters()
                val resultList = ResultEntity.convertResultList(formParameters.getOrFail("resultList"))

                call.respond(
                    FreeMarkerContent(
                        "event.ftl", mapOf(
                            "listOfBlocks" to EventBlock.orderedList.shuffled().withIndex().toList(),
                            "earlyResultList" to resultList.results
                        )
                    )
                )
            }

            authenticate("main-page") {
                post("save") {
                    val username = call.principal<UserSession>()!!.name
                    val formParameters = call.receiveParameters()
                    val resultList = ResultEntity.convertResultList(formParameters.getOrFail("resultList"))
                    val userEntity = UserCache.getUserByUsername(username) ?: throw RuntimeException("User not found")
                    ResultList.addResultById(userEntity.id, resultList)
                    call.respondRedirect("/")
                }
            }
        }
    }
}
package ru.project.zaicev.entity

import io.ktor.http.Url
import ru.project.zaicev.util.Privileges

data class Instruction(val text: String)

data class Task(val matrix: List<List<Int>>)

data class Mistake(val count: Int)

data class Test(val sequence: List<Int>, val number: Int, val stage: Int)

data class User(val login: String, val role: Privileges)

data class HttpService(val baseUrl: Url)

data class Result(val efficiency: Float, val workability: Float, val sustainability: Float)

data class MyResults(val results: List<List<Int>>)

data class Registration(val login: String, val password: String)

data class Login(val login: String, val password: String)

data class Statistics(val results: List<List<Int>>)








fun t() {
    var a: Instruction? = null
    var b: Task? = null
    var c: Mistake? = null
    var d: Test? = null
    var e: User? = null
    var f: HttpService? = null
    var g: Result? = null
    var h: MyResults? = null
    var i: Registration? = null
    var j: Login? = null
    var k: Statistics? = null
}
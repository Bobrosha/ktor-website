package ru.project.zaicev.util

enum class Privileges(val code: Int, val role: String) {
    CommonUser(1, "Common user"),
    Admin(8, "Admin")
}
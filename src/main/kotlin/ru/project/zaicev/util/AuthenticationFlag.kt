package ru.project.zaicev.util

enum class AuthenticationFlag(val code: Int, val reason: String) {
    WrongPassword(-1, "Неверный username или password"),
    WrongUsername(-2, "username уже используется"),
    WrongPrivilege(-3, "Не достаточно привилегий"),
    ReLogin(0, "Аккаунт создан, авторизуйтесь"),
    Registration(1, "Придумайте username и password")
}
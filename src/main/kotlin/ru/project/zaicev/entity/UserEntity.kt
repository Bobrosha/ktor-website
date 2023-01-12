package ru.project.zaicev.entity

import java.util.UUID

typealias PrivilegesCode = Int

data class UserEntity(val id: String = generateId(), val username: String, val password: String, val privileges: PrivilegesCode) {
    companion object {
        fun generateId() = UUID.randomUUID().toString().replace("-", "")
    }
}
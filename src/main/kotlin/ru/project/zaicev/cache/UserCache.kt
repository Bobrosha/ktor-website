package ru.project.zaicev.cache

import ru.project.zaicev.entity.UserEntity
import ru.project.zaicev.util.Privileges

class UserCache {
    companion object {
        private val adminId = UserEntity.generateId()
        private val userId = UserEntity.generateId()

        private val userMap = hashMapOf(
            adminId to UserEntity(adminId, "admin", "admin", Privileges.Admin.code),
            userId to UserEntity(userId, "user", "user", Privileges.CommonUser.code)
        )

        fun addUser(userEntity: UserEntity) = userMap.putIfAbsent(userEntity.id, userEntity)

        fun getUserById(id: String) = userMap[id]

        fun getUserByUsername(username: String) = userMap.filter { it.value.username == username }.values.firstOrNull()
    }
}
package ru.project.zaicev.cache

import java.util.HashMap
import kotlin.random.Random
import ru.project.zaicev.cache.UserCache.Companion.adminId
import ru.project.zaicev.cache.UserCache.Companion.userId
import ru.project.zaicev.entity.ResultEntity

class ResultList {
    companion object {
        private val resultMap: HashMap<String, MutableList<ResultEntity>> = hashMapOf(
            adminId to mutableListOf(
                ResultEntity(
                    listOf(
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                    )
                ),
                ResultEntity(
                    listOf(
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                    )
                )
            ),
            userId to mutableListOf(
                ResultEntity(
                    listOf(
                        listOf("1", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("3", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                    )
                ),
                ResultEntity(
                    listOf(
                        listOf("1", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("3", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                    )
                ),
                ResultEntity(
                    listOf(
                        listOf("1", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                        listOf("3", Random.nextInt(9999).toString()),
                        listOf("0", Random.nextInt(9999).toString()),
                    )
                )

            ),
        )

        fun addResultById(id: String, result: ResultEntity) {
            if (resultMap[id]?.add(result) == null) {
                resultMap[id] = mutableListOf(result)
            }
        }

        fun getAllResults(): List<Pair<String, List<IndexedValue<List<Pair<Int, Int>>>>>>? {
            val resultList =
                resultMap.map {
                    Pair(
                        UserCache.getUserById(it.key)!!.username,
                        it.value.map { i -> i.results.map { j -> Pair(j[0].toInt(), j[1].toInt()) } }.withIndex()
                            .toList()
                    )
                }
            return resultList.ifEmpty {
                return null
            }
        }

        fun getResultById(id: String): List<IndexedValue<List<Pair<Int, Int>>>>? =
            resultMap[id]?.map { it.results.map { j -> Pair(j[0].toInt(), j[1].toInt()) } }?.withIndex()?.toList()
    }
}
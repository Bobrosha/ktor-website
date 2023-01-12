package ru.project.zaicev.cache

import ru.project.zaicev.entity.ResultEntity

class ResultList {
    companion object {
        private val resultMap = hashMapOf<String, MutableList<ResultEntity>>()

        fun addResultById(id: String, result: ResultEntity) {
            resultMap[id]?.add(result) ?: { resultMap[id] = mutableListOf(result) }
        }

        fun getResultById(id: String) = resultMap[id]
    }
}
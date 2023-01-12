package ru.project.zaicev.entity

data class ResultEntity(val results: List<List<String>>) {
    companion object {
        fun convertResultList(resultParam: String): ResultEntity {
            val resultSplit = resultParam.split(",")

            val resultList = mutableListOf<List<String>>()
            for (i in resultSplit.indices step 2) {
                resultList.add(listOf(resultSplit[i], resultSplit[i + 1]))
            }

            return ResultEntity(resultList)
        }
    }
}
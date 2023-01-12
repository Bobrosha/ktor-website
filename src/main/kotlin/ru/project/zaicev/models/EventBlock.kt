package ru.project.zaicev.models

class EventBlock
private constructor(val blockNumber: Int) {
    companion object {
        val orderedList = (1..25).map { EventBlock(it) }
    }
}
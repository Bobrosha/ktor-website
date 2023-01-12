package ru.project.zaicev.models

import java.util.concurrent.atomic.AtomicInteger

class View
private constructor(val id: Int, var title: String, var body: String) {
    companion object {
        private val idCounter = AtomicInteger()

        fun newEntry(title: String, body: String) = View(idCounter.getAndIncrement(), title, body)

        val articles = mutableListOf(
            newEntry(
            "The drive to develop!",
            "...it's what keeps me going."
        )
        )
    }
}
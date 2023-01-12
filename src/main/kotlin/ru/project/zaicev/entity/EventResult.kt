package ru.project.zaicev.entity

import java.time.LocalTime
import org.slf4j.LoggerFactory

class EventResult
private constructor(username: String, time: LocalTime) {
    companion object {
        private val logger = LoggerFactory.getLogger(this::class.java)

        fun newInstance(username: String, time: LocalTime) {
            logger.info("Elapsed time : $time")
            logger.info("Username : $username")
        }
    }
}
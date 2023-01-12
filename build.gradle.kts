val ktor_version: String by project
val kotlin_version: String by project
val logback_version: String by project
val prometeus_version: String by project

plugins {
    kotlin("jvm") version "1.8.0"
    id("io.ktor.plugin") version "2.2.1"
}

group = "ru.project.zaicev"
version = "0.0.1"

application {
    mainClass.set("io.ktor.server.netty.EngineMain")

    val isDevelopment: Boolean = project.ext.has("development")
    applicationDefaultJvmArgs = listOf("-Dio.ktor.development=$isDevelopment")
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.ktor:ktor-server-core:$ktor_version")
    implementation("io.ktor:ktor-server-auth:$ktor_version")
    implementation("io.ktor:ktor-server-netty:$ktor_version")
    implementation("io.ktor:ktor-server-sessions:$ktor_version")
    implementation("io.ktor:ktor-server-freemarker:$ktor_version")
    implementation("io.ktor:ktor-server-html-builder:$ktor_version")
    implementation("io.ktor:ktor-server-metrics-micrometer:$ktor_version")

    implementation("ch.qos.logback:logback-classic:$logback_version")
    implementation("io.micrometer:micrometer-registry-prometheus:$prometeus_version")

    testImplementation("io.ktor:ktor-server-tests:$ktor_version")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit:$kotlin_version")
}
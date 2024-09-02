package com.ziecorp.enlace.dev

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform
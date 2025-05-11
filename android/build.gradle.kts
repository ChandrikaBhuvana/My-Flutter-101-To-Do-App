plugins {
    // The Google Services plugin is required for Firebase integration
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()      // Google's Maven repository for Firebase dependencies
        mavenCentral() // Maven Central repository
    }
}

// Define build directory structure
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Ensure subprojects have their own build directory
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    // Ensure the ":app" project is evaluated before any other subprojects
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    // This task deletes the build directory when running `flutter clean`
    delete(rootProject.layout.buildDirectory)
}

// Buildscript dependencies, including Kotlin and Gradle versions
buildscript {
    val kotlin_version by extra("1.8.10") // Make sure Kotlin version matches the one you're using

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Gradle plugin for building Android apps
        classpath("com.android.tools.build:gradle:8.0.0") // Android Gradle plugin, compatible with your Flutter version
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version") // Kotlin Gradle plugin version
        classpath("com.google.gms:google-services:4.4.2") // Google services plugin for Firebase
    }
}

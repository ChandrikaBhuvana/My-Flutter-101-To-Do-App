plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // Firebase plugin
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin
}

android {
    namespace = "com.bhuvana.todo_app"
    compileSdk = 34 // Flutter's recommended compile SDK

    ndkVersion = "27.0.12077973" // Optional: Match Flutter's default NDK if needed

    defaultConfig {
        applicationId = "com.bhuvana.todo_app"
        minSdk = 21 // Minimum supported Android SDK
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Use debug signing for now
        }
    }
}

flutter {
    source = "../.."
}

// 🔧 Required for Firebase services to work
apply(plugin = "com.google.gms.google-services")

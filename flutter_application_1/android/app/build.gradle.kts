android {
    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.google_maps_in_flutter"
        // Minimum Android version for Google Maps SDK
        // https://developers.google.com/maps/flutter-package/config#android
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

}
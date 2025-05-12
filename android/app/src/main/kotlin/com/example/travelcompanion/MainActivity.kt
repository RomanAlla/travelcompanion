package com.example.travelcompanion

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("ffbde21e-cc1d-4116-b754-24a968d7d2fa")
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}

package com.example.effective_coffee

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        var apiKey = getString(R.string.api_key)
        MapKitFactory.setApiKey(apiKey)
        super.configureFlutterEngine(flutterEngine)
    }
}

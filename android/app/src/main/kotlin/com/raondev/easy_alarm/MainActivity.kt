package com.raondev.easy_alarm

import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    val TAG : String = "(Android) [MainActivity]"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        startService(Intent(this, NotificationService::class.java))
        super.configureFlutterEngine(flutterEngine)
    }

    override fun onDestroy() {
        Log.d(TAG, "onDestroy")
        super.onDestroy()
    }
}

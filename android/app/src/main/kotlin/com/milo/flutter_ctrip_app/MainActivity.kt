package com.milo.flutter_ctrip_app

import android.os.Bundle
import com.milo.flutter_ctrip_app.plugin.AsrPlugin
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        AsrPlugin.registerWith(registrarFor("com.milo.flutter_ctrip_app.plugin.AsrPlugin"))
    }
}

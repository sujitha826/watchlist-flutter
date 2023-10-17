package com.example.watchlist_flutter_bloc

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channelName = "watchlist/module"
    private val methodName = "helloFromAndroid"

    private lateinit var channel: MethodChannel
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        channel.invokeMethod(methodName, null, object: MethodChannel.Result{
            override fun success(result: Any?) {
                Log.i("Android", "result: $result")
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                Log.i("Android", "error: $errorCode, $errorMessage, $errorDetails")
            }

            override fun notImplemented() {
                Log.i("Android", "notImplemented")
            }
        })
    }

}

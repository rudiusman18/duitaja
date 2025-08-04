package id.mobile.duitaja

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.deviceInfo"  // Ensure the name matches the Dart side

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getDeviceModel") {
                val manufacturer = Build.MANUFACTURER
                val model = Build.MODEL
                result.success("$manufacturer $model")
            } else {
                result.notImplemented()
            }
        }
    }
}

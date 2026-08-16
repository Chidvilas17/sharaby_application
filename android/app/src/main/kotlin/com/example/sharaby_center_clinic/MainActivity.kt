package com.example.sharaby_center_clinic

import android.content.pm.PackageManager
import android.provider.CallLog
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.sharaby.clinic/call_log"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getRecentMissedCalls") {
                val missedCalls = getRecentMissedCalls()
                result.success(missedCalls)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getRecentMissedCalls(): List<Map<String, Any>> {
        val callsList = mutableListOf<Map<String, Any>>()
        
        if (checkSelfPermission(android.Manifest.permission.READ_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
            return callsList
        }

        try {
            val cursor = contentResolver.query(
                CallLog.Calls.CONTENT_URI,
                arrayOf(CallLog.Calls.NUMBER, CallLog.Calls.DATE, CallLog.Calls.TYPE),
                "${CallLog.Calls.TYPE} = ?",
                arrayOf(CallLog.Calls.MISSED_TYPE.toString()),
                "${CallLog.Calls.DATE} DESC"
            )

            cursor?.use {
                val numberIndex = it.getColumnIndex(CallLog.Calls.NUMBER)
                val dateIndex = it.getColumnIndex(CallLog.Calls.DATE)

                var count = 0
                while (it.moveToNext() && count < 25) {
                    val number = if (numberIndex != -1) it.getString(numberIndex) else ""
                    val date = if (dateIndex != -1) it.getLong(dateIndex) else 0L

                    if (!number.isNullOrEmpty()) {
                        val callData = mapOf(
                            "phoneNumber" to number,
                            "timestamp" to date
                        )
                        callsList.add(callData)
                        count++
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return callsList
    }
}

package com.milo.flutter_ctrip_app.plugin

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/*
 * @ 创建者       wenbiao.huang
 * @ 创建时间     2019/12/10 10:46
 * @ 描述         
 */

class AsrPlugin(registrar: PluginRegistry.Registrar) : MethodChannel.MethodCallHandler {
    companion object {
        const val TAG = "AsrPlugin"

        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), "asr_plugin")

            val instance = AsrPlugin(registrar)
            channel.setMethodCallHandler(instance)
        }
    }

    private var activity: Activity? = registrar.activity()
    private var asrManager: AsrManager? = null

    private lateinit var resultStateful: ResultStateful
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        initPermission()
        when (methodCall.method) {
            "startRecord" -> {
                resultStateful = ResultStateful.of(result)
                startRecord(methodCall, resultStateful)
            }
            "stopRecord" -> {
                stopRecord(methodCall, resultStateful)
            }
            "cancelRecord" -> {
                cancelRecord(methodCall, resultStateful)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun startRecord(methodCall: MethodCall, resultStateful: ResultStateful) {
        if (activity == null) {
            Log.e(TAG, "Ignored start, current activity is null.")
            resultStateful.error("Ignored start, current activity is null", null, null)
        }

        if (getAsrManager() != null) {
            getAsrManager()!!.start(if (methodCall.arguments is Map<*, *>) (methodCall.arguments as Map<String, Any>) else null)
        } else {
            Log.e(TAG, "Ignored start, current getAsrManager is null.")
            resultStateful.error("Ignored start, current getAsrManager is null", null, null)
        }
    }

    private fun stopRecord(methodCall: MethodCall, resultStateful: ResultStateful) {
        if (getAsrManager() != null) {
            getAsrManager()!!.stop()
        }
    }

    private fun cancelRecord(methodCall: MethodCall, resultStateful: ResultStateful) {
        if (getAsrManager() != null) {
            getAsrManager()!!.cancel()
        }
    }

    private fun getAsrManager(): AsrManager? {
        if (asrManager == null) {
            if (activity != null && !activity!!.isFinishing) {
                asrManager = AsrManager(activity!!, onAsrListener)
            }
        }
        return asrManager
    }

    /**
     * android 6.0 以上需要动态申请权限
     */
    private fun initPermission() {
        if (activity == null) {
            return
        }
        val permissions = arrayOf(Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.READ_PHONE_STATE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        )
        val toApplyList = ArrayList<String>()
        for (perm in permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity!!, perm)) {
                toApplyList.add(perm)
                //进入到这里代表没有权限.
            }
        }
        val tmpList = arrayOfNulls<String>(toApplyList.size)
        if (toApplyList.isNotEmpty()) {
            ActivityCompat.requestPermissions(activity!!, toApplyList.toArray(tmpList), 123)
        }
    }

    private val onAsrListener = object : OnAsrListener {
        override fun onAsrReady() {
        }

        override fun onAsrBegin() {
        }

        override fun onAsrEnd() {
        }

        override fun onAsrPartialResult(results: Array<String?>?, recogResult: RecogResult) {
        }

        override fun onAsrOnlineNluResult(nluResult: String) {
        }

        override fun onAsrFinalResult(results: Array<String?>?, recogResult: RecogResult) {
            resultStateful.success(results?.get(0))
        }

        override fun onAsrFinish(recogResult: RecogResult) {
        }

        override fun onAsrFinishError(errorCode: Int, subErrorCode: Int, descMessage: String?, recogResult: RecogResult) {
            resultStateful.error(descMessage, null, null)
        }

        override fun onAsrLongFinish() {
        }

        override fun onAsrVolume(volumePercent: Int, volume: Int) {
        }

        override fun onAsrAudio(data: ByteArray, offset: Int, length: Int) {
        }

        override fun onAsrExit() {
        }

        override fun onOfflineLoaded() {
        }

        override fun onOfflineUnLoaded() {
        }
    }
}
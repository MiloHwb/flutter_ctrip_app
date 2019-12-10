package com.milo.flutter_ctrip_app.plugin

import android.app.Activity
import android.util.Log
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
        when (methodCall.method) {
            "startRecord" -> {
                resultStateful = ResultStateful.of(result)
                startRecord(methodCall, resultStateful)
            }
            "stopRecord" -> {
            }
            "cancelRecord" -> {
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

    private val onAsrListener = object : OnAsrListener {
        override fun onAsrReady() {
            // TODO(onAsrReady) 
        }

        override fun onAsrBegin() {
            // TODO(onAsrBegin) 
        }

        override fun onAsrEnd() {
            // TODO(onAsrEnd) 
        }

        override fun onAsrPartialResult(results: Array<String?>?, recogResult: RecogResult) {
            // TODO(onAsrPartialResult) 
        }

        override fun onAsrOnlineNluResult(nluResult: String) {
            // TODO(onAsrOnlineNluResult) 
        }

        override fun onAsrFinalResult(results: Array<String?>?, recogResult: RecogResult) {
            // TODO(onAsrFinalResult) 
        }

        override fun onAsrFinish(recogResult: RecogResult) {
            // TODO(onAsrFinish) 
        }

        override fun onAsrFinishError(errorCode: Int, subErrorCode: Int, descMessage: String?, recogResult: RecogResult) {
            // TODO(onAsrFinishError) 
        }

        override fun onAsrLongFinish() {
            // TODO(onAsrLongFinish) 
        }

        override fun onAsrVolume(volumePercent: Int, volume: Int) {
            // TODO(onAsrVolume) 
        }

        override fun onAsrAudio(data: ByteArray, offset: Int, length: Int) {
            // TODO(onAsrAudio) 
        }

        override fun onAsrExit() {
            // TODO(onAsrExit) 
        }

        override fun onOfflineLoaded() {
            // TODO(onOfflineLoaded) 
        }

        override fun onOfflineUnLoaded() {
            // TODO(onOfflineUnLoaded) 
        }
    }

}
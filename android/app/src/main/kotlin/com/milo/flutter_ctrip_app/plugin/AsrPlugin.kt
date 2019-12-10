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

    private val onAsrListener = object : AsrManager.OnAsrListener {
        override fun onAsrReady() {
            // TODO(onAsrReady)
        }

        override fun onAsrBegin() {
            // TODO(onAsrBegin)
        }
    }

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

        if (getAsrManager()!=null) {
            getAsrManager()
        }
    }

    fun getAsrManager(): AsrManager? {
        if (asrManager == null) {
            if (activity != null && !activity!!.isFinishing) {
                asrManager = AsrManager(activity!!, onAsrListener)
            }
        }
        return asrManager
    }
}
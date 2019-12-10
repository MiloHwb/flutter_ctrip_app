package com.milo.flutter_ctrip_app.plugin

import android.content.Context
import android.util.Log
import com.baidu.speech.EventManager
import com.baidu.speech.EventManagerFactory
import com.baidu.speech.asr.SpeechConstant
import org.json.JSONObject

/*
 * @ 创建者       wenbiao.huang
 * @ 创建时间     2019/12/10 18:47
 * @ 描述         
 */

class AsrManager(val context: Context, val listener: OnAsrListener) {
    /**
     * SDK 内部核心 EventManager 类
     */
    private var asr: EventManager? = null

    // SDK 内部核心 事件回调类， 用于开发者写自己的识别回调逻辑
    private lateinit var recogEventAdapter: RecogEventAdapter

    // 未release前，只能new一个
    @Volatile
    private var isInited = false

    private val TAG = "AsrManager"

    private var asrManager: AsrManager? = null
    fun getInstance(context: Context, listener: OnAsrListener): AsrManager {
        if (asrManager == null)
            asrManager = AsrManager(context, listener)
        return asrManager!!
    }

    /**
     * 初始化 提供 EventManagerFactory需要的Context和RecogEventAdapter
     *
     * @param context
     * @param listener 识别状态和结果回调
     */
    init {
        if (isInited) {
            Log.e(TAG, "还未调用release()，请勿新建一个新类")
            throw RuntimeException("还未调用release()，请勿新建一个新类")
        }
        isInited = true
        this.recogEventAdapter = RecogEventAdapter(listener)
        // SDK集成步骤 初始化asr的EventManager示例，多次得到的类，只能选一个使用
        asr = EventManagerFactory.create(context, "asr")
        // SDK集成步骤 设置回调event， 识别引擎会回调这个类告知重要状态和识别结果
        asr!!.registerListener(recogEventAdapter)
    }

    /**
     * 开始
     *
     * @param params
     */
    fun start(params: Map<String, Any>?) {
        if (!isInited) {
            throw RuntimeException("release() was called")
        }
        // SDK集成步骤 拼接识别参数
        val json = JSONObject(params).toString()
        Log.e("$TAG.Debug", "识别参数（反馈请带上此行日志）$json")
        asr!!.send(SpeechConstant.ASR_START, json, null, 0, 0)
    }

    /**
     * 提前结束录音等待识别结果。
     */
    fun stop() {
        Log.e(TAG, "停止录音")
        // SDK 集成步骤（可选）停止录音
        if (!isInited) {
            throw RuntimeException("release() was called")
        }
        asr!!.send(SpeechConstant.ASR_STOP, "{}", null, 0, 0)
    }

    /**
     * 取消本次识别，取消后将立即停止不会返回识别结果。
     * cancel 与stop的区别是 cancel在stop的基础上，完全停止整个识别流程，
     */
    fun cancel() {
        Log.e(TAG, "取消识别")
        if (!isInited) {
            throw RuntimeException("release() was called")
        }
        // SDK集成步骤 (可选） 取消本次识别
        asr!!.send(SpeechConstant.ASR_CANCEL, "{}", null, 0, 0)
    }

    fun release() {
        if (asr == null) {
            return
        }
        cancel()
        // SDK 集成步骤（可选），卸载listener
        asr!!.unregisterListener(recogEventAdapter)
        asr = null
        isInited = false
    }
}
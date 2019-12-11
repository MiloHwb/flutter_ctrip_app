package com.milo.flutter_ctrip_app.plugin

import android.util.Log
import com.baidu.speech.EventListener
import com.baidu.speech.asr.SpeechConstant
import org.json.JSONException
import org.json.JSONObject

/*
 * @ 创建者       milo
 * @ 创建时间     2019/12/10 22:10
 * @ 描述         
 */

class RecogEventAdapter(val listener: OnAsrListener) : EventListener {

    private val TAG = "RecogEventAdapter"

    // 基于DEMO集成3.1 开始回调事件
    override fun onEvent(name: String, params: String?, data: ByteArray?, offset: Int, length: Int) {
        val currentJson = params
        val logMessage = "name:$name; params:$params"
        if (data == null || params == null) {
            return
        }
        // logcat 中 搜索RecogEventAdapter，即可以看见下面一行的日志
        Log.i(TAG, logMessage)
        if (name == SpeechConstant.CALLBACK_EVENT_ASR_LOADED) {
            listener.onOfflineLoaded()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_UNLOADED) {
            listener.onOfflineUnLoaded()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_READY) {
            // 引擎准备就绪，可以开始说话
            listener.onAsrReady()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_BEGIN) {
            // 检测到用户的已经开始说话
            listener.onAsrBegin()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_END) {
            // 检测到用户的已经停止说话
            listener.onAsrEnd()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_PARTIAL) {
            val recogResult = RecogResult.parseJson(params)
            // 识别结果
            val results = recogResult.getResultsRecognition()
            if (recogResult.isFinalResult()) {
                // 最终识别结果，长语音每一句话会回调一次
                listener.onAsrFinalResult(results, recogResult)
            } else if (recogResult.isPartialResult()) {
                // 临时识别结果
                listener.onAsrPartialResult(results, recogResult)
            } else if (recogResult.isNluResult()) {
                // 语义理解结果
                listener.onAsrOnlineNluResult(String(data, offset, length))
            }
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_FINISH) {
            // 识别结束
            val recogResult = RecogResult.parseJson(params)
            if (recogResult.hasError()) {
                val errorCode = recogResult.getError()
                val subErrorCode = recogResult.getSubError()
                Log.e(TAG, "asr error:$params")
                listener.onAsrFinishError(errorCode, subErrorCode, recogResult.getDesc(), recogResult)
            } else {
                listener.onAsrFinish(recogResult)
            }
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_LONG_SPEECH) { // 长语音
            listener.onAsrLongFinish() // 长语音
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_EXIT) {
            listener.onAsrExit()
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_VOLUME) {
            // Logger.info(TAG, "asr volume event:" + params);
            val vol = parseVolumeJson(params)
            listener.onAsrVolume(vol.volumePercent, vol.volume)
        } else if (name == SpeechConstant.CALLBACK_EVENT_ASR_AUDIO) {
            if (data.size != length) {
                Log.e(TAG, "internal error: asr.audio callback data length is not equal to length param")
            }
            listener.onAsrAudio(data, offset, length)
        }
    }

    private fun parseVolumeJson(jsonStr: String): Volume {
        val vol = Volume()
        vol.origalJson = jsonStr
        try {
            val json = JSONObject(jsonStr)
            vol.volumePercent = json.getInt("volume-percent")
            vol.volume = json.getInt("volume")
        } catch (e: JSONException) {
            e.printStackTrace()
        }

        return vol
    }

    private inner class Volume {
        var volumePercent = -1
        var volume = -1
        var origalJson: String? = null
    }
}
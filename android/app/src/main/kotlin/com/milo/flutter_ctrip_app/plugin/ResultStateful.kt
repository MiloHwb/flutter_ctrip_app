package com.milo.flutter_ctrip_app.plugin

import android.util.Log
import io.flutter.plugin.common.MethodChannel

/*
 * @ 创建者       wenbiao.huang
 * @ 创建时间     2019/12/10 15:37
 * @ 描述         
 */

class ResultStateful private constructor(val result: MethodChannel.Result) : MethodChannel.Result {
    companion object {
        const val TAG = "ResultStateful"
        fun of(result: MethodChannel.Result): ResultStateful {
            return ResultStateful(result)
        }
    }

    private var called: Boolean = false

    override fun notImplemented() {
        if (called) {
            printError()
            return
        }
        called = true
        result.notImplemented()
    }

    override fun error(p0: String?, p1: String?, p2: Any?) {
        if (called) {
            printError()
            return
        }
        called = true
        result.error(p0, p1, p2)
    }

    override fun success(p0: Any?) {
        if (called) {
            printError()
            return
        }
        called = true
        result.success(p0)
    }

    fun printError() {
        Log.d(TAG, "error: result called")
    }
}
package com.milo.flutter_ctrip_app.plugin

import android.content.Context

/*
 * @ 创建者       wenbiao.huang
 * @ 创建时间     2019/12/10 18:47
 * @ 描述         
 */

class AsrManager(val context: Context, listener: OnAsrListener) {

    interface OnAsrListener {
        fun onAsrReady()
        fun onAsrBegin()
    }
}
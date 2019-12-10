import 'package:flutter/services.dart';

class AsrManager {
  static const MethodChannel _channel = const MethodChannel('asr_plugin');

  ///开始录音
  static Future<String> startRecord({Map params}) async {
    return await _channel.invokeMethod('startRecord', params ?? {});
  }

  ///停止录音
  static Future<String> stopRecord() async {
    return await _channel.invokeMethod('stopRecord');
  }

  ///取消录音
  static Future<String> cancelRecord() async {
    return await _channel.invokeMethod('cancelRecord');
  }
}

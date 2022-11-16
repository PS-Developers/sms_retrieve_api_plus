
import 'package:flutter/services.dart';

class SmsRetrieverApiPlus {
  static const MethodChannel _channel = MethodChannel('sms_retriever_api_plus');

  static Future<String?> getSignature() async {
    final getSignature = await _channel.invokeMethod('getSignature');
    return getSignature;
  }

  static Future<String?> initSMSAPI() async {
    final initSMSAPI = await _channel.invokeMethod('initSMSAPI');
    return initSMSAPI;
  }
}

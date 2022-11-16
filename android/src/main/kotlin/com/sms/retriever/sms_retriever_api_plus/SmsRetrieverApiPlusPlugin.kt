package com.sms.retriever.sms_retriever_api_plus

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.common.api.Status

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class SmsRetrieverApiPlusPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {

  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var smsBroadcastReceiver: MySMSBroadcastReceiver? = null
  private var result: MethodChannel.Result? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sms_retriever_api_plus")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.P)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getSignature") {
      val signatureHelper = AppSignatureHashHelper(activity)
      Log.i("Signature: ",signatureHelper.appSignatures.get(0))
      result.success(signatureHelper.appSignatures.get(0))
    } else if(call.method == "initSMSAPI"){
      initRetrievedApi()
      this.result = result
    }else {
      result.notImplemented()
    }
  }


  private fun initRetrievedApi() {
    val client = SmsRetriever.getClient(activity!!)
    val task = client.startSmsRetriever()
    task.addOnSuccessListener {
      Log.i("initRetrievedApi", "Success")
      startSMSListening()
    }
  }

  private fun startSMSListening() {
    Log.i("SMSListening", "Started...")
    try {
      smsBroadcastReceiver = MySMSBroadcastReceiver()
      activity!!.registerReceiver(smsBroadcastReceiver,
        IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION))
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }


  private fun stopSMSListening() {
    try {
      Log.i("SMSListening", "Stopped...")
      activity!!.unregisterReceiver(smsBroadcastReceiver)
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }

  inner class MySMSBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
      try {
        if (SmsRetriever.SMS_RETRIEVED_ACTION == intent.action) {
          val extras = intent.extras
          val status = extras!![SmsRetriever.EXTRA_STATUS] as Status?
          when (status!!.statusCode) {
            CommonStatusCodes.SUCCESS -> {
              val message = extras[SmsRetriever.EXTRA_SMS_MESSAGE] as String?
              Log.i("Message", message!!)
              result!!.success(message)
              stopSMSListening()
            }
            CommonStatusCodes.TIMEOUT -> {}
          }
        }
      } catch (e: Exception) {
        //result.error("00", "Error", e.toString());
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity =binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity =binding.activity
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}

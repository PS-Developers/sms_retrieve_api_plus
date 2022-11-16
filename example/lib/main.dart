import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sms_retriever_api_plus/sms_retriever_api_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _signature = "";
  String _initSMSAPI = "";

  @override
  void initState() {
    super.initState();
    getSignature();
  }

  Future<void> getSignature() async {
    String signature = "";
    try {
      signature = await SmsRetrieverApiPlus.getSignature() ?? 'Unknown platform version';
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _signature = signature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Signature : $_signature\n'),
            ),
            ElevatedButton(
                onPressed: () async {
                  String status = await SmsRetrieverApiPlus.initSMSAPI() ?? 'Unknown platform version';
                  setState(() {
                    _initSMSAPI = status;
                  });
                },
                child: const Text("InitSMSApi")),
            Center(
              child: Text('$_initSMSAPI\n'),
            ),
          ],
        ),
      ),
    );
  }
}

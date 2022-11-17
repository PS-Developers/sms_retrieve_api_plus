/// The SMS Retriever API provides a fully automated user experience and should be used when possible. 
/// It does, however, require you to place a custom hash code in the message body, and this may be difficult to do if you're not the sender of that message.

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

/// When your server receives a request to verify a phone number, first construct the verification message that you will send to the user's device. This message must:

/// 1. Be no longer than 140 bytes
/// 2. Contain a one-time code that the client sends back to your server to complete the verification flow (see Generating a one-time code)
/// 3. Include an 11-character hash string that identifies your app (see Computing your app's hash string)

/// Otherwise, the contents of the verification message can be whatever you choose. It is helpful to create a message from which you can easily extract the one-time code later on. For example, a valid verification message might look like the following:

/// Your ExampleApp code is: 123ABC78
/// FA+9qCX9VSu

/// Alternatively

/// keytool -exportcert -alias PlayDeploymentCert -keystore MyProductionKeys.keystore | xxd -p | tr -d "[:space:]" | echo -n com.example.myapp `cat` | sha256sum | tr -d "[:space:]-" | xxd -r -p | base64 | cut -c1-11

/// Below generate key change in debug, release and publish play store generate key changed

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
                  await getMessage();
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

  ///Get the Message using initSMSAPI Only one's triger using get meaage
  Future<void> getMessage() async {
    String status = await SmsRetrieverApiPlus.initSMSAPI() ?? 'Unknown platform version';
    setState(() {
      _initSMSAPI = status;
    });
  }
}

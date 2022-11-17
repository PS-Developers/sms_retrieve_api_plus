# sms_retriever_api_plus

A new Flutter plugin to retrieve the SMS on Android using SMS Retrieval API

## Getting Started

To retrieve a app signature. It requires by the SMS
```dart
String appSignature = await SmsRetrieverApiPlus.getSignature();
```

To start listening for an incoming SMS
```dart
String message = await SmsRetrieverApiPlus.initSMSAPI()
```

Generate appSignature for keystore file
````dart in html
keytool -storepass storepass -alias alias -exportcert -keystore file | xxd -p | tr -d "[:space:]" | xxd -r -p | base64 | cut -c1-11

````

Example SMS

[#] Your example code is:
123456
appSignature

## Usage 

## Reference

https://developers.google.com/identity/sms-retriever/overview
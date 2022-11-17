# sms_retriever_api_plus

A new Flutter plugin to retrieve the SMS on Android using SMS Retrieval API

## How to works 

With the SMS Retriever API, you can perform SMS-based user verification in your Android app automatically, without requiring the user to manually type verification codes, and without requiring any extra app permissions. When you implement automatic SMS verification in your app, the verification flow looks like this:

![](https://github.com/PanneerDev/sms_retrieve_api_plus/blob/master/img/sms_verification.png)

## Reference

https://developers.google.com/identity/sms-retriever/overview

## Getting Started

To retrieve a app signature. It requires by the SMS . 
Below generate key change in debug, release and publish play store generate key changed
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

## Output


## Reference

![](https://github.com/PanneerDev/sms_retrieve_api_plus/blob/master/img/1.png)
![](https://github.com/PanneerDev/sms_retrieve_api_plus/blob/master/img/2.png)

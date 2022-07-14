# Deep linking(딥 링킹)  
: URL을 열면 앱에 해당 화면이 표시된다.  
* **Navigator**와 **Router**를 사용한다.  

<br/>

## Enable deep linking on Android(안드로이드 버전)  
**AndroidManifest.xml 내부**에  <activity> tag와 ".MainActivity" 이름과 함께 metadata tag와 intent filter에 추가해라.
```dart
<!-- Deep linking -->
<meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" android:host="flutterbooksample.com" />
    <data android:scheme="https" />
</intent-filter>
```  
위의 내용 변화을 적용하기 위해 restart해라.  

<br/>

## Test on Android emulator(Android 에뮬레이터)  
Android 에뮬레이터를 테스트 하려면 AndroidManifest.xml:에 아래와 같이 적어라.  
```dart
adb shell am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://flutterbooksample.com/book/1"
```  

자세한 내용은 [Verify Android App Links](https://developer.android.com/training/app-links/verify-site-associations)를 보시오.  

<br/>

## Enable deep linking on iOS(iOS 버전)  
ios/Runner 디렉토리안에 새로운 key 2개 **FlutterDeepLinkingEnabled, CFBundleURLTypes** 를 **Info.plist**에 추가하라:  
```dart
<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>flutterbooksample.com</string>
    <key>CFBundleURLSchemes</key>
    <array>
    <string>customscheme</string>
    </array>
    </dict>
</array>
```  
CFBundleURLName은 다른 곳의 같은 scheme가 사용된 앱에서 구별된 고유한 URL이다. 그 scheme(customscheme://)는 고유하게 될 수 있다.  

위의 내용 변화을 적용하기 위해 restart해라.  

<br/>

## Test on iOS simulator(iOS 시뮬레이터)
**xcrun**를 사용하라.  
```dart
xcrun simctl openurl booted customscheme://flutterbooksample.com/book/1 
```  

<br/>

## Migrating from plugin-based deep linking

만약 너가 deep link를 다루기 위해 [“Deep Links and Flutter applications” on Medium](https://medium.com/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283)이라 설명된 plugin을 썼다면, Info.plist에 FlutterDeepLinkingEnabled(iOS), AndroidManifest.xml에 flutter_deeplinking_enabled(안드로이드) 각각 추가함으로써 opt-in 할 때까지 계속 작동할 것이다.  

<br/>

## Behavior  

|플랫폼/시나리오|Navigator 사용|Router 사용|
|------|---|---|
|iOS (not launched)|initialRoute("/") → pushRoute|초기 path("/") → RouteInformationParser를 사용하여 path를 분석 → RouterDelegate.setNewRoutePath를 호출 → 해당 페이지로 Navigar로 구성된다.|
|Android - (not launched)|Path("/deeplink")를 포함하는 initialRoute를 가져온다.| initialRoute("/deeplink")를 가져온다. → RouteInformationParser에 전달하여 path를 분석 → RouterDelegate.setNewRoutePath를 호출 → 해당 페이지로 Navigar로 구성된다.|
|iOS (launched)|pushRoute가 호출된다.|경로 분석되고 Navigator로 새 페이지 구성|
|Android (launched)|pushRoute가 호출된다.|경로 분석되고 Navigator로 새 페이지 구성|  

Router widget을 사용할 때, 앱이 진행되는 동안 새로운 deep link를 할 때 현재 페이지 대체할 능력을 가진다.  

<br/>

## 또한 봐야할 것

[Learning Flutter’s new navigation and routing system](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade)
# Adding a splash screen to your mobile app(모바일 앱에 splash screen 추가)  
![](https://docs.flutter.dev/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png)  

Splash screens는 mobile app load하는 동안 단순한 initial experience 제공한다. 그들은 앱 엔진이 load할 때와 앱 초기일 때의 허용하는 시간동안 application을 위한 stage를 set한다.  

## iOS launch screen
Apple App Store 제출한 모든 앱은 app’s launch screen을 제공하기 위해 반드시 Xcode storyboard를 사용해야 한다.  

default Flutter 템플릿은 자신의 assets와 함께 알맞게 봄으로써 customized될 수 있다. 지정된 **LaunchScreen.storyboard**는 Xcode storyboard를 포함한다. default일 때, storyboard는 blank image를 보여주지만 변할 수 있다. app directory의 root로부터 **open ios/Runner.xcworkspace** 유형에 의해 Flutter app’s Xcode project를 열기 위해 하는 일이다. 그때 LaunchImage image set에서 Project Navigator와 바람직한 images에서 떨어뜨림으로부터 **Runner/Assets.xcassets**를 선택해라.  

[Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/launching#launch-screens/)-시작 화면에 대한 지침 부분도 제공

## Android launch screen


```dart
```
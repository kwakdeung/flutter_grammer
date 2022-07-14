# Configuring the URL strategy on the web(웹에서의 URL 전략 구성)  

Flutter web의 앱들은 **URL-based navigation**으로 구성된 2개의 길로 지원한다.  

**Hash (default): #**  
Path들은 hash fragment(조각)를 읽고 쓴다.  
```
flutterexample.dev/#/path/to/screen.
```  

**Path**  
Path들은 hash 없이 읽고 쓴다.
```
flutterexample.dev/path/to/screen.
```  

<br/>

## Configuring the URL strategy(URL 전략 구성)  

 SDK에서 flutter_web_plugins library에 의하여 제공된 **setUrlStrategy** function을 사용해라.  
 **setUrlStrategy** API는 오직 웹에서 불러진다.  

> **참고:** default에 의해서 flutter는 hash (**/#/**) location 전략을 사용한다. 이 지시서는 만약 **URL path 전략** 사용하기를 원할 때 오직 필요로 한다.  
위 지시서를 사용 대신에, 너는 **url_strategy** package를 사용 할 수 있다.  

<br/>

## Web setup(웹 설치)  
첫 번째, pubspec.yaml에 **flutter_web_plugins**을 추가:  
```dart
dependencies:
  flutter_web_plugins:
    sdk: flutter
```  
runApp() 하기 전에 setUrlStrategy를 불러라:  
```dart
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
    setUrlStrategy(PathUrlStrategy());
    runApp(MyApp());
}
```  

<br/>

## Cross platform setup  
만약 앱이 Cross-platform이라면, 밑에 3가지 Dart's 조건의 imports 기능을 사용해라:  

**url_strategy.dart**  
```
export 'url_strategy_noop.dart' if (dart.library.html) 'url_strategy_web.dart';
``` 

**url_strategy_noop.dart**  
```
void usePathUrlStrategy() {
    // noop
}
```

**url_strategy_web.dart**  
```
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void usePathUrlStrategy() {
    setUrlStrategy(PathUrlStrategy());
}
```  
runApp() 전에 **setPathUrlStrategy**를 불러라:  

**main.dart**  
```dart
import 'package:flutter/material.dart';
import 'url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}
```
imports flutter_web_plugins 하면 library에 로드된다.  

<br/>

## Configuring your web server(웹 서버 구성)  

PathUrlStrategy는 web server를 위한 추가적인 구성이 필요로 하는 [History API](https://developer.mozilla.org/en-US/docs/Web/API/History_API)를 사용한다.  

만약 너가 Firebase 호스팅을 한다면, 프로젝트 초기에 “Configure as a single-page app” 옵션을 선택해라.  

local dev server는 **flutter run -d chrome**는 어떤 path 다루기로 그리고 너의 앱의 **index.html** 파일을 대체 시스템으로 구성된 실행함으로써 만들어 졌다.  

## Hosting a Flutter app at a non-root location(root가 없는 flutter 앱 호스팅)  

host된 앱을 통해 path에서 web/index.html안에 <base href="/"> 태그를 업데이트해라. 예를 들어,  my_app.dev/flutter_app에 flutter 앱 host 하는 것은 <base href="/flutter_app/">.로 바꾼다.

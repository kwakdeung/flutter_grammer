# Adaptive(적응형) 및 Responsive(반응형) 앱 만들기  

>Adaptive(적응형) 및 Responsive(반응형) 기본 개념 <br/>  
Adaptive(적응형): **다양한 장치**에 맞게 설계된 **여러 layout**을 제공  
Responsive(반응형): user에게 **빠르고 원활한 탐색** 기능을 제공  
(출처: https://designlog.org/2512903)

Flutter의 주요 목표 중 하나: 모든 플랫폼에서 멋지게 보이고 느껴지는 단일 코드베이스에서 앱을 개발할 수 있는 프레임워크를 만드는 것  
즉, 시계와 두 개의 화면이 있는 폴더블 전화기, 고화질 모니터에 이르기까지 다양한 크기의 화면에 앱이 표시될 수 있다.  
이 시나리오의 개념을 설명하는 두 가지 용어는 **Adaptive(적응형) 및 Responsive(반응형)**이다.  

<br/>

## Adaptive(적응형) 앱과 Responsive(반응형) 앱의 차이점  

Adaptive(적응형), Responsive(반응형)은 앱의 별도 차원이다.  

* Adaptive(적응형)  
모바일 및 데스크탑과 같은 다양한 장치 유형에서 실행되도록 앱을 조정하려면 마우스 및 키보드 입력과 터치 입력하여 처리해야 한다. 또한 앱의 VisualDensity, Component 선택 작동 방식(예: 계단식 메뉴 대 하단 시트), 플랫폼별 기능(예: 최상위 창) 사용 등에 대해 서로 다른 기대치가 있음을 의미한다.
 

* Responsive(반응형)
일반적으로 Responsive(반응형) 앱은 Device별 **사용 가능한 화면 크기에 맞게** layout을 조정한다. 예를 들어 사용자가 창의 크기를 조정하거나 장치의 방향을 변경하는 경우 UI를 다시 배치하는 경우가 많다. 이는 시계, 전화, 태블릿, 랩톱 또는 데스크톱 컴퓨터에 이르기까지 **다양한 Device에서 동일한 앱을 실행**할 수 있는 경우에 특히 필요하다.  

<br/>

## Adaptive(적응형) Flutter 앱 만들기  

gskinner팀이 작성한 Adaptive(적응형) 앱 build로 Adaptive(적응형) Flutter 앱을 만드는 방법에 대해 자세히 알아봐라.  

<br/>

### Adaptive(적응형) Layout  

[![Adaptive Layouts (The Boring Flutter Development Show, Ep. 45)](http://img.youtube.com/vi/n6Awpg1MO6M/0.jpg)](https://youtu.be/n6Awpg1MO6M)  

### Adaptive(적응형) Layout, 2부  

[![Adaptive Layouts part 2 (The Boring Flutter Development Show, Ep. 46)](http://img.youtube.com/vi/eikOZzfc0l4/0.jpg)](https://youtu.be/eikOZzfc0l4)  

### Adaptive(적응형) 앱의 훌륭한 예를 보려면 gskinner와 Flutter 팀과 협력하여 만든 스크랩북 앱인 Flutter Folio를 확인해라.  

[![Flutter Folio walkthrough](http://img.youtube.com/vi/yytBENOnF0w/0.jpg)](https://youtu.be/yytBENOnF0w)  

<br/>

## Responsive(반응형) Flutter 앱 만들기


기기의 화면 크기와 방향에 **자동으로 적응**하는 앱을 만들 수 있다.  

Responsive(반응형) 디자인 앱 생성 2가지 기본 접근 방식  

1. **LayoutBuilder Class를 사용**  
builder 속성에서 BoxConstraints 객체를 얻습니다. 제약 조건의 속성을 검토하여 표시할 항목을 결정한다. 예를 들어, 너의 maxWidth이 width breakpoint(너비 중단점)보다 큰 경우 왼쪽에 목록이 있는 Row가 있는 Scaffold 객체를 반환한다. 더 좁으면 해당 목록이 포함된 서랍이 있는 Scaffold 객체를 반환합니다. 기기의 높이, 종횡비 또는 기타 속성에 따라 디스플레이를 조정할 수도 있다. 제약 조건이 변경되면(예: 사용자가 전화를 회전하거나 앱을 Nougat의 타일 UI에 배치) 빌드 기능이 실행된다.  

2. **[MediaQuery.of()](https://api.flutter.dev/flutter/widgets/MediaQuery/of.html) build function에서 method 사용**
이것은 현재 앱의 size, orientation(방향) 등을 제공한다. 이것은 특정 위젯의 크기보다는 전체 context를 기반으로 결정을 내리려는 경우에 더 유용하다. 다시 말하지만, 이것을 사용하면 user가 어떻게든 앱의 size를 변경하면 build function이 자동으로 실행된다.  


반응형 UI를 만들기 위한 기타 유용한 위젯 및 클래스:  
* [AspectRatio](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html)
* [CustomSingleChildLayout](https://api.flutter.dev/flutter/widgets/CustomSingleChildLayout-class.html)
* [CustomMultiChildLayout](https://api.flutter.dev/flutter/widgets/CustomMultiChildLayout-class.html)
* [FittedBox](https://api.flutter.dev/flutter/widgets/FittedBox-class.html)
* [FractionallySizedBox](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html)
* [LayoutBuilder](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
* [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
* [MediaQueryData](https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html)
* [OrientationBuilder](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html)  

<br/>

## 기타 resource
다음 resource에서 플랫폼 Adaptive(적응형) 앱을 만드는 방법
* [플랫폼 별 behavior(동작) 및 Adaptive](https://docs.flutter.dev/resources/platform-adaptations)
* 올해 FlutterViking 컨퍼런스에서 발표된 Aloïs Deniel의 블로그 게시물 및 비디오로 [진정한 Adaptive(적응형) UI 설계](https://aloisdeniel.com/#/posts/adaptative-uihttps://aloisdeniel.com/#/posts/adaptative-ui).
* [Flutter gallery app](https://gallery.flutter.dev/#/)([repo](https://github.com/flutter/gallery)) 은 Adaptive(적응형) 앱으로 작성되었다.

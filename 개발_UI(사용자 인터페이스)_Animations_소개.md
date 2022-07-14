# Animations 소개

**좋은 디자인된 animation들**은 UI를 더욱 **직관적**이고, **매끄러운 보기**와 **광택**이 보이고 **사용자 경험**에 향상시키는데 기여한다. 
Flutter's animation은 다양한 animation 타입들의 요소를 쉽게 만드는 데 지원한다. 많은 widgets 특히 Material widgets은 디자인 스펙이 정의된 표준 모션 효과들이 온다. 그것은 효과들의 커스터마이징이 가능하다.  

접근 방식 선택(Choosing an approach)  

플러터 안에서 animation들을 만들 수 있는 다른 접근 방식이다.

[![How to choose which Flutter Animation Widget is right for you? - Flutter in Focus](http://img.youtube.com/vi/GXIJJkq_H8g/0.jpg)](https://youtu.be/GXIJJkq_H8g)


위의 비디오를 본 것과 같이, **의사 결정 tree(밑에 이미지)** 는 flutter에서 이행할 때 사용할 접근 방식을 결정할 수 있도록 도울 것이다.  
![](https://docs.flutter.dev/assets/images/docs/ui/animations/animation-decision-tree.png)  

만약 미리 package된 절대적인 animation이 너의 요구 사항에 맞는다면, [절대적인 animations과 함께한 Animation 기본들](https://www.youtube.com/watch?v=IVTjpW3W33s&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=2)을 보아라. 그리고 [동반한 기사](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)를 보아라. 

[![Animation Basics with Implicit Animations](http://img.youtube.com/vi/GXIJJkq_H8g/0.jpg)](https://youtu.be/GXIJJkq_H8g)

custom implicit animation을 만드는 것은  TweenAnimationBuilder와 함께 own custom implicit animations를 만든 것을 보여준다.[동반한 기사](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

[![Creating your own Custom Implicit Animations with TweenAnimationBuilder](http://img.youtube.com/vi/6KiPEqzJIKQ/0.jpg)](https://youtu.be/6KiPEqzJIKQ)
 

명백한 animation을 만드는 것은 아마도 명백한 animation 클래스들 built-in 중 하나를 사용할 수 있다.([동반한 기사](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7))

[![Making Your First Directional Animations with Built-in Explicit Animations](http://img.youtube.com/vi/CunyH6unILQ/0.jpg)](https://youtu.be/CunyH6unILQ)

만약 scratch로부터 명백한 animation이 build가 필요하다면, AnimatedBuilder와 AnimatedWidget이 함께 custom explicit(명백한) animations 만드는 것은 보여줘라.([동반한 기사](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8))  

[![Creating custom explicit animations with AnimatedBuilder & AnimatedWidget - Flutter in Focus](http://img.youtube.com/vi/fneC7t4R_B0/0.jpg)](https://youtu.be/fneC7t4R_B0)


animation을 단순한 깊은 이해를 위해 작업한다. 

[Animation 깊은 dive](https://www.youtube.com/watch?v=PbcILiN8rbo&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=6) 보여줘라.([동반한 기사](https://medium.com/flutter/animation-deep-dive-39d3ffea111f))  

[![Animation deep dive - Flutter in Focus](http://img.youtube.com/vi/PbcILiN8rbo/0.jpg)](https://youtu.be/PbcILiN8rbo)

<br/>

## Codelabs, 튜토리얼, 기사  

다음 resources는 Flutter animation framework를 배우기 시작하기 좋은 장소이다. 각각의 문서들은 animation code 작성법을 보여준다.  

* [Implicit(절대적인) animations codelab](https://docs.flutter.dev/codelabs/implicit-animations)  
단계별 지시서와 상호적인 예로 절대적인 animations 사용법을 다룬다.  

* [Animations 튜토리얼](https://docs.flutter.dev/development/ui/animations/tutorial)  
Flutter animation package(controllers, Animatable, curves, listeners, builders)를 기본적인 클래스들을 설명하라. animation API's의 다른 측면을 사용하여 20개의 animation 진행을 통해 안내한다.  

* [Zero to One with Flutter, part 1](https://medium.com/flutter/zero-to-one-with-flutter-43b13fd7b354) and [part 2](https://medium.com/flutter/zero-to-one-with-flutter-part-two-5aa2f06655cb)  
tweening을 사용한 animated된 차트를 만드는 법을 중간 기사들은 보여준다.  

* [Write your first Flutter app on the web](https://docs.flutter.dev/get-started/codelab-web)  
form을 만드는 법을 설명하는 Codelab은 fields안에 그들을 채워줌으로써 보여주는 유저들의 진행을 animation을 사용한다.  

<br/>

## Animation 유형들  

일반적으로, animation들은 **tween** 또는 **Physics-based(물리적 기반)** 이다. 다음 부문들은 용어 의미와 더욱 배울 때 resource의 중요한 점을 설명한다.  

<br/>

### Tween animation  
Tween animation에 타임라인, 타이밍과 변형의 속도를 정의한 curve를 시작과 끝 시점들에 정의된다. 

above한 Animations 튜토리얼 리스트된 문서는 tweening에 대해 명확하지 못하다. 그러나 예시들 중에서 tweens를 사용한다.

<br/>

### Physics-based(물리적 기반) animation  
Physics-based(물리적 기반) animation 안에 모션은 현실 세계 행위의 비슷한 본보기가 되어있다.  

* [Animate a widget using a physics simulation](https://docs.flutter.dev/cookbook/animation/physics-simulation)  
Flutter cookbook의 animation들의 부문 안에서의 레시피  

* [Flutter 갤러리](https://github.com/flutter/gallery)
Material Components 아래에 Grid 예시는 fling animation을 설명한다. grid와 Zoom 안으로부터 이미지 중 하나를 선택하라. flinging or dragging gestures의 이미지를 이동할 수 있다.  

* **AnimationController.animateWith**와 **SpringSimulation**을 위한 API 문서를 보아라  

<br/>

## Pre-canned(미리 취소된) animations  
만약 Material widgets을 사용 중이라면, 너는 pub.dev에서 이용 가능한지 animations package를 확인 할지도 모른다.  
package는 다음 공통적으로 사용된 패턴을 위한 미리 built된 animations를 포함한다: Container는 공유된 axis transitions(변형), transitions(변형)에 의한 fade(시들해진 것), 그리고 변형이 시들해진 것.  

<br/>

## Common animation patterns  
대부분 UX 또는 motion 디자이너는 UI 디자인을 할 때 반복하여 사용된 명확한 animation patterns를 찾는다. 공통적으로 사용된 animation patterns과 list된 이 부문은 더욱 배우라고 말한다.  

### Animated list or grid
이 패턴은 list와 grid로부터 요소들의 추가 또는 제거 animating된 것 포함한다.  
* [AnimatedList example](https://flutter.github.io/samples/animations.html)  
list에 요소를 추가하거나 선택한 요소를 제거하는 애니메이션 방법  

### Shared element transition  
이 패턴은 유저가 페이지로부터 종종 이미지의 요소를 선택한다. 그리고 UI는 더욱 디테일하게 새로운 페이지의 선택된 요소를 animate한다.  
* **Hero animations**의 2개의 스타일을 만드는 방법:  
  * position과 size가 변화하는 동안 hero 파일들이 한 페이지에서 다른 페이지로 넘어간다.
  * 파일들이 한 페이지에서 다른 페이지로 넘어감으로써 hero boundary는 원형에서 네모로 shape(모양)가 변화한다.  

* [Flutter 갤러리](https://github.com/flutter/gallery)  
자체적으로 갤러리 앱에 build 하거나 또는 Play Store로부터 다운로드를 할 수 있다.

* [Hero](https://api.flutter.dev/flutter/widgets/Hero-class.html), [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html), and [PageRoute](https://api.flutter.dev/flutter/widgets/PageRoute-class.html) class들의 API 문서를 보아라.  

### Staggered(엇갈린) animation  
작은 모션들이 부러진 Animations은 늦춰졌다. 가장 작은 animations 순차적으로 또는 부분적으로 또는 완전히 overlap(오버랩)된다.  
* [Staggered Animations](https://docs.flutter.dev/development/ui/animations/staggered-animations)  

<br/>

## Other resources  
다음 링크를 통해 **Flutter animations**에 대하여 더욱 배워라:  
* [Animation samples](https://github.com/flutter/samples/tree/main/animations#animation-samples) from the [Sample app catalog](https://flutter.github.io/samples/#).  

* [Animation recipes](https://docs.flutter.dev/cookbook/animation) from the Flutter cookbook.

* [Animation videos](https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw/search?query=animation) from the Flutter YouTube channel.

* [Animations: overview(개요)](https://docs.flutter.dev/development/ui/animations/overview)  
animations library와 Flutter’s animation 구조에서 주요한 클래스들을 본다.

* [Animation and motion widgets](https://docs.flutter.dev/development/ui/widgets/animation)  
animation widgets의 한 카탈로그는 Flutter APIs를 제공한다.

* The [animation library](https://api.flutter.dev/flutter/animation/animation-library.html) in the [Flutter API documentation](https://api.flutter.dev/)  
Flutter framework를 위한 animation API이다. 이 링크는 library(라이브러리)를 위한 기술적인 개요 페이지를 보여준다.
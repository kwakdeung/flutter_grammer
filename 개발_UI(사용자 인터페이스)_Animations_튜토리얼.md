# Animations tutorial(튜토리얼)  

> 배움  
> * animation library에서 animation to a widget로 기본적인 클래스들 사용법
> * **AnimatedWidget** vs **AnimatedBuilder** 사용할 때  

이 튜토리얼은 Flutter에서 **명백한 animation**을 build하는 법을 보여준다.  
animation library안에 **필수적인 개념들, 클래스들, 메서드들**을 소개 후에, **5가지 animation 예**들을 안내한다.  

**FadeTransition, SizeTransition, SlideTransition**과 같은 Flutter SDK built-in 명백한 animation을 또한 제공한다.

<br/>

## Essential animation concepts and classes(필수 animation 개념과 클래스)  

> **중요한 점**  
> * Flutter’s animation library안의 core 클래스의 **Animation**은 animation 가이드를 하기 위한 값들을 삽입한다.  
> * **Animation** 객체는 **animation의 현재 상태**를 안다. 그러나 스크린에서 나타나는 모든 것을 알지 못한다.  
> * **AnimationController**: Animation을 관리  
> * **CurvedAnimation**: non-linear **curve**로서 진행  
> * **Tween**은 animated된 객체에 의해 사용된 data 범위 사이에 삽입한다.
> * **Listener**(s) 와 **StatusListener**(s): animation 상태 변화 감시  

animation 시스템은 **Animation** 객체들의 유형이 based 되어있다.  

## - Animation&#60;double>  
Flutter Animation 객체는 스크린에서 무엇을 보여주는지 아무것도 모른다는 것을 알고 있다.   
Animation은 현재 값과 (완료 또는 해체)상태를 이해하는 추상 클래스이다.  
Animation&#60;double>: 많이 공통적으로 사용된 animation type들 중 하나  

## - Curved­Animation

**CurvedAnimation** 는 **non-linear curve**로서 animations 진행을 정의한다.  
```dart
animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
```  
>**참고:** Curves 클래스는 많은 일반적으로 사용된 curves 정의하거나 또는 사용자가 직접 생성한다.  
```dart
import 'dart:math';

class ShakeCurve extends Curve {
    @override
    double transform(double t) => sin(t * pi * 2);
}
```  
Curves 상수들의 완성한 list(visual 미리보기)를 위해 [**Curves**](https://api.flutter.dev/flutter/animation/Curves-class.html) 문서를 찾아봐라.  

(다음 섹션에서 설명된) CurvedAnimation과 AnimationController는 둘 다 Animation&#60;double> 유형이다.  
**CurvedAnimation**는 curve를 구현하기 위한 AnimationController의 하위클래스가 아닌 것을 수정하는 객체를 wrapping한다.  

## - Animation­Controller  

AnimationController은 하드웨어가 새로운 frame이 준비될 때 새로운 값이 생기는 특정한 Animation 객체이다.  
기본적으로, Animation­Controller는 주어진 기간의 0.0 ~ 1.0 사이의 수를 linearly으로 생성한다.  
```dart
controller = AnimationController(duration: const Duration(seconde: 2), vsync: this); 
// vsync: AnimationController 섹션 안의 vsync parameter 
```  
AnimationController는 Animation&#60;double>로부터 나온다. 그래서 Animation 객체가 필요하게 될 때 사용된다. 그러나 AnimationController는 animation을 컨트롤할 추가적인 메서드를 가진다.  
AnimationController을 생성할 때, **vsync** argument(인수)를 통과한다.  
vsync의 존재는 불필요한 resource를 방지한다.  

> **참고:** 경우에 따라 위치가 AnimationController의 0.0-1.0 범위에서 초과할 수 있다.  
심지어 그렇지 않은 AnimationController 경우에도 CurvedAnimation는 0.0에서 1.0 범위를 초과할 수 있다.  

## - Tween  
기본 AnimationController object의 범위: 0.0 ~ 1.0  
만약 **다른 범위 또는 다른 데이터 타입이 필요**하다면, 다른 범위와 다른 데이터 타입에 삽입한 animation으로 구성된 Tween을 사용할 수 있다.  

```dart
tween = Tween<double>(begin: -200, end: 0); 
// 0.0 ~ 1.0(input range) 범위에서 -200 ~ 0(output range) 으로 사용
```  
Tween은 시작과 끝의 범위가 상태변화가 없는 객체이다.  
Tween의 상속: Animatable&#60;T>로 부터, Animatable&#60;T>이 아닌 것으로부터.  
Animation과 같은 Animatable은 double을 output하지 않는다.  
예를 들어, ColorTween(명확한 두 color 사이의 진행)  
```dart
colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
```  
Tween object는 state를 저장하지 않는다.  
대신에, Animation 현재 값의 매핑 기능을 지원하는 evaluate(Animation&#60;double> animation) 메서드를 제공한다.  

### Tween.animate  
Tween 객체를 사용하는 것은 controller 객체를 통과시킨 **Tween의 animate()** 를 부른다.  
예를 들어, 기존 값에서 500 ms(milliseconds)를 넘는 0 to 255 범위 값 삽입 
```dart
AnimationController controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(controller);
```  
> **참고:** animate() 메서드는 Animatable이 아닌 것을 Animation으로 리턴한다.  

예를 들어(controller, curve, Tween),  
```dart
AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this); // controller
final Animation<double> curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // curve
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve); // Tween
)
```  

## - Animation notifications(공지)  

**Animation object:**  
addListener()와 addStatusListener() 함께 정의된 Listener(s) and StatusListener(s)를 가진다.  
**listener:** animation의 값이 변화할 때 부를 때, rebuild의 원인으로 setState()를 호출할 때.  
**StatusListener:** AnimationStatus에 의해 정의됨으로써 animation begins, ends, moves forward, or moves reverse를 호출할 때.

<br/>

# Animation examples(5가지)

## 1. Rendering(렌더링) animations  
> **중요한 점**  
> * **addListener()**와 **setState()**을 사용한 위젯의 **기본 animation을 추가**하는 방법  
> * 모든 시간의 Animation은 새로운 number와 생성하며, **addListener()**의 기능은 **setState()**를 호출한다.
> * 필요한 **vsync** parameter와 함께 **AnimationController**를 정의하는 방법
> * **Dart’s cascade 표기법**으로 알려진 “**..addListener**”안의 **“..” 구문** 이해
> * underscore (**_**)이 맨 앞에 들어간 **private 클래스**를 만드는 것  

<br/>

animation 없이 flutter 로고가 그려진 앱을 생각해봐라:  
```dart
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this); // vsync parameter: AnimationController 섹션
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    // dispose: State 객체를 영구적으로 없앨 때 호출
    controller.dispose();
    super.dispose();
  }
}

```

<br/>

## 2. Simplifying with Animated­Widget  

> **중요한 점**  
> * animates 위젯 생성하는 것의 helper 클래스 AnimatedWidget의 사용법
> * 재사용 가능한 animation을 수행하는 위젯을 생성하는 것을 AnimatedWidget을 사용한다. 위젯으로부터 변형을 분리하는 것은 AnimatedBuilder 부문과 함께 Refactoring를 보여줌으로써 AnimatedBuilder를 사용한다.
> * Flutter API 안 AnimatedWidget들의 예들: AnimatedBuilder, AnimatedModalBarrier, DecoratedBoxTransition, FadeTransition, PositionedTransition, RelativePositionedTransition, RotationTransition, ScaleTransition, SizeTransition, SlideTransition. 

```dart
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class AnimatedLogo extends AnimatedWidget {
  // AnimatedWidget: animation을 잡는 것을 상태 객체를 유지하기 위해 필요치 않다.
  // AnimatedLogo - 자체적으로 drawing 될 때 animation의 현재 값을 사용
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
// LogoApp - AnimationController과 Tween을 여전히 관리하고 AnimatedLogo의 Animation 객체를 통과시킨다. 
class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    // dispose: State 객체를 영구적으로 없앨 때 호출
    controller.dispose();
    super.dispose();
  }
}

```  

## 3. Monitoring the progress of the animation 
>**중요한 점**
> * starting, stopping 또는 reversing direction과 같이 animation들의 상태 변화의 공지를 위해 addStatusListener()를 사용해라.
> * animation이 완성되거나 시작 상태로 리턴될 때 거꾸로 direction을 함으로써 무한 루프에서 animation을 실행해라.
```dart
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
      // addStatusListener(): finishing, moving forward, reversing과 같은 상태 변화를 알려준다.
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((status) => print('$status'));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    // dispose: State 객체를 영구적으로 없앨 때 호출
    controller.dispose();
    super.dispose();
  }
}

```

## 4. Refactoring with AnimatedBuilder  
>**중요한 점**
> * AnimatedBuilder는 변화를 렌더(이루다)하는 방법을 이해한다.
> * AnimatedBuilder는 Animation 객체를 관리하지 못하고 위젯을 렌더하는 방법을 알지 못한다. 
> * 다른 위젯을 위한 build 메서드부분으로 animation을 설명하기 위해 AnimatedBuilder를 사용해라.
> * Flutter API 안 AnimatedBuilder들의 예들: BottomSheet, ExpansionTile, PopupMenu, ProgressIndicator, RefreshIndicator, Scaffold, SnackBar, TabBar, TextField.

animate3 예제 코드의 하나의 문제는 로고가 렌더하는 위젯의 변화가 요구된 animation이 변하고 있다.  
더 나은 해결책은 다른 클래스로 책임을 분리시킨다.  

* Render the logo
* Animation 객체 정의
* Render the transition

<br/>

AnimatedBuilder로 렌더 트리에서 클래스를 분리시킨다.

![](https://docs.flutter.dev/assets/images/docs/ui/AnimatedBuilder-WidgetTree.png)


```dart
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

// 위젯트리의 bottom 으로부터 시작한 렌더링 로고을 위한 코드는 정직하다.
class LogoWitget extends StatelessWidget {
  const LogoWitget({super.key});

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

// 다이어그램의 middle three blocks은 GrowTransition의 build() 메서드에서 모두 만들어졌다.
// GrowTransition 위젯: 자체적으로 상태가 변하지 않고, 변형 animation으로 정의된 final variables(변수)의 set를 hold한다.
class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Center(
      // AnimatedBuilder는 build() function은 만들고 리턴한다.
      // 렌더트리 안에서 두 위젯 사이에 삽입되었다.
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {  // initState() 메서드는 함께 animate()를 묶었을 때 AnimationController와 Tween을 생성한다.
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((status) => print('$status'));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      animation: animation,
      child: const LogoWitget(),
    );
  }

  @override
  void dispose() {
    // dispose: State 객체를 영구적으로 없앨 때 호출
    controller.dispose();
    super.dispose();
  }
}

```
animate2 example와 매우 비슷하다.


## 5. Simultaneous animations 
> **중요한 점**
> * Curves 클래스는 CurvedAnimation와 함께 사용할 수 있는 일반적으로 사용된 curve들로 array를 정의한다.

monitoring the progress of the animation (animate3)로 구성할 수 있다.  

각 tween은 animation의 측면을 관리한다. 예를 들면:
```dart
controller =
    AnimationController(duration: const Duration(seconds: 2), vsync: this);
sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);
```

```dart
import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

// sizeAnimation.value의 size와 opacityAnimation.value의 opacity와 함께 얻을 수 있지만, AnimatedWidget을 위한 생성자는 "단일" Animation 객체이다. 해결법은 자신의 Tween 객체들과 명시적으로 값을 계산하는 예를 만들어라.  

// Tween 객체들의 정해진 AnimatedLogo를 변화시키고 build() 메서드를 요구된 size와 opacity 값을 계산하기 위해 parent들의 animation 객체의 Tween.evaluate()을 호출해라.
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    // dispose: State 객체를 영구적으로 없앨 때 호출
    controller.dispose();
    super.dispose();
  }
}
```

<br/>

## 다음 단계  
튜토리얼은 Flutter에서 사용하는 Tween에서 animation을 생성하기 위한 기본을 주지만, 보아야 할 다른 클래스들이 많다. 특정한 Tween 클래스들, Material Design의 특정한 animation들, ReverseAnimation, 공유된 element transition들, 물리적 시뮬레이션들, fling() 메서드들.  
최신 문서와 예들을 위해 [animations landing page](https://docs.flutter.dev/development/ui/animations)를 봐라.
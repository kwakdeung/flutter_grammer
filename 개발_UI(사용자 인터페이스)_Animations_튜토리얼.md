# Animations tutorial(튜토리얼)  

> 배움  
> * animation library에서 animation to a widget로 기본적인 클래스들 사용법
> * **AnimatedWidget** vs **AnimatedBuilder** 사용할 때  

이 튜토리얼은 Flutter에서 **명백한 animation**을 build하는 법을 보여준다.  
animation library안에 **필수적인 개념들, 클래스들, 메서드들**을 소개 후에, **5가지 animation 예**들을 안내한다.  

**FadeTransition, SizeTransition, SlideTransition**과 같은 Flutter SDK built-in 명백한 animation을 또한 제공한다.

<br/>

## Essential animation concepts and classes(필수 animation 개념과 클래스)  

> 중요한 점  
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


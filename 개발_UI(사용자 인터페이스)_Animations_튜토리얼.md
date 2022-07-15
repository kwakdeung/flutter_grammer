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

## - Animation<double>  
Flutter Animation 객체는 스크린에서 무엇을 보여주는지 아무것도 모른다는 것을 알고 있다.   
Animation은 현재 값과 (완료 또는 해체)상태를 이해하는 추상 클래스이다.  
Animation<double>: 많이 공통적으로 사용된 animation type들 중 하나
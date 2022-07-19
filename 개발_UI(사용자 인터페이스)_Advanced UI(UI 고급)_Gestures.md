# Taps, drags, and other gestures  

이 문서는 Flutter에서 gestures에 대한 listen과 응답하는 방법을 설명한다.  
예를 들면, gestures include taps, drags, scaling  
Flutter에서 gesture system은 두 개의 분리된 layers를 가진다.  
**첫 번째 layer**는 screen을 넘어서 location과 pointers의 movement를 설명한 raw pointer events를 가진다.  
**두 번째 layer**는 하나 또는 more pointer movement를 구성하는 semantic actions를 설명한 gestures를 가진다.  

## Pointers
Pointers는 device's screen과 함께 유저의 interation에 대해 raw data를 나타낸다.  
pointer events의 4가지 유형:  
[PointerDownEvent](https://api.flutter.dev/flutter/gestures/PointerDownEvent-class.html)  
Pointer는 특정한 location에서 screen이 접촉된다.  

[PointerMoveEvent](https://api.flutter.dev/flutter/gestures/PointerMoveEvent-class.html)  
Pointer는 screen에서 하나의 location으로부터 다른 location으로 움직인다.  

[PointerUpEvent](https://api.flutter.dev/flutter/gestures/PointerUpEvent-class.html)  
Pointer는 screen을 접촉하는 것을 멈췄다.  

[PointerCancelEvent](https://api.flutter.dev/flutter/gestures/PointerCancelEvent-class.html)  
이 Pointer로부터 입력하는 것은 이 app 쪽으로 더 이상 directed(지시) 할 수 없다.
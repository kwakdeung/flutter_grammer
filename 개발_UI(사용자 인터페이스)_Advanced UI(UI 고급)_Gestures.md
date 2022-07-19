# Taps, drags, and other gestures  

이 문서는 Flutter에서 gestures에 대한 listen과 응답하는 방법을 설명한다.  
예를 들면, gestures include taps, drags, scaling  
Flutter에서 gesture system은 두 개의 분리된 layers를 가진다.  
**첫 번째 layer**는 screen을 넘어서 location과 pointers의 movement를 설명한 raw pointer events를 가진다.  
**두 번째 layer**는 하나 또는 more pointer movement를 구성하는 semantic actions를 설명한 gestures를 가진다.  

<br/>

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

<br/>

## Gestures  
Gestures는 multiple individual pointer events와 잠재적으로 심지어 multiple individual pointers로부터 받아들여진 semantic actions( ex) tap, drag, scale)을 나타낸다. Gestures는 gesture( ex) drag start, drag update, drag end)의 lifecycle에서 반응하는 multiple events를 dispacth를 할 수 있다:  

**Tap:**  

onTapDown  
tap을 야기시킬 수 있는 pointer는 특정한 location에 screen을 접촉한다.  

onTapUp  
tap을 trigger 할 pointer는 특정한 location에서 screen 접촉을 정지했다.  

onTap  
onTapDown에서 이전에 triggered된 pointer는 또한 ends up이 tap을 야기한 onTapUp에서 triggered가 된다.  

onTapCancel  
onTapDown이 이전에 triggered된 pointer는 tap을 야기시키는 end up 할 수 없다.

**Double tap:**  
onDoubleTap  
유저가 동일한 location에서 screen을 빠르게 두 번 연속으로 tap을 했다.

**Long press:**  
onLongPress  
pointer는 오랫동안 동일한 location에서 screen과 접촉이 여전했다.  

**Verticle drag:**  
onVerticalDragStart  
pointer는 screen을 접촉했고 vertically 움직이기 시작했다.  

onVerticalDragUpdate  
screen과 vertically로 움직임을 접촉한 pointer는 vertical 방향으로 움직였다.  

onVerticalDragEnd  
이전에 screen에 접촉하고 vertically 이동하던 pointer가 더 이상 screen에 접촉하지 않고 screen 접촉을 멈췄을 때 특정 속도로 이동하고 있었다.  

**Horizontal drag:**  
onHorizontalDragStart  
pointer는 screen을 접촉했고 horizontally 움직이기 시작할 것이다.  

onHorizontalDragUpdate  
screen을 접촉하고 horizontally 움직이는 pointer는 horizontal 방향으로 움직였다.  

onHorizontalDragEnd  
이전에 screen에 접촉하고 vertically 이동하던 pointer가 더 이상 screen에 접촉하지 않고 screen 접촉을 멈췄을 때 특정 속도로 이동하고 있었다.  

**Pan:**  
onPanStart  
pointer는 screen을 접촉했고 horizontally 또는 vertically 움직이기 시작할 것이다. 콜백은 만약 onHorizontalDragStart 또는 onVerticalDragStart set되어있다면 충돌을 야기시킨다.  

onPanUpdate  
pointer는 screen을 접촉하고 vertical 또는 horizontal 방향으로 움직인다. 콜백은 만약 onHorizontalDragUpdate 또는 onVerticalDragUpdate set되어있다면 충돌을 야기시킨다.  

onPanEnd  
이전에 screen에 접촉했던 pointer가 더 이상 screen에 접촉하지 않고 screen 접촉을 멈췄을 때 특정 속도로 이동한다.  
콜백은 만약 onHorizontalDragEnd 또는 onVerticalDragEnd되어있다면 충돌을 야기시킨다.  

<br/>

## Adding gesture detection to widgets
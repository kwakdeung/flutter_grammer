# Staggered animations  

> **배울 점**
> * 규칙적이거나 overlapping animations의 Staggered animation의 구성
> * staggered animation을 생성하는 것은, multiple Animation 객체를 사용해라.  
> * 모든 Animation들 중 하나의 AnimationController controls
> * 각 Animation 객체는 Interval 동안 animation은 명확하다.
> * 각 속성을 위해 animated 되었고, Tween을 생성한다.  

Staggered animations은 간단한 개념이다.  
> ### 예  
> [basic_staggered_animation](https://github.com/flutter/website/tree/main/examples/_animation/basic_staggered_animation)  
> 단일 위젯의 일련의 순차적이고 겹치는 애니메이션을 표시  
> [staggered_pic_selection](https://github.com/flutter/website/tree/main/examples/_animation/staggered_pic_selection)  
> 세 가지 크기 중 하나로 표시된 이미지 목록에서 이미지를 삭제하는 방법  

basic_staggered_animation 유튜브:  

[![Stagger Demo](http://img.youtube.com/vi/0fFvnZemmh8/0.jpg)](https://youtu.be/0fFvnZemmh8)

사각형은 다음과 같은 순서로 변경된다.  
1. Fades in
2. Widens(넓어짐)
3. 위로 움직이는 동안 taller가 커짐
4. bordered circle(테두리 있는 원)으로 변형
5. 오렌지 색으로 변화  

<br/>

## Basic structure of a staggered animation(기본 구조)  

> **중요한 점**  
> * 모든 animation들은 같은 AnimationController에 의해 움직인다.
> * 실시간으로 지속되는 것과 관계없이 controller’s의 값은 0.0에서 1.0 사이이다.  
> * 각 animation은 0.0 ~ 1.0의 Interval이다.  
> * interval에 animates한 각 속성을 위해 Tween을 생성한다. Tween 속성의 시작 및 끝 값을 지정한다.  
> * Tween은 controller로 관리된 Animation 객체를 생성한다.  

다음 다이어그램은 basic_staggered_animation 예제에서 사용된 Interval을 보여준다.  

* opacity(불투명도)는 타임라인의 처음 10% 동안 변경된다.
* opacity(불투명도)의 변화와 너비의 변화 사이에 작은 간격이 발생한다.
* 타임라인의 마지막 25% 동안에는 아무 것도 움직이지 않는다.
* padding을 늘리면 위젯이 위쪽으로 올라가는 것처럼 보인다.
* border radius(테두리 반경)을 0.5로 늘리면 모서리가 둥근 사각형이 원으로 변환된다.
* padding 및 height 변경은 정확히 동일한 간격 동안 발생하지만 반드시 그럴 필요는 없다.  
![](https://docs.flutter.dev/assets/images/docs/ui/animations/StaggeredAnimationIntervals.png)  

animation set up:  
* 모든 Animations을 관리하는 AnimationController 생성해라.
* Animated된 각 속성을 위해 Tween을 생성해라.
  * 값의 범위 정의됨
  * parent controller를 요구하고 속성을 위해 Animation을 생성한다.
* Animation들의 curve 속성을 interval을 지정해라.

다음 코드는 속성에 대한 Tween을 생성한다:  
```dart
width = Tween<double>(
  begin: 50.0,
  end: 150.0,
).animate(
  CurvedAnimation(
    parent: controller,
    curve: Interval(
      0.125, 0.250,
      curve: Curves.ease,
    ),
  ),
),
```  
BorderRadius.circular()을 사용하고 borderRadius 속성을 위한 tween을 build한 코드이다.
```dart
borderRadius = BorderRadiusTween(
  begin: BorderRadius.circular(4.0),
  end: BorderRadius.circular(75.0),
).animate(
  CurvedAnimation(
    parent: controller,
    curve: Interval(
      0.375, 0.500,
      curve: Curves.ease,
    ),
  ),
),
```  

<br/>

## Complete staggered animation  
모든 interactive 위젯과 같이, 완성한 Animation은 위젯(a stateless와 a stateful widget)을 쌍으로 구성한다.  

[basic_staggered_animation’s main.dart를 위한 full code](https://github.com/flutter/website/blob/main/examples/_animation/basic_staggered_animation/main.dart)

<br/>

## Stateless widget: StaggerAnimation  
build() 기능은 **AnimatedBuilder**가 구체적이다.
```dart
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({ Key key, this.controller }) :

    // Each animation defined here transforms its value during the subset
    // of the controller's duration defined by the animation's interval.
    // For example the opacity animation transforms its value during
    // the first 10% of the controller's duration.

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.100,
          curve: Curves.ease,
        ),
      ),
    ),

    // ... Other tween definitions ...

    super(key: key);

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius> borderRadius;
  final Animation<Color> color;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(
              color: Colors.indigo[300],
              width: 3.0,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
```

<br/>

## Stateful widget: StaggerDemo  
Stateful widget는 명확히 2000ms 정도의 AnimationController를 생성한다.
```dart
class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this
    );
  }

  // ...Boilerplate...

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color:  Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimation(
              controller: _controller.view
            ),
          ),
        ),
      ),
    );
  }
}
```
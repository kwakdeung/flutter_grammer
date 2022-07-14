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
  

명백한 animation을 만드는 것은 아마도 명백한 animation 클래스들 built-in 중 하나를 사용할 수 있다.([동반한 기사](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7))


[![Making Your First Directional Animations with Built-in Explicit Animations](http://img.youtube.com/vi/CunyH6unILQ/0.jpg)](https://youtu.be/CunyH6unILQ) 


만약 scratch로부터 명백한 animation이 build가 필요하다면, AnimatedBuilder와 AnimatedWidget이 함께 custom explicit(명백한) animations 만드는 것은 보여줘라.([동반한 기사](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8))  
![AnimatedBuilder와 AnimatedWidget이 함께 custom explicit(명백한) animations 만드는 것](https://youtu.be/fneC7t4R_B0)  
animation을 단순한 깊은 이해를 위해 작업한다. 

[![Creating your own Custom Implicit Animations with TweenAnimationBuilder](http://img.youtube.com/vi/6KiPEqzJIKQ/0.jpg)](https://youtu.be/6KiPEqzJIKQ)

[Animation 깊은 dive](https://www.youtube.com/watch?v=PbcILiN8rbo&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=6) 보여줘라.([동반한 기사](https://medium.com/flutter/animation-deep-dive-39d3ffea111f))  

[![Animation deep dive - Flutter in Focus](http://img.youtube.com/vi/PbcILiN8rbo/0.jpg)](https://youtu.be/PbcILiN8rbo)


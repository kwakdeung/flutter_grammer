# Hero animations  
> **배울 점**  
> * 스크린 사이를 날아다니는 위젯에 언급한 hero이다.
> * Flutter’s Hero 위젯을 사용하는 hero animation을 생성하라.
> * hero는 한 스크린에서 다른 스크린으로 난다.
> * 한 스크린에서 다른 스크린으로 날아다니는 동안 원에서 직사각형으로 hero’s 모양의 변화를 Animate해라.
> * Flutter의 Hero 위젯은 shared element transitions(변형) 또는 shared element animations로써 일반적으로 알려진 animation 스타일을 제공한다.  

<br/>

Hero 위젯 소개 비디오:  
[![Hero - Flutter Widget of the Week](http://img.youtube.com/vi/Be9UH1kXFDw/0.jpg)](https://youtu.be/Be9UH1kXFDw)  
이 가이드는 표준 hero animation들과 날아다니는 동안 원에서 사각형으로 이미지 변화의 hero animation들을 build 하는 법을 설명한다.  

> **예:** 가이드는 각 hero animation 스타일을 링크로 예를 제공한다.
> * [Standard hero animation code](https://docs.flutter.dev/development/ui/animations/hero-animations#standard-hero-animation-code)
> * [Radial hero animation code](https://docs.flutter.dev/development/ui/animations/hero-animations#radial-hero-animation-code)  

> **용어:**  
Route - Flutter앱의 페이지 또는 스크린  

hero는 UI의 작은 부분이다.  
hero animations을 생성하는 가이드를 보자:  

**Standard hero animations**  
standard hero animation은 한 route에서 새로운 route로 날아다닌다.(대체로 다른 loction과 size와 함께)  

유형적인 예를 보여주는 비디오:

[![Standard Hero Animation](http://img.youtube.com/vi/CEcFnqRDfgw/0.jpg)](https://youtu.be/CEcFnqRDfgw)  


**Radial hero animations**  
radial hero animation에서 hero는 route들 사이로 날아갈 때 모양이 원을 탭하면 원에서 직사각형으로 변경된다.  

[![Radial Hero Animation](http://img.youtube.com/vi/LWKENpwDKiM/0.jpg)](https://youtu.be/LWKENpwDKiM)  

hero animation의 기본 구조 &rarr; hero animation 코드를 구성하는 방법 &rarr; 장면 뒤에서 Flutter가 hero animation을 수행하는 방법
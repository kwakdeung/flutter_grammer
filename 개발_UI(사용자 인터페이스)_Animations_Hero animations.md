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

<br/>

## Basic structure of a hero animation(hero animation의 기본 구조)  

HeroAnimation 클래스는 source와 PhotoHeroes의 목적, 변형을 set up하도록 생성한다.  
Here’s the code:  
```dart
class HeroAnimation extends StatelessWidget {
    Widget build(BuildContext context) {
        timeDilation = 5.0 // 1.0 - 일반적인 animation 속도

        return Scafford(
            appBar: AppBar(
                title: const Text('Basic Hero Animation'),
            ),
            body: Center(
                child: PhotoHero(
                    photo: 'images/flippers-alpha.png',
                    width: 300.0,
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                                return Scaffold(
                                    appbar: Appbar(
                                        title: const Text('Flippers Page'),
                                    ),
                                    body: Container(
                                        // 파란 배경은 새로운 route로 강조한다.
                                        color: Colors.lightBlueAccent,
                                        padding: const EdgeInsets.all(16.0),
                                        alignment: Alignment.topLeft,
                                        child: PhotoHero(
                                            photo: 'images/flippers-alpha.png'
                                            width: 100.0,
                                            onTap: () {
                                                Navigator.of(context).pop();
                                            },
                                        ),
                                    ),
                                );
                            }
                        ));
                    },
                ),
            ),
        );
    }
}
```  

## Radial hero animations  

> **중요한 점**
> * radial 원에서 사각형으로 변형 animates해라.  
> * radial hero animation은 source route에서 destination route로 hero가 날아다니는 동안 radial 변형을 수행해라.
> * MaterialRectCenter­Arc­Tween에서 tween animation을 정의해라.
> * PageRouteBuilder를 사용하도록 destination route를 build해라  

> **Radial hero animation code**  
> * [radial_hero_animation](https://github.com/flutter/website/tree/main/examples/_animation/radial_hero_animation)  
> * [basic_radial_hero_animation](https://github.com/flutter/website/tree/main/examples/_animation/basic_radial_hero_animation)  
> * [radial_hero_animation_animate_rectclip](https://github.com/flutter/website/tree/main/examples/_animation/radial_hero_animation_animate_rectclip)

> **Pro tip:**  
개발 중에 debugPaintSizeEnabled flag를 사용하도록 고려해라.  

<br/>

## What’s going on?  
animation의 시작(t = 0.0)과 끝(t = 1.0)에서 잘린 이미지를 보여주는 다이어그램
![](https://docs.flutter.dev/assets/images/docs/ui/animations/radial-hero-animation.png)  

<br/>

## Photo class

```dart
class Photo extends StatelessWidget {
    Photo({ Key key, this.photo, this.color, this.onTap }) : super(key: key);

    final String photo;
    final Color color;
    final VoidCallback onTap;

    Widget build(BuildContext context) {
        return Material(
        // Slightly opaque color appears where the image has transparency.
        color: Theme.of(context).primaryColor.withOpacity(0.25),
        child: InkWell(
            onTap: onTap,
            child: Image.asset(
                photo,
                fit: BoxFit.contain,
                )
            ),
        );
    }
}
```  

<br/>

## RadialExpansion class  

RadialExpansion 위젯은 변형하는 동안 이미지 클립의 위젯 트리를 build한다.

![](https://docs.flutter.dev/assets/images/docs/ui/animations/radial-expansion-class.png)  

Here’s the code:  
```dart
class RadialExpansion extends StatelessWidget {
    RadialExpansion({
        Key key,
        this.maxRadius,
        this.child,
    }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

    final double maxRadius;
    final clipRectSize;
    final Widget child;

    @override
    Widget build(BuildContext context) {
        return ClipOval(
            child: Center(
                child: SizedBox(
                    width: clipRectSize,
                    height: clipRectSize,
                    child: ClipRect(
                        child: child,  // Photo
                    ),
                ),
            ),
        );
    }
}
```  
이 예제에서는 MaterialRectCenterArcTween 사용하는 tweening 삽입을 정의한다.

Here’s the code:  
```dart
static RectTween _createRectTween(Rect begin, Rect end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}
```  
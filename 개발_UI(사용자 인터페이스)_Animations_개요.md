# Animations overview(개요)  
Flutter의 animation system은 **유형이 있는 Animated 객체들** **기본적**이다.  

## Animation  
animation 시스템의 주요한 building block은 Animation 클래스이다.  
animation을 수행하는 대부분의 위젯은 animation의 현재 값을 읽고 해당 값의 변경 사항을 수신하는 parameter로 개체를 받는다.  
<br/>
### addListener  

**animation's의 값 변화**가 올 때, addListener와 함께 **추가된 모든 listeners에게 알린다**.  

이 패턴은 animations이 값이 변화할 때 위젯들이 rebuild 되어 도우는 두 개의 위젯들 일반적이다:**AnimatedWidget**, **AnimatedBuilder**  

**AnimatedWidget:**  
stateless animated 위젯들 중 가장 유용하다. 단순하게 하위 클래스이며 build 기능을 이행한다.

**AnimatedBuilder:**  
larger build function 부분으로써 animation을 포함하고 싶은 더욱 complex widget들에 유용하다.  
AnimatedBuilder 사용하는 것은 단순히 위젯을 구성하며, builder function을 통과한다.  

### addStatusListener  
Animations 또한 시간이 지남에 따라 animation 발전시킬 것을 지시하는 **AnimationStatus**를 제공한다. animation들의 **status(상태)가 변화**할 때, animation은 listener들에게 **추가된 addStatusListener를 함께 알린다.**  

<br/>

## Animation­Controller(제어)  
animation을 만드는 것은 첫 번째 AnimationController를 만든다. 또한 자체적인 animation이 되도록, AnimationController는 너에게 animation 제어를 시킨다.(예: forward or stop the animation)  

한 번 animation controller를 만든 후 이를 기반으로 다른 animation들로 building을 시작할 수(만들 수) 있다.  

<br/>

## Tweens  

0.0 to 1.0 사이를 지나 animate 하는 것은 시작과 끝 값 사이에 삽입하는 Tween<T>을 사용할 수 있다. 많은 타입들이 명확한 타입을 삽입하도록 제공하는 명확한 Tween 하위클래스이다.(예: ColorTween, RectTween)  
Tween과 lerp(lerp 메서드- 시계 값을 통해) function을 상속하는 너 자신의 하위 클래스로부터 만들어짐으로 자신의 interpolations을 정의할 수 있다.  

자체적으로, **tween**은 **2개의 값**으로 인해 **삽입 방법**을 단순히 정의한다.  
1. animation의 현재 가치에서 tween을 **evaluate(평가)**할 수 있다.  
이 접근 방식은 animation에 이미 listening하고, 앞으로 언제든지 animation 값이 변할 때 rebuilding하는 위젯들에 가장 유용하다.  

2. animation을 근거로 한 tween을 animate를 할 수 있다. 단일 값을 returning 하기 보다는 animate function은 tween으로 포함된 새로운 Animation으로 리턴한다. 이 접근 방식은 값 변화를 위해 listen 하는 것보다 tween이 포함된 현재 값을 읽을 수 있을 때 최근 만들어진 animation에서 다른 위젯으로 주기를 원할 때 가장 유용하다.  

<br/>

## Architecture
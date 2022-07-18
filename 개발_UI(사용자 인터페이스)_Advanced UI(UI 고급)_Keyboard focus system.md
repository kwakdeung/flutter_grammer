# Understanding Flutter's keyboard focus system(Flutter의 키보드 포커스 시스템 이해하기)  

이 문서에서는 키보드 입력 방향을 제어하는 방법에 대해 설명한다. 대부분의 데스크탑 및 웹 application과 같이 물리적 키보드를 사용하는 application을 구현하는 경우 이 페이지가 적합하다. 앱이 실제 키보드와 함께 사용하는 경우 이 단계를 건너뛴다.

<br/>

## Overview(개요)  
Flutter는 application의 특정한 부분의 키보드 입력을 direct하는 것의 focus 시스템과 함께 온다. 이것을 하기 위해서, 유저들은 훌륭한 UI element를 tapping 또는 클릭함으로써 application의 부분 위에 입력을 "focus"합니다. 
일반적으로 **Tab** 키에 연결되어 있는 특정 키보드 단축키를 눌러 focus를 이동할 수도 있으므로 "tab traversal(탭 탐색)"이라고도 합니다.  
Flutter application에서 이러한 작업을 수행하는 데 사용되는 API와 focus 시스템이 어떻게 작동하는지 살펴보자.  

<br/>

## Focus use cases(Focus 사용 사례)  

Focus 시스템을 사용하는 방법을 알아야 하는 상황의 몇 가지 예:  
* [Receiving/handling key events](https://docs.flutter.dev/development/ui/advanced/focus#key-events)(주요 이벤트 수신/처리)
* [Implementing a custom component that needs to be focusable](https://docs.flutter.dev/development/ui/advanced/focus#focus-widget)(focus가 가능해야 하는 유저 지정 구성 요소 구현)
* [Receiving notifications when the focus changes](https://docs.flutter.dev/development/ui/advanced/focus#change-notifications)(focus 변경 시 알림 수신)
* [Changing or defining the “tab order” of focus traversal in an application](https://docs.flutter.dev/development/ui/advanced/focus#focustraversalpolicy)(application에서 focus 탐색의 "focus traversal" 변경 또는 정의)
* [Defining groups of controls that should be traversed together](https://docs.flutter.dev/development/ui/advanced/focus#focustraversalpolicy)(함께 통과해야 하는 control 그룹 정의)
* [Preventing some controls in an application from being focusable](https://docs.flutter.dev/development/ui/advanced/focus#controlling-what-gets-focus)(application의 일부 control이 focus를 받을 수 없도록 방지)

<br/>

## Glossary(용어 사전)  

* **Focus tree** - 일반적으로 위젯 트리를 드물게 미러링하는 focus node tree는 focus를 받을 수 있는 모든 위젯을 나타낸다.
* **Focus node** - focus tree의 single node이다. 이 노드는 focus를 받을 수 있으며 focus chain의 일부일 때 "have focus(focus 있음)"이라고 한다. focus가 있을 때만 key event를 다루는데 참여한다.
* **Primary focus** - focus가 있는 focus tree의 root에서 가장 먼 focus node이다. 이것은 주요 이벤트가 primary focus node와 그 ancestors node로 전파되기 시작하는 focus node이다.
* **Focus chain** -  primary focus node에서 시작하여 focus tress의 root를 따라 focus tree의 root까지 이어지는 정렬된 focus node list이다.
* **Focus scope** - 다른 focus node 그룹을 포함하고 해당 node만 focus를 받을 수 있도록 하는 action을 수행하는 special focus node이다. 여기에는 하위 트리에서 이전에 focus를 맞춘 node에 대한 정보가 포함된다.
* **Focus traversal** - 한 focus 가능한 node에서 예측 가능한 순서로 다른 node로 이동하는 process이다. 이는 일반적으로 유저가 **Tab** 키를 눌러 다음 focus 가능한 control 또는 field로 이동할 때 응용 프로그램에서 볼 수 있다.  

<br/>

## FocusNode and FocusScopeNode  
FocusNode and FocusScopeNode 객체는 focus system의 mechanics를 실행한다. 위젯 트리의 build 간에 지속되도록 focus state와 속성을 유지하는 수명이 긴 개체(rendering 개체와 유사한 위젯보다 길음)입니다. 함께 focus tree data structure를 form(형성)한다.  

일반적으로 가장 유용한 것은 ancestor widget(상위 위젯)에서 requestFocus()를 호출하기 위해 descendant widget(하위 위젯)에 전달되는 상대적으로 opaque handle(불투명한 핸들)로 작동하는 것이다. 이 handle은 (하위 위젯)이 focus를 얻도록 요청합니다. 다른 속성의 설정은 사용하지 않거나 고유한 버전을 구현하지 않는 한 Focus 또는 FocusScope 위젯에서 가장 잘 관리됩니다.  

### Best practices for creating FocusNode objects(객체 생성을 위한 모범 사례)  
개체를 사용하는 것과 관련하여 해야 할 일과 하지 말아야 할 일에는 다음이 포함된다.  
* 각 build를 위해 새로운 FocusNode를 나누지 마라. memory가 부족하고, 때로는 위젯이 node가 focus하는 동안 rebuild 할 때 focus의 loss를 야기시킨다.
* stateful widget 에서 FocusNode와 FocusScopeNode 객체를 생성해라. FocusNode 와 FocusScopeNode를 사용할 때 생각할 필요가 있다. 그래서 stateful widget’s state 객체 내부에 오직 생성되어야 한다. 그들을 배치함으로 dispose를 상속할 수 있다.
* 여러 위젯들을 위해 FocusNode 사용하지 않는다.
* diagnosing focus issues와 함께 돕기 위해 focus node widget의 debugLable을 set해라.
* 만약 그들이 Focus 또는 FocusScope widget에 의해 관리된다면 FocusNode 또는 FocusScopeNode에서 onKey 콜백을 set 하지 마라.  
만약 primary focus가 가지길 원하지 않다면 canRequestFocus: false를 위젯에 Set해라. 무언가를 set 할수있는 또한 다음 build에서 Focus 위젯이 onKey 속성 때문이다. 그리고 만약 그것이 발생한다면 node를 set할 수 있게 onKey handler를 장황하게 써라.
* node가 requestFocus()를 호출 하여 primary focus를 받도록 요청해라.
* focusNode.requestFocus()를 사용해라. FocusScope.of(context).requestFocus(focusNode)에 전화할 필요가 없다. 이 focusNode.requestFocus()는 방법이 동등하고 더 성능이 좋다.  

### Unfocusing  
FocusNode.unfocus(): “give up the focus”라고 node가 말하기 위한 API.  
unfocus()를 부를 때, disposition unfocusing을 위한 구성은 두 모델( UnfocusDisposition.scope와 UnfocusDisposition.previouslyFocusedChild)을 허용한다.  

<br/>

## Focus widget

Focus widget는 focus node에서 소유하고 관리한다. 그리고 focus system의 workhorse이다.  

custom control focusable을 만들기 위해 포커스 위젯을 사용하는 방법을 보여주는 예이다.  
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
    const MyApp({super.key});
    static const String _title = 'Focus Sample';

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: _title,
            home: Scaffold(
                appBar: AppBar(title: const Text(_title)),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[MyCustomWidget(), MyCustomWidget()],
                ),
            ),
        );
    }
}

class MyCustomWidget extends StatefulWidget {
    const MyCustomWidget({super.key});

    @override
    State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
    Color _color = Colors.white;
    String _label = 'Unfocused';

    @override
    Widget build(BuildContext context) {
        return Focus(
            onFocusChange: (focused) {
                setState(() {
                    _color = focused ? Colors.black26 : Color.white;
                    _label = focused ? 'Focused' : 'Unfocused';
                });
            },
            child: Center(
                child: Container(
                    width: 300,
                    height: 50,
                    alignment: Alignment.center,
                    color: _color,
                    child: Text(_label),
                ),
            ),
        );
    }
}
```  

### Key events  
subtree에서 key event를 위한 listen하기를 바란다면, 단순히 key에서 listen하게 되고 또는 key를 다루고 다른 위젯에서의 전달을 stops하게 되도록 Focus 위젯의 onKey 속성을 set해라.  
Key events는 primary focus가 있는 focus node에서 시작한다.

다음 Focus은 subtree가 처리하지 않고 primary focus이 될 수 없는 모든 key를 흡수하는 위젯의 예이다:
```dart
@override
Widget build(BuildContext context) {
    return Focus(
        onKey: (node, event) => KeyEventResult.handled,
        canRequestFocus: false,
        child: child,
    );
}
```  
text field의 타입이 된 letter "a"의 허용을 원하지 않는 위젯의 예:
```dart
@override
Widget build(BuildContext context) {
    return Focus(
        onKey: (node, event) {
            return (event.logicalKey == LogicalKeyboardKey.keyA)
                ? KeyEventResult.handled
                : KeyEventResult.ignored;
        },
        child: TextField(),
    );
}
```
만약 intent를 validation에 입력한다면, 예들의 기능성은 TextInputFormatter를 사용함으로 아마도 더 잘 구현하고 있다. 그러나 이 기술은 여전히 유용할 수 있다: Shortcuts 위젯은 text가 입력되기 전에, shortcuts를 다루기 위해 이 메서드를 사용한다.  

### Controlling what gets focus(focus를 맞추는 항목 제어)  
focus의 main 측면 중 하나는 focus와 방법을 받을 수 있는 것이 controlling이다. 그 속성(canRequestFocus, skipTraversal, descendantsAreFocusable)은 focus process에서 node와 descendants가 참여하는 control한다.  
만약 skipTraversal이 true이면, 이 focus node는 focus traverasl(횡단)에 참여하지 않는다.  
canRequestFocus 속성은 Focus 위젯이 focus 요청을 하게 될 수있는 관리하는 focus node인지 아닌지 control한다.  
descendantsAreFocusable 속성은 node가 focus 를 받을 수 있는 descendants인지 control한다. 그러나 focus를 받는 이 node를 여전히 허용한다.  

### Autofocus
Focus 위젯의 속성을 설정하면 Focus 위젯이 속한 focus 범위가 처음으로 focus를 받을 때 focus를 요청하도록 위젯에 지시한다.  

autofocus 속성은 node가 속한 범위에 이미 focus가 없는 경우에만 적용된다.  

### Change notifications(공지 변경)
Focus.onFocusChanged 콜백은 특정한 node를 위한 focus state가 변화될 때 공지를 얻곤 하게 된다.  

### Obtaining the FocusNode  
때로는, 위젯의 속성을 조사하기 위해 focus 위젯의 FocusNode를 얻는 것이 유용하다.  
Focus 위젯의 ancestor으로부터 focus node를 허용하는 것은 FocusNode 속성의 Focus widget으로써 FocusNode에서 생성하고 통과한다.  

만약 같은 build 기능의 Focus 위젯의 FocusNode를 얻을 필요가 있다면, 올바른 context를 가지기 위해 반드시 Builder를 사용해라. 예를 보자:
```dart
@override
Widget build(BuildContext context) {
    return Focus(
        child: Builder(
            builder: (context) {
                final bool hasPrimary = Focus.of(context).hasPrimaryFocus;
                print('Building with primary focus: $hasPrimary');
                return const SizedBox(width: 100, height: 100);
            },
        ),
    );
}
```

### Timing
focus system의 세부 사항 중 하나는 focus가 요청될 때 현재 build 단계가 완료된 후에만 적용된다는 것이다. 즉, focus 변경은 현재 focus를 요청하는 위젯의 ancestors을 포함하여 Widget tree의 임의 부분을 다시 build할 수 있기 때문에 focus 변경은 항상 한 프레임만큼 지연된다.  

### FocusScope widget  
FocusScope 위젯은 FocusNode 대신에 FocusScopeNode를 관리하는 Focus 위젯의 특별한 버전이다. FocusScopeNode는 subtree에서 focus node를 위해 mechanism을 grouping하는 serve하는 focus tree에서 특별한 node이다.  
focus scope는 또한 subtree에서 focused된 현재 focus와 node들의 history의 track을 지킨다.  
Focus scopes는 만약 아무도 descendants에서 focus를 가지지 않는다면 focus를 리턴하는 장소로써 또한 serve한다.  

### FocusableActionDetector widget  
FocusableActionDetector는  Actions, Shortcuts, MouseRegion 기능을 조합한 위젯이다. 그리고 detector를 생성하기 위한 Focus 위젯은 actions, key bindings을 정의한다. 그리고 handling focusdhk hover highlights를 위한 콜백을 제공한다.  

### Controlling focus traversal  
유저가 **Tab** 키를 눌러 "다음" 컨트롤로 이동하는 "tab traversal(탭 순회)"입니다. "다음"이 무엇을 의미하는지 제어하는 ​​것이 이 섹션의 주제이다.  
focus 탐색을 위한 Flutter( )의 기본 알고리즘 ReadingOrderTraversalPolicy은 매우 훌륭하다.  

### - FocusTraversalGroup widget  
FocusTraversalGroup 위젯은 다른 위젯 또는 그룹 위젯을 움직이기 전에 full 탐색되어야 하는 위젯 subtree 주위 tree에 반드시 두어야 한다.  

TWO, ONE, THREE를 사용하는 NumericFocusOrder를 사용하기 위해 button의 row를 탐색하기 위해 FocusTraversalOrder 위젯 사용 방법의 예이다.
```dart
class OrderedButtonRow extends StatelessWidget {
    const OrderedButtonRow({super.key});

    @override
    Widget build(BuildContext context) {
        return FocusTraversalGroup(
            policy: OrederedTraversalPolicy(),
            child: Row(
                children: <Widget>[
                    const Spacer(),
                    FocusTraversalOrder(
                        order: NumericFocusOrder(2.0),
                        child: TextButton(
                            child: const Text('ONE'),
                            onPressed: () {},
                        ),
                    ),
                    const Spacer(),
                    FocusTraversalOrder(
                        order: NumericFocusOrder(1.0),
                        child: const Text('TWO'),
                        onPressed: () {},
                        ),
                    ),
                    const Spacer(),
                    FocusTraversalOrder(
                        order: NumericFocusOrder(3.0),
                        child: TextButton(
                            child: const Text('THREE'),
                            onPressed: () {},
                        ),
                    ),
                    const Spacer(),
                ],
            ),
        );
    }
}
```  
### - FocusTraversalPolicy  
FocusTraversalPolicy는 요청과 현재 focus node가 주어지면 다음 위젯을 결정하는 객체이다.  
요청(멤버 함수): findFirstFocus, findLastFocus, next, previous, inDirection  
FocusTraversalPolicy 정책 사용을 위한 추상적인 기본 클래스이다.(ReadingOrderTraversalPolicy, OrderedTraversalPolicy, the DirectionalFocusTraversalPolicyMixin classes)  
FocusTraversalPolicy를 FocusTraversalGroup에서 사용하기 위해서는 효과적인 정책일 위젯 subtree를 결정하는 FocusTraversalGroup에서 하나를 주어야한다.  

<br/>

## The focus manager  
FocusManager는 system을 위한 현재 primary focus를 유지한다. API의 focus system의 유저에게 유용한 몇몇의 pieces만 가진다.  
FocusManager.instance.primaryFocus 속성 중 하나는 현재 focused된 focus node가 포함하고 global primaryFocus field로부터 허용한다.  
다른 유용한 속성들은 FocusManager.instance.highlightMode와 FocusManager.instance.highlightStrategy이다. 그들은 focus highlights를 위한 touch 모드와 traditional 모드(마우스, 키보드) 사이에서 변화할 필요가 있는 위젯에 의해 사용되었다.  
Flutter에서 제공된 위젯은 이 정보의 사용법을 이미 안다. 그리고 만약 scratch로부터 자신의 controls 작성한다면 오직 필요하다. 너는 highlight mode에서 변화를 위해 listen하기 위한 addHighlightModeListener 콜백을 사용할 수 있다.
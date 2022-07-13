# Flutter 앱에 상호 작용 추가  

> 배울 내용
> * 탭에 응답하는 방법
> * 사용자 정의 위젯을 만드는 방법
> * 상태 비저장 위젯과 상태 저장 위젯의 차이점  

**user input(사용자 입력)에 반응**하도록 앱을 어떻게 수정합니까? 이 자습서에서는 비대화형 위젯만 포함하는 앱에 **대화형 기능을 추가**함. 특히 두 개의 상태 비저장 위젯을 관리하는 **사용자 정의 상태 저장 위젯을 만들어** 아이콘을 탭할 수 있도록 수정함.  

Layout Build 자습서 에서는 다음 스크린샷의 레이아웃을 만드는 방법을 보여주었습니다.  
![레이아웃 튜토리얼 앱](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes.jpg)   

앱 처음 실행시 별은 빨간색으로 고정되어 즐겨찾기에 추가되었음. 
색이 채워진 별 옆에 있는 숫자는 41명이 좋아했음을 나타냄. 
완료 후 별을 탭하면 즐겨찾기 상태가 제거되고 속이 비워진 별로 바뀌고 명수가 줄어듬.  
다시 클릭 시 채워진 별이 되어 명수가 추가됨.

![레이아웃 튜토리얼 앱](https://docs.flutter.dev/assets/images/docs/ui/favorited-not-favorited.png)  

별과 개수를 모두 포함하는 단일 사용자 지정 위젯을 만듬. 별표를 탭하면 두 위젯의 상태가 변경되므로 동일한 위젯에서 두 위젯을 모두 관리해야 함.  

2단계: Subclass StatefulWidget 에서 코드를 바로 터치할 수 있음.  

상태를 관리하는 다양한 방법을 시도하려면 상태 관리 설명으로 건너뛰기.

<br/>

## Stateful and stateless widgets(상태 저장 및 상태 비저장 위젯)  

Widget은 Stateful Widget 또는 Stateless Widget.  

Stateful Witget - 위젯 변경 가능, 동적
* 예) Checkbox, Radio, Slider, InkWell, Form, TextField  

Stateless Witget - 위젯 변경 불가능, 고정, 정적 
* 예) Icon, IconButton, Text

Widget의 State는 State 객체에 저장되어 위젯의 상태의 모양과 분리.  
setState() - widget의 state가 변경 시 state 객체는 setState() 호출하여 프레임워크에 widget을 다시 그리도록 지시

<br/>

## Creating a stateful widget(상태 저장 위젯 만들기)  
> ### **중요한 점**
> * stateful widget의 하위 클래스: 1. StatefulWitget의 하위 클래스 2. State의 하위 클래스
> * state class는 Widget의 변경 가능한 state와 build() method가 포함됨.  
> * widget의 상태가 변경되면, state 객체는 setState()를 호출하여 프레임워크에 widget을 다시 그리도록 지시.  

custom stateful widget(사용자 정의 상태 저장 위젯)을 구현하려면 2개의 class를 생성 
* StatefulWidget의 subclass(하위 클래스)는 widget을 정의함. 
* State의 subclass는 해당 widget의 state를 포함하고 widget의 build()메서드를 정의함.

<br/>

## 0단계: Get ready(준비 단계)
building layout tutorial(6단계) 앱 빌드 후  
  1. 환경설정 확인
  2. 기본 "Hello World" Flutter 앱 만들기
  3. lib/main.dart 파일을 [main.dart.](https://github.com/flutter/website/blob/main/examples/layout/lakes/step6/lib/main.dart)로 바꿈  
  4. pubspec.yaml 파일을 [pubspec.yaml](https://github.com/flutter/website/blob/main/examples/layout/lakes/step6/pubspec.yaml)으로 바꿉니다.
  5. 프로젝트에 image directory를 만들고 [lake.jpg](https://github.com/flutter/website/blob/main/examples/layout/lakes/step6/images/lake.jpg) 넣기  
  
장치를 연결하고 활성화했거나 iOS 시뮬레이터 또는 Android 에뮬레이터를 시작했다면 시작 가능함.  

<br/>

## 1단계: Decide which object manages the widget’s state(위젯의 상태를 관리하는 객체 결정)  

Widget 자체 FavoriteWidget가 자체 상태를 관리함.  

<br/>

## 2단계: StatefulWidget Subclass  
FavoriteWidget class는 자체 상태를 관리하므로 개체를 생성하기 위해 재정의함.  
프레임워크 - Widget을 build할 때 State를 호출  

이 예 에서 createState()는 다음 단계에서 구현할 _FavoriteWidgetState의 instance를 반환함.  

> lib/main.dart (FavoriteWidget)
```dart
class FavoriteWidget extends StatefulWidget {
    const FavoriteWidget({super.key});

    @override
    State<FavoriteWidget> createState() => _FavoriteWidgetState();
}
```
> **참고:** _(밑줄): private(비공개)  

<br/>

## 3단계: Subclass State  
_FavoriteWidgetState class는 Widget의 lifetime 동안 변경될 수 있는 변경 가능한 데이터를 저장함.  
> lib/main.dart (_FavoriteWidgetState fields)   
```dart
class _FavoriteWidgetState extends State<FavoriteWidget> {
    bool _isFavorited = true;
    int _favoriteCount = 41;

    // ··· 
}
```  
다음은 callback function을 정의함.  
> lib/main.dart (_FavoriteWidgetState build)  
```dart
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // ···
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                        padding: const EdgetInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: (_isFavorited
                            ? const Icon(Icons.star)
                            : const Icon(Icons.star_border)),
                        color: Colors.red[500],
                        onPressed: _toggleFavorite,
                    ),
                ),
                SizedBox(
                    width: 18,
                    child: SizedBox(
                        child: Text('$_favoriteCount'),
                    ),
                ),
            ],
        );
    },
}
```  
> **팁:** SizedBox에 Text를 배치하고 SizedBox 너비를 설정하면 Text가 값 40과 41 사이에서 변경될 때 식별 가능한 "jump"가 방지됨. 그렇지 않으면 해당 값의 width가 다르기 때문에 jump가 발생함.  

다음 두 상태 사이에서 UI를 전환하는 함수 인수 :
* star icon과 숫자 41
* star_border icon과 숫자 40

```dart
void _toggleFavorite() {
    setState(() {
        if (_isFavorited) {
            _favoriteCount -= 1;
            _isFavorited = false;
        } else {
            _favoriteCount += 1;
            _isFavorited = true;
        }
    });
}
```  

<br/>

## 4단계: Plug the stateful widget into the widget tree  
너의 custom stateful widget을 앱 build() method안에 있는 widget tree에 추가하라.
 1. 만든 icon과 Text를 코드를 위치시켜라, 그리고 지워라. 같은 위치에서 stateful widget을 만들어라.  
 > layout/lakes/{step6 → interactive}/lib/main.dart
 ```dart
 class MyApp extends StatelessWidget {
    const MyApp({super.key});
    //
                    ],
                ),    
            ),
            // - Icon()
            // -    Icons.star,
            // -    color: Colors.red[500],
            // - ),
            // - const Text('41'),
            const FavoriteWidget(), // +
            ],
        ),
    );
}
 ```  
 앱을 hot reload할때, 그 star icon은 지금 탭에 반응해야 한다.  

문제?  
만약 너가 코드를 실행할 수 없다면, 보라 너의 IDE에서 에러를 찾아라. 
여전히 찾을 수 없다면 Github 예제 코드와 비교하라.  

* [lib/main.dart](https://github.com/flutter/website/blob/main/examples/layout/lakes/interactive/lib/main.dart)  
* [pubspec.yaml](https://github.com/flutter/website/blob/main/examples/layout/lakes/interactive/pubspec.yaml)  
* [lakes.jpg](https://github.com/flutter/website/blob/main/examples/layout/lakes/interactive/images/lake.jpg)  

만약 너가 여전히 질문을 한다면, 개발 커뮤니티 채널에 물어봐라.  

widget's state를 관리할 수 있는 여러 방법을 다루고, 사용가능한 다른 대화형 interactive widget을 나열하라.  

<br/>

## Managing state(상태 관리)  
> **중요한 점**
> * Managing state를 다르게 접근하라.
> * 너는 widget 디자이너로써 사용 접근법을 선택해라
> * 만약 의심이 든다면, parent widget 안에서 managing state 시작해라

누가 stateful widget를 관리할까?  

manage state 하는 가장 일반적인 방법
* widget은 자체적 관리
* parent는 widget's state가 관리 
* A mix-and-match approach  

어떻게 사용하고 결정할까? 결정하기를 따르도록 원칙을 도와줘라:
* 만약 질문이 user date의 state라면, 그러면 state는 parent widget을 통해 가장 좋게 관리된다.
* 만약 미적인 질문의 state라면, state는 widget 자체적으로 인해 가장 좋게 관리된다.  

만약 의심이 든다면, parent widget 안에서 managing state 인한 시작해라.  

우리는 만들어진 3개의 단순한 예에 의한 managing state의 다른 방법의 예를 줄 것이다  
: TapboxA, TapboxB, and TapboxC  

![](https://docs.flutter.dev/assets/images/docs/ui/tapbox-active-state.png)
![](https://docs.flutter.dev/assets/images/docs/ui/tapbox-inactive-state.png)  

이 예제들은 Container에 포함된 캡쳐 활동에 GestureDetector를 사용한다.  

<br/>

## The widget manages its own state(자체 상태를 관리하는 위젯)  

때때로 내부 state widget to manage을 위한 가장 좋은 sense를 만든다.  
대부분의 개발자들은 ListView scorolling 행위를 관리하기를 원하지 않는 ListView를 사용중이다. 그래서 ListView는 scroll offset을 자체적으로 관리한다.  

_TapboxAState class:  
 * TapboxA를 위한 Manages state
 * box의 지금의 색깔을 결정하는 _active boolean을 정의하라
 * box가 탭 될때 그리고 UI를 업데이트를 하는 setState() 기능을 호출할 때 _active가 업데이트를 하는 _handleTap()의 기능을 정의하라.
 * widget을 위한 모든 상호적인 행위 요소를 구현하라  

```dart
import 'package:flutter/material.dart';

// TapboxA manages its own state.

//------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget {
    const TapboxA({super.key});

    @override
    State<TapboxA> createState() => _ TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
    bool _active = false;

    void _handleTap() {
        setState(() {
            _active = !_active;
        });
    }

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: _handleTap,
            child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    color: _active ? Colors.lightGreen[700] : Colors.grey[600],
                ),
                child: Center(
                    child: Text(
                        _active ? 'Active' : 'Inactive',
                        style: const TextStyle(fontSize: 32.0, color: Colors.white),
                    ),
                ),
            ),
        );
    }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: const Center(
            child: TapboxA(),
        ),
      ),
    );
  }
}
``` 

<br/>

## The parent widget manages the Widget's state(부모 위젯은 위젯 상태를 관리)  

종종 parent widget는 state 관리, 그것의 child widget은 업데이트 할 때 가장 sense 있다고 말한다.  
IconButton은 stateless widget이다.  

예를 들어, TapboxB는 callback을 통한 parent의 state를 내보낸다. 그 이유는 StatelessWidget은 subclass 하기 때문에 TapboxB는 어떠한 state에도 관리하지 않는다.  

ParentWidgetState class:  
* TapboxB를 위한 _active state를 관리
* box가 탭을 할 때 부르는 메서드, _handleTapboxChanged() 구현  
* state가 변경될 때, UI가 업데이트를 하기 위해 setState()를 호출  

TapboxB class:
* StatelessWidget을 상속한다. 그 이유는 모든 state는 parent에 의해 다뤄지기 때문이다.
* 탭이 감지될 때, parent에게 알린다.

```dart
import 'package:flutter/material.dart';

// ParentWidget manages the state for TapboxB.

//------------------------ ParentWidget --------------------------------
class ParentWidget extends StatefulWidget {
    const ParentWidget({super.key});

    @override
    State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
    bool _active = false;

    void _handleTapboxChanged(bool newValue) {
        setState(() {
            _active = newValue;
        });
    }

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            child: TapboxB(
                active: _active,
                onChanged: _handleTapboxChanged,
            ),
        );
    }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
    const TapboxB({
        super.key,
        this.active = false,
        required this.onChanged,
    });

    final bool active;
    final ValueChanged<bool> onChanged;

    void _handleTap() {
        onChanged(!active);
    }

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: _handleTap,
            child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    color: active ? Colors.lightGreen[700] : Colors.grey[600],
                ),
                child: Center(
                    child: Text(
                        active ? 'Active' : 'Inactive',
                        style: const TextStyle(fontSize: 32.0, color: Colors.white),
                    ),
                ),
            ),
        );
    }
}
``` 

<br/>

## A mix-and-match approach  

widget들 중 일부는, a mix-and-match approach가 가장 sense있다. 이 시나리오는, stateful widget은 일부 state를 관리하고 parent widget은 state의 다른 측면을 관리한다.  

예를 들어, TapboxC는 아래로 탭하면 box 주위 border(테두리)에 진한 초록이 나타난다.
탭하면 테두리가 사라지고 상자의 색상이 변경된다. TapboxC는 parent를 통해 _active state를 내보내지만 _highlight의 내부 state를 관리한다.  

_ParentWidgetState object:
* _active state 관리
* box가 탭이 될 때 부르는 메서드 _handleTapboxChanged() 구현
* 탭이 될 때 및 _active state 변화할 때 UI의 업데이트를 위해 setState()를 호출한다.  

The _TapboxCState object:
* _highlight state 관리
* GestureDetector는 모든 탭의 event들을 듣는다. 아래로 tap할 때, (진한 초록이 구현되는) highlight가 추가된다. 유저가 탭을 풀 때, highlight는 제거된다.
* 아래로 탭할 때, 위로 탭할 때 또는 탭이 취소될 때 그리고 _highlight state 변화할 때 UI의 업데이트를 위해 setState()를 호출한다.
* 탭 event에서 해당 state 변화를 parent widget에 전달해 widget 속성을 사용하여 통과한다.
```dart
import 'package:flutter/material.dart';

//---------------------------- ParentWidget ----------------------------
class ParentWidget extends StatefulWidget {
    const ParentWidget({super.key});

    @override
    State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
    bool _active = false;

    void _handleTapboxChanged(bool newValue) {
        setState(() {
            _active = newValue;
        });
    }

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            child: TapboxC(
                active: _active,
                onChanged: _handleTapboxChanged,
            ),
        );
    }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
    const TapboxC({
        super.key,
        this.active = false,
        required this.onChanged,
    });

    final bool active;
    final ValueChanged<bool> onChanged;

    @override
    State<TapboxC> createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
    bool _highlight = false;

    void _handleTapDown(TapDownDetails details) {
        setState(() {
            _highlight = true;
        });
    }

    void _handleTapUp(TapUpDetails details) {
        setState(() {
            _highlight = false;
        });
    }

    void _handleTapCancel() {
        setState(() {
            _highlight = false;
        });
    }

    void _handleTap() {
        widget.onChanged(!widget.active);
    }

  @override
  Widget build(BuildContext context) {
        // This example adds a green border on tap down.
        // On tap up, the square changes to the opposite state.
        return GestureDetector(
            onTapDown: _handleTapDown, // Handle the tap events in the order that
            onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
            onTap: _handleTap,
            onTapCancel: _handleTapCancel,
            child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
                    border: _highlight
                        ? Border.all(
                                color: Colors.teal[700]!,
                                width: 10.0,
                        )
                        : null,
                ),
                child: Center(
                    child: Text(widget.active ? 'Active' : 'Inactive',
                        style: const TextStyle(fontSize: 32.0, color: Colors.white)),
                ),
            ),
        );
    }
}
```  
개발자는 box가 활성 상태인지 여부를 중요하게 생각한다. 개발자는 강조 표시가 어떻게 관리되는지 신경 쓰지 않고, 탭 box가 이러한 세부 정보를 처리하는 것을 선호한다.  

<br/>

## Other interactive widgets

Flutter는 다양한 버튼과 유사한 대화형 위젯을 제공한다. 독창적인 UI로 구성 요소 집합을 정의하는  Material Design guidelines을 구현합니다. 원하는 경우 GestureDetector를 사용 하여 모든 사용자 정의 위젯에 상호 작용 기능을 구축할 수 있다. Flutter 요리책의 레시피인 핸들 탭 GestureDetector에 대해 자세히 알아보라.  

> **팁:** Flutter는 Cupertino라는 iOS 스타일 위젯 세트도 제공한다.  

<br/>

## 표준 위젯
* Form
* FormField
<br/>

## Material 구성 요소
* Checkbox
* DropdownButton
* TextButton
* FloatingActionButton
* IconButton
* Radio
* ElevatedButton
* Slider
* Switch
* TextField

<br/>

## 자원
앱에 대화형 기능을 추가할 때 도움이 될 수 있다.

[gestures](https://docs.flutter.dev/cookbook/gestures), [Flutter 요리책](https://docs.flutter.dev/cookbook)의 섹션

[gestures 처리](https://docs.flutter.dev/development/ui/widgets-intro#handling-gestures), [위젯 소개](https://docs.flutter.dev/development/ui/widgets-intro) 섹션  
버튼을 만들고 입력에 응답하도록 하는 방법.

[Flutter의 제스처](https://docs.flutter.dev/development/ui/advanced/gestures)  
Flutter의 제스처 메커니즘에 대한 설명이다.

[Flutter API 문서](https://api.flutter.dev/)  
모든 Flutter 라이브러리에 대한 참조 문서입니다.

Flutter Gallery [실행 앱](https://gallery.flutter.dev/), [repo](https://github.com/flutter/gallery)  
많은 Material 구성 요소와 기타 Flutter 기능을 보여주는 데모 앱.

[Flutter의 Layered 디자인](https://www.youtube.com/watch?v=dkyY9WCGMi0) (동영상)  
이 비디오에는 상태 및 상태 비저장 위젯에 대한 정보가 포함되어 있습니다. Google 엔지니어 Ian Hickson이 발표했다.
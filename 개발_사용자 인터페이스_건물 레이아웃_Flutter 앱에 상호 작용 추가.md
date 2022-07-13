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


//////////////
![]() 
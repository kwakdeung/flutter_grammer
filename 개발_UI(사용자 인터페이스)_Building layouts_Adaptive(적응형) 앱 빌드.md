# Adaptive(적응형) 앱 빌드  

## 개요  

Single 코드베이스에서 모바일, 데스크톱 및 웹에서 실행할 수 있는 앱을 build 할 수 있는 새로운 기회를 제공합니다.  
멀티 플랫폼일 뿐만 아니라 완전히 플랫폼 적응형인 앱을 빌드해야 합니다.

플랫폼 Adaptive(적응형) 앱 개발에 대한 3가지 주요 범주
* layout
* input(입력)
* 관용구와 규범  

[![Building platform adaptive apps | Session](http://img.youtube.com/vi/RCdeSKVt7LI/0.jpg)](https://youtu.be/RCdeSKVt7LI)  

<br/>

## Adaptive(적응형) layout 구축  

Adaptive(적응형) layout 구축의 고려사항
* 앱이 실행될 화면의 **다양한 크기와 모양**에 앱을 **적용**하는 방법  

<br/>

### Layout Widget

앱이나 웹 사이트를 구축해 왔다면 Responsive(반응형) 인터페이스를 만드는 데 익숙할 것이다.  
**Flutter 개발자**에게는 운 좋게도 이를 **더 쉽게** 만들어 주는 많은 위젯 세트가 있다.  

Flutter의 가장 유용한 layout 위젯  

**Single child**  
* Align: vertical(수직), horizontal(수평) - double: -1 ~ 1(double 값 사용)
* AspectRatio: child 위젯을 특정한 비율로 만드는 Class
* ConstrainedBox: child에 크기 제약을 부과하여 min 또는 max 크기를 제어
* CustomSingleChildLayout: Single child의 레이아웃을 지정하는 위젯. child의 layout 제약 조건과 위치를 결정할 수 있다.
* Expanded와 Flexible: 사용 가능한 공간을 채우기 위해 Row 또는 Column의 하위 항목을 축소하거나 확장할 수 있다.
* FractionallySizedBox: child 크기를 사용 가능한 공간의 일부로 조정
* LayoutBuilder: parent 크기에 따라 자체적으로 리플로우할 수 있는 위젯을 build한다.
* SingleChildScrollView: Single child 항목에 scroll을 추가. Row 또는 Column과 함께 자주 사용된다.  

<br/>

**Multichild**
* Column, Row, and Flex: Single 수평 또는 수직으로 child를 배치. Flex는 위젯 확장한다.
* CustomMultiChildLayout: 대리자 기능을 사용하여 레이아웃 단계에서 여러 자식을 배치
* Flow: CustomMultiChildLayout과 유사, layout 단계가 아닌 paint 단계에서 수행되기 때문에 더 효율적
* ListView, GridView, and CustomScrollView: scroll 가능한 child 목록을 제공
* Stack: Stack의 모서리를 기준으로 여러 자 피쳐를 레이어링하고 배치, CSS에서 위치 고정과 유사한 기능
* Table: 여러 Row과 Column을 결합하여 자식에 대한 클래식 테이블 layout 알고리즘을 사용
* Wrap: child를 여러 수평 또는 수직으로 표시  

Rendering? 화면에 표시할 웹 페이지/앱 화면을 만드는 과정
Paint 단계? layout에서 실제 화면에 반영되지 않기에 Render Tree를 다시 화면에 그려주는 과정

Flutter의 Rendering 3단계  
**레이아웃,배치(Layout)-페인트(Paint)-컴포지션,구도(Composition)**  
(출처:  
https://defineall.tistory.com/707,  
https://boxfoxs.tistory.com/408,  
https://velog.io/@broccolism/Flutter-%EC%9D%B4-%EC%BD%94%EB%93%9C..-%EC%96%B4%EB%96%BB%EA%B2%8C-%ED%94%BD%EC%85%80%EB%A1%9C-%EC%98%AE%EA%B2%A8%EC%A7%88%EA%B9%8C-%EB%A0%8C%EB%8D%94%EB%A7%81-%EC%9B%90%EB%A6%AC-3.-%ED%8E%98%EC%9D%B8%ED%8C%85)

사용 가능한 위젯과 예제 코드를 더 보려면 layout 위젯을 참조 

<br/>  

## VisualDensity(시각적 밀도)  

VisualDensity Class: 전체 애플리케이션에서 **보기 Density(밀도)를 쉽게 조정**할 수 있다.  

>특징
>* MaterialApp, MaterialComponents 위한 VisualDensity를 변경하면 밀도가 일치하도록 Animation을 지원
>* 기본적으로 horizontal(수평) 및 vertical(수직) 밀도는 모두 0.0으로 설정 -> 밀도를 원하는 음수 또는 양수 값으로 설정 가능
>* 다른 밀도 간에 전환하여 UI를 쉽게 조정  

![](https://docs.flutter.dev/assets/images/docs/development/ui/layout/adaptive_scaffold.gif)  

사용자 지정 VisualDensity(시각적 밀도)를 설정하려면 밀도를 MaterialApp 테마에 주입한다.  
```dart
double densityAmt = touchMode ? 0.0 : -1.0;
VisualDensity density =
    VisualDensity(horizontal: densityAmt, vertical: densityAmt);
return MaterialApp(
  theme: ThemeData(visualDensity: density),
  home: MainAppScaffold(),
  debugShowCheckedModeBanner: false,
);
```  

자신의 뷰 내부 VisualDensity에서 사용하려면 조회할 수 있다.

```dart
VisualDensity density = Theme.of(context).visualDensity;
```  
container(컨테이너)는 밀도 변화에 **자동으로 respon(반응)**할 뿐만 아니라 **변화할 때도 animation을 적용**합니다. 이렇게 하면 내부 구성 요소와 함께 user 지정 component를 연결하여 앱 전체에서 부드러운 전환 효과를 얻을 수 있다.

VisualDensity 표시된대로 단위가 없으므로 보기에 따라 다른 의미를 가질 수 있습니다. 이 예에서 1 밀도 단위는 6 pixel과 동일하지만 결정은 전적으로 귀하의 보기에 달려 있다. 단위가 없다는 사실은 매우 다재다능하며 대부분의 상황에서 작동해야 한다.

Material Components는 일반적으로 각 VisualDensity(시각적 밀도) 단위에 대해 약 4개의 논리적 pixel 값을 사용한다는 점에 주목할 가치가 있다. 지원되는 구성 요소에 대한 자세한 내용은 VisualDensity API를 참조  
일반적인 Density(밀도) 원칙에 대한 자세한 내용은 Material Design 가이드를 참조

<br/>

## Contextual layout(상황별 레이아웃)  

Density(밀도) 변경 이상의 것이 필요하고 필요한 위젯을 찾을 수 없는 경우 - 매개변수를 조정하고, 크기를 계산하고, 위젯을 교환하거나, 특정 폼 팩터에 맞게 UI를 완전히 재구성하는 것보다 **절차적인 접근 방식**을 취할 수 있다.

### 화면 기반 중단점: 가장 단순한 형태의 절차적 Layout  

**MediaQuery API**를 사용하여 이 작업을 수행 - Responsible(반응형) 
MediaQuery 위젯을 사용하는 대표적 이유: 현재 기기의 화면 크기를 구할 시 찾기 위해
(출처: https://mike123789-dev.tistory.com/entry/%ED%94%8C%EB%9F%AC%ED%84%B020-MediaQuery-%EA%B8%B0%EA%B8%B0-%EC%A0%95%EB%B3%B4-%EA%B5%AC%ED%95%98%EA%B8%B0)
```dart
class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}
```  
중단점을 사용하여 간단한 시스템을 설정하여 장치 유형을 결정  
```dart
ScreenType getFormFactor(BuildContext context) {
  // Use .shortestSide to detect device type regardless of orientation
  double deviceWidth = MediaQuery.of(context).size.shortestSide; //MediaQuery.of(context).size: 화면 크기
  if (deviceWidth > FormFactor.desktop) return ScreenType.Desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.Tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.Handset;
  return ScreenType.Watch;
}
```  
대안으로 더 추상화하고 크고 작은 관점에서 정의할 수 있다.
```dart
enum ScreenSize { Small, Normal, Large, ExtraLarge } // enum: 한정된 상수 값 집합을 나타내기 위해 사용

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide; 
  // shortestSide: 600p 미만
  // (출처: https://pub.dev/documentation/hy_flutter/latest/hy_flutter/ContextExt.html)
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  if (deviceWidth > 600) return ScreenSize.Large;
  if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.Small;
}
```  
화면 기반 중단점은 앱에서 최상위 수준의 결정을 내리는 데 가장 잘 사용된다.  
visual density(시각적 밀도), paddings, or font-sizes와 같은 변경 사항은 전역 기반으로 정의할 때 가장 좋습니다.  
최상위 위젯 트리를 reflow 할 수도 있습니다.  
예) handset 미사용 시 세로 layout에서 가로 layout으로 전환

```dart
bool isHandset = MediaQuery.of(context).size.width < 600;
return Flex(
    children: [Text('Foo'), Text('Bar'), Text('Baz')],
    direction: isHandset ? Axis.vertical : Axis.horizontal);
```  
다른 위젯에서는 일부 child 항목을 완전히 바꿀 수 있다.
```dart
Widget foo = Row(
  children: [
    ...isHandset ? _getHandsetChildren() : _getNormalChildren(),
  ],
);
```  

<br/>

## Use LayoutBuilder for extra flexibility(추가 유연성을 위해 LayoutBuilder 사용)  

LayoutBuilder 클래스: **Widget의 크기를 확인하고 지정**  
(출처: https://velog.io/@quddkflty/Dart-LayoutBuilder)  

필요할 때  
* 전체 화면 크기를 확인하는 것이 전체 화면 페이지나 global layout 결정에 적합하지만 중첩된 child 보기에는 적합하지 않은 경우(종종 하위 뷰에는 **자체 내부 중단점**이 있으며 **Rendering에 사용할 수 있는 공간에만** 관심)  

```dart
Widget foo = LayoutBuilder(
    builder: (context, constraints) {
  bool useVerticalLayout = constraints.maxWidth < 400.0;
  return Flex(
    children: [
      Text('Hello'),
      Text('World'),
    ],
    direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
  );
});
```  
* 측면 (panel)패널, dialog(대화 상자) 또는 전체 화면 보기 내에서 구성  
* 제공되는 공간에 따라 layout을 조정  

<br/>

## Device segmentation(기기 세분화)  
**크기에 관계없이** 실행 중인 실제 플랫폼을 기반으로 **레이아웃 결정**을 내리고 싶을 때 

사용 중인 플랫폼 조합을 확인하려면 다음 값 kIsWeb과 함께 Platform API를 사용할 수 있습니다.  

```dart
bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
bool get isDesktopDevice =>
    !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
```  

dart.io 패키지가 웹 대상에서 지원되지 않기 때문에 예외를 throw 하지 않고 웹 빌드에서 Platform API에 액세스할 수 없다. 결과적으로 이 코드는 웹을 먼저 확인하고 단락으로 인해 Dart는 Platform 웹 대상을 호출하지 않는다.  

<br/>

## Single source of truth for styling(스타일링을 위한 소스)  

padding, spacing(간격), corner shape(모서리 모양), font sizes 등과 같은 값을 **styling하기 위한 Single 소스를 생성**하면 보기를 **유지 관리하기가 더 쉬울 것**입니다. 이것은 일부 도우미 클래스를 사용하여 쉽게 수행할 수 있습니다.  
```dart
class Insets {
  static const double xsmall = 3;
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
  
}

class Fonts {
  static const String raleway = 'Raleway';
  // etc
}

class TextStyles {
  static const TextStyle raleway = const TextStyle(
    fontFamily: Fonts.raleway, 
    // fontFamily: 글꼴을 정하는 속성
    // raleway - 폰트 종류 중 하나
  );
  static TextStyle buttonText1 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle buttonText2 =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 11);
  static TextStyle h1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  static TextStyle h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static late TextStyle body1 = raleway.copyWith(color: Color(0xFF42A5F5)); 
  // late 연산자: 변수의 초기화를 지연시켜줌, null 허용 X, 해당 변수가 사용되기 전에만 변수를 초기화 하면 됨 (출처: https://medium.com/flutter-korea/flutter%EC%9D%98-null-safety-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-dd4ee1f7d6a5)
  // .copyWith: 플러터 위젯 속성값 변경, 여기서는 raleway 속성 값(글꼴 색상 0xFF42A5F5)으로 변경 적용(출처: https://dev-nam.tistory.com/13)
  // etc
}
```  
그런 다음 하드 코딩된 숫자 값 대신 다음 상수를 사용할 수 있다.
```dart
return Padding(
  padding: EdgeInsets.all(Insets.small),
  child: Text('Hello!', style: TextStyles.body1),
);
```  

일반적인 Design 시스템 범주
* Animation 타이밍
* Sizes and breakpoints(크기 및 중단점)
* Insets and paddings
* Corner radius(코너 반경)
* Shadow
* Strokes
* Font families, sizes, and styles  
<br/>

(일반적인 Design 시스템 범주) 예외사항  
* (앱의 다른 곳에서는 사용되지 않는)일회성 값
* 동일한 의미 값의 재사용 또는 중복(도 관찰) -> Global Style 지정 규칙 집합에 추가  

<br/>

## Design to the strengths of each form factor(각 폼 요소의 장점을 고려한 설계)  

화면 크기 외에도 **다양한 폼 요소의 고유한 강점과 약점을 고려**하는 데 시간을 투자해야 한다. 멀티 플랫폼 앱이 모든 곳에서 동일한 기능을 제공하는 것이 항상 이상적인 것은 아니다. 일부 Device 범주에서 **특정 기능에 중점**을 두거나 **특정 기능을 제거**하는 것이 합리적인지 고려해라.  

중요한 점: 각 플랫폼이 **가장 잘하는 것**이 무엇인지 생각하고 **활용할 수 있는 고유한 기능**이 있는지 확인하는 것  

> **예:**  
>1. 모바일 Device는 휴대가 가능하고 카메라가 있지만 세부적인 창작 작업에는 적합하지 않다.  
>2. 웹의 극히 낮은 공유 장벽을 활용하는 것.  

<br/>

## 신속한 Test를 위해 Desktop Build 타겟 사용  

adaptive(적응형) 인터페이스의 가장 효과적인 테스트 방법: Desktop Build 대상을 활용  

앱 실행 중 창 크기를 쉽게 조정하여 다양한 화면 크기를 미리 볼 수 있음.
-> Hot reload와 결합되어 Responsive(반응형) UI 개발을 크게 가속화  
![](https://docs.flutter.dev/assets/images/docs/development/ui/layout/adaptive_scaffold2.gif)  

<br/>

## Touch를 먼저 해결  

**부분적**으로는 오른쪽 클릭, 스크롤 휠 또는 키보드 단축키와 같은 **입력 가속기가 없기** 때문에 **뛰어난 Touch UI를 구축**하는 것이 기존 Desktop UI보다 **어려움**  
이 문제에 접근하는 한 가지 방법: 처음에 훌륭한 Touch 지향 UI에 집중(주의: 확인을 위해 mobile Devie로 자주 전환하기)  
<br/>

Touch interface를 다듬은 후 마우스 사용자의 visual density(시각적 밀도)를 조정한 다음 모든 추가 입력에 layer(레이어)를 적용할 수 있다.  
위 내용의 고려사항  
* 사용자가 특정 input Device를 사용할 때 기대하는 것  
* 이를 앱에 반영하기 위해 노력하는 것  

<br/>

## Input(입력)  

다양한 user input도 지원해야 합니다.  
마우스와 키보드 - 스크롤 휠, 마우스 오른쪽 버튼 클릭, hover 상호 작용, 탭 탐색 및 키보드 단축키와 같은 touch Device에서 볼 수 있는 것 이상의 input 유형을 도입

<br/>

## Scroll wheel(스크롤 휠)  

Scroll(스크롤) 위젯은 기본적으로 Scroll wheel(스크롤 휠)과 같은 ScrollView이거나 ListView를 지원하며, 거의 모든 스크롤 가능한 user 정의 위젯이 이 중 하나를 사용하여 구축되기 때문에 이 위젯과도 작동  

사용자 지정 스크롤 동작을 구현해야 하는 경우  
:Listener 위젯을 사용하여 UI가 Scroll wheel(스크롤 휠)에 response(반응)하는 방식을 사용자 지정할 수 있습니다.  
```dart
return Listener( 
  // Listener: 비동기 기능을 실행할 때 활용하는 기법 (출처: https://velog.io/@oo0o_o0oo/Flutter-animation)
    onPointerSignal: (event) {
      if (event is PointerScrollEvent) print(event.scrollDelta.dy);
    },
    child: ListView());
```

<br/>

## Tab traversal and focus interactions(탭 순회 및 포커스 상호 작용)  

탭 상호 작용의 2가지 고려 사항
 1. 포커스가 위젯에서 위젯으로 이동하는 방식(순회라고 함)
 2. 위젯에 포커스가 있을 때 표시되는 visual 강조 표시  

Button 및 Textfield와 같은 대부분의 기본 제공 Component : 순회 및 강조 표시 지원  

순회에 포함하려는 고유한 위젯이 있는 경우 이 FocusableActionDetector 위젯을 사용하여 고유한 컨트롤을 만들 수 있다.  
Actions, Shortcuts, MouseRegion및 Focus 위젯의 기능을 결합하여 작업 및 key binding을 정의하고 focus 및 hover 강조 표시를 처리하기 위한 콜백을 제공하는 Detector(감지기)를 만든다.  
```dart
class _BasicActionDetectorState extends State<BasicActionDetector> {
  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      // FocusableActionDetector 위젯 - 순회에 포함하려는 고유한 위젯이 있는 경우 고유한 컨트롤 만듦
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(onInvoke: (intent) { // 콜백: 다른 함수에 인수로 전달됨(출처: https://onlyfor-me-blog.tistory.com/47)
          // Intent: 의지
          print('Enter or Space was pressed!');
          return null;
        }),
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          FlutterLogo(size: 100),
          // Position focus in the negative margin for a cool effect
          if (_hasFocus)
            Positioned(
                left: -4,
                top: -4,
                bottom: -4,
                right: -4,
                child: _roundedBorder())
        ],
      ),
    );
  }
}
```  

### 순회 순서 제어  
사용자가 탭을 누를 때 위젯이 집중되는 순서를 더 잘 제어하려면 FocusTraversalGroup를 사용하여 탭을 이동할 때 그룹으로 처리되어야 하는 트리 섹션을 정의할 수 있다.  

예를 들어, submit 버튼을 탭하기 전에 양식의 모든 필드를 탭할 수 있다.
```dart
return Column(children: [
  FocusTraversalGroup( // 탭을 이동할 때 그룹으로 처리되어야 하는 트리 섹션을 정의
    child: MyFormWithMultipleColumnsAndRows(),
  ),
  SubmitButton(),
]);
```  

위젯과 그룹을 순회하는 기본 제공 방법
* 기본적인 ReadingOrderTraversalPolicy 클래스
* TraversalPolicy 클래스
* user 지정 정책을 만들어 이를 수정  

ReadingOrderTraversalPolicy: 현재 Directionality 에 대한 자연스러운 **읽기 순서**로 순서를 설명하는 정책  

(출처: https://api.flutter.dev/flutter/widgets/FocusTraversalPolicy-class.html)

<br/>

## 키보드 가속기  

속도를 내기 위한 다양한 키보드 단축키를 사용하는 데 익숙합니다. 키보드 가속기도 이와 같다.  
TextField 또는 Button 이미 focus node가 있는 Single 위젯이 있는 경우 이를 RawKeyboardListener에 wrapping하고 키보드 event를 listen(수신)할 수 있다.

```dart
 @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) {
        if (event is RawKeyDownEvent) {
          print(event.logicalKey);
        }
        return KeyEventResult.ignored;
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
```  
트리의 큰 섹션에 키보드 단축키 세트를 적용하려면 Shortcuts 위젯을 사용할 수 있다.  
```dart
// Define a class for each type of shortcut action you want
class CreateNewItemIntent extends Intent {
  const CreateNewItemIntent();
}

Widget build(BuildContext context) {
  return Shortcuts(
    // Bind intents to key combinations
    shortcuts: <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyN, control: true):
          CreateNewItemIntent(),
    },
    child: Actions(
      // Bind intents to an actual method in your code
      actions: <Type, Action<Intent>>{  
        // 제네릭: <>, 프로그래머의 실수가 컴파일 과정에서 발견되지 않는다. 메소드 하나에 대해 제네릭으로 정의
        CreateNewItemIntent: CallbackAction<CreateNewItemIntent>(
            onInvoke: (intent) => _createNewItem()),
      },
      // Your sub-tree must be wrapped in a focusNode, so it can take focus.
      child: Focus(
        autofocus: true,
        child: Container(),
      ),
    ),
  );
}
```  
Shortcuts 위젯은 이 위젯 트리 또는 그 자식 중 하나에 focus가 있고 표시될 때만 바로 가기를 실행할 수 있기 때문에 유용하다.

마지막 옵션은 전역 수신기입니다. 이 리스너는 항상 켜져 있는 앱 전체 단축키 또는 표시될 때마다 단축키를 허용할 수 있는 패널에 사용할 수 있습니다(초점 상태에 관계없이. 다음을 사용하면 전역 리스너를 RawKeyboard 함께 쉽게 추가할 수 있다.  
```dart
void initState() {
  super.initState();
  RawKeyboard.instance.addListener(_handleKey);
}

@override
void dispose() {
  RawKeyboard.instance.removeListener(_handleKey);
  super.dispose();
}
```  
전역 listener로 키 조합을 확인하려면 RawKeyboard.instance.keysPressed 맵을 사용할 수 있다. 예를 들어, 다음과 같은 방법은 제공된 키가 누르고 있는지 여부를 확인할 수 있다.  
```dart
static bool isKeyDown(Set<LogicalKeyboardKey> keys) {
  return keys.intersection(RawKeyboard.instance.keysPressed).isNotEmpty;
}
```  
이 두 가지를 함께 Shift+N 눌렀을 때 Action을 실행할 수 있다.  
```dart
void _handleKey(event) {
  if (event is RawKeyDownEvent) {
    bool isShiftDown = isKeyDown({
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.shiftRight,
    });
    if (isShiftDown && event.logicalKey == LogicalKeyboardKey.keyN) {
      _createNewItem();
    }
  }
}
```  
정적 listener를 사용할 때 주의할 점
 * user가 필드에 입력하거나 연결된 위젯이 보기에서 숨겨져 있을 때 **종종 비활성화**해야 한다는 것  

Shortcuts 또는 RawKeyboardListener와 달리 이는 user의 관리 책임입니다. 이것은 Delete에 대한 Delete/Backspace 가속기를 binding 할 때 특히 중요할 수 있지만 user가 입력할 수 있는 TextFields의 child가 있다.  

<br/>

## 마우스 입력, 종료 및 hover

데스크탑에서는 일반적으로 마우스 커서를 올려 놓고 있는 콘텐츠에 대한 기능을 나타내기 위해 마우스 커서를 변경한다. 예를 들어, 일반적으로 버튼 위로 마우스를 가져가면 손 모양 커서가 표시 I되고 텍스트 위로 마우스를 가져가면 커서가 표시된다.

Material Component 세트에는 표준 Button 및 Text cursor에 대한 지원이 **내장되어** 있습니다. 자신의 위젯 내에서 **커서를 변경**하려면 MouseRegion을 사용해라.

```dart
// Show hand cursor
return MouseRegion( // 마우스 커서 변경
  cursor: SystemMouseCursors.click, // cursor: 마우스 커서
  // Request focus when clicked
  child: GestureDetector(
    onTap: () {
      Focus.of(context).requestFocus();
      _submit();
    },
    child: Logo(showBorder: hasFocus),
  ),
);
```  

MouseRegion는 user 정의 Roll over 및 Hover 효과를 만드는 데에도 유용하다.

```dart
return MouseRegion(
  onEnter: (_) => setState(() => _isMouseOver = true),
  onExit: (_) => setState(() => _isMouseOver = false),
  onHover: (e) => print(e.localPosition),
  child: Container(
    height: 500,
    color: _isMouseOver ? Colors.blue : Colors.black,
    // 삼항연산자: (수식) ? true : false,
    // onEnter - true: _isMouseOver = true
    // onExit - false: _isMouseOver = false
  ),
);
```  

<br/>

## Idioms and norms(관용구와 규범)  
Adaptive(적응형) 앱에 대해 마지막으로 고려해야 할 영역은 플랫폼 표준이다.  

* **인지 부하 감소** - 사용자의 기존 멘탈 모델을 일치시켜 작업을 수행하는 것이 **직관적**이 되어 생각이 덜 필요하고 **생산성이 향상**되며 좌절감이 줄어든다.

* **신뢰 구축** — 애플리케이션이 기대에 부응하지 않을 때 사용자는 경계하거나 의심할 수 있습니다. 반대로 친숙한 UI는 사용자의 신뢰를 구축하고 품질에 대한 인식을 개선하는 데 도움이 될 수 있다. 이것은 종종 더 나은 앱 스토어 평가의 추가 이점을 제공한다.

<br/>  

## Consider expected behavior on each platform(각 플랫폼에서 예상되는 동작 고려)  

* 이 플랫폼에서 예상되는 모양, 프레젠테이션 또는 동작이 무엇인지 고려하는 데 시간을 할애하는 것, 거기에서 거꾸로 작업해라.  
* "이 플랫폼의 사용자가 어떻게 이 목표를 달성할 것으로 기대할까요?"라고 묻는 것  
플랫폼의 일반 사용자가 아닌 경우 어려울 수 있습니다. 특정 관용구를 알지 못할 수 있으며 쉽게 완전히 놓칠 수 있다.  
<br/>

### Find a platform advocate(플랫폼 옹호자 찾기)  

가능하면 각 플랫폼의 advocate(옹호자)로 누군가를 지정해라. 이상적으로는 옹호자가 플랫폼을 기본 device로 사용하고 의견이 많은 user의 관점을 제공할 수 있다.   
인원 수를 줄이려면 역할을 결합하십시오.(Windows 및 Android 지지자 1명, Linux 및 웹 지지자 1명, Mac 및 iOS 지지자 1명을 두십시오.)  

목표: 각 플랫폼에서 앱이 훌륭하게 느껴지도록 지속적이고 정보에 입각한 피드백을 받는 것이다.  
옹호자들은 자신의 기기에 있는 일반적인 응용 프로그램과 다르다고 느끼는 모든 사항을 매우 까다롭게 말하도록 권장해야 한다. 간단한 예는 대화 상자의 기본 버튼이 일반적으로 Mac 및 Linux의 경우 왼쪽에 있지만 Windows의 경우 오른쪽에 있는 방법이다. 플랫폼을 정기적으로 사용하지 않는 경우 이러한 세부 정보를 놓치기 쉽다.  
> **중요:** 옹호자는 개발자나 정규 팀원일 필요가 없다. 그들은 디자이너, 이해 관계자 또는 일반 build와 함께 제공되는 외부 테스터가 될 수 있습니다.  

<br/>

### 독특함 유지  

여러 플랫폼에서 스타일과 동작을 통합할 수 있을수록 개발 및 테스트가 더 쉬워진다. **각 플랫폼의 규범을 존중**하면서 **강력한 정체성**으로 독특한 경험을 만드는 균형을 유지하는 것이다.  

<br/>

## 고려해야 할 일반적인 관용구 및 규범  

<br/>

### Scrollbar 모양 및 동작  

```dart
 return Scrollbar(
  thumbVisibility: DeviceType.isDesktop, // thumbVisibility: 스크롤이 진행 중이 아닐 때도 스크롤 막대 썸이 표시되어야 함을 나타냅니다.
  // (출처: https://api.flutter.dev/flutter/material/Scrollbar/thumbVisibility.html)
  controller: _scrollController,
  child: GridView.count(
      controller: _scrollController,
      padding: EdgeInsets.all(Insets.extraLarge),
      childAspectRatio: 1,
      crossAxisCount: colCount,
      children: listChildren),
);
```  
### Multi-select(다중 선택)  

```dart
static bool get isSpanSelectModifierDown =>
    isKeyDown({LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.shiftRight});
```  
제어 또는 명령에 대한 **플랫폼 인식 검사**를 수행하려면 다음과 같이 작성할 수 있습니다.  
```dart
static bool get isMultiSelectModifierDown {
  bool isDown = false;
  if (Platform.isMacOS) {
    isDown = isKeyDown(
        {LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.metaRight});
  } else {
    isDown = isKeyDown(
        {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.controlRight});
  }
  return isDown;
}
```  
키보드 사용자를 위한 마지막 고려 사항: **모두 선택** 작업  

### Touch devices(터치 장치)  

터치 장치에서 다중 선택은 일반적으로 단순화되며 예상되는 동작은 데스크탑에서 isMultiSelectModifier 다운되는 것과 유사합니다. 탭 한 번으로 항목을 선택하거나 선택 취소할 수 있으며 일반적으로 **모두 선택** 또는 현재 **선택 지우기** 버튼이 있습니다.

다양한 장치에서 다중 선택을 처리하는 방법은 특정 사용 사례에 따라 다르지만 중요한 것은 각 플랫폼에 가능한 최고의 상호 작용 모델을 제공하고 있는지 확인하는 것입니다.

### SelectableText(선택 가능한 텍스트)  

웹(및 덜한 데스크탑)에서 일반적인 기대는 가장 눈에 띄는 Text를 마우스 cursor로 선택할 수 있다는 것이다. text를 선택할 수 없는 경우 웹 사용자는 부정적인 반응을 보이는 경향이 있다.  
```dart
return SelectableText('Select me!');
```
서식 있는 text를 지원하려면 TextSpan을 사용해라.  
```dart
return SelectableText.rich(
  TextSpan( // TextSpan: 글자와 문장을 모아 문단을 구성하게 함.
    children: [
      TextSpan(text: 'Hello'),
      TextSpan(text: 'Bold', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
```  

### Title bars(제목 표시줄)  
최신 데스크톱 응용 프로그램에서는 앱 창의 title 표시줄을 사용자 지정하는 것이 일반적이다. 
기본 UI의 **세로 공간을 절약**하는 데 도움이 되도록 더 강력한 브랜딩 또는 상황별 컨트롤을 위한 로고를 추가한다.  

![](https://docs.flutter.dev/assets/images/docs/development/ui/layout/titlebar.png)  


위의 그림과 같이 bits_dojo 패키지를 사용하여 기본 제목 표시줄을 비활성화하고 고유한 제목 표시줄로 바꿀 수 있습니다.

이 패키지를 사용하면 내부에 순수한 Flutter 위젯을 사용하기 때문에 원하는 TitleBar 위젯을 추가할 수 있다. 이렇게 하면 앱의 다른 section으로 이동할 때 title 표시줄을 쉽게 조정할 수 있다.  

### Context menu(상황에 맞는 메뉴) 및 tooltips(도구 설명)  
* **Context menu(상황에 맞는 메뉴)** - 일반적으로 마우스 오른쪽 버튼을 클릭하면 상황에 맞는 메뉴가 마우스 가까이에 배치되며 아무 곳이나 클릭하거나 메뉴에서 옵션을 선택하거나 메뉴 외부를 클릭하면 닫힌다.
* **tooltips(도구 설명)** - 일반적으로 대화형 요소 위에 200-400ms 동안 마우스를 올려놓으면 tool 설명이 트리거되며 tool 설명은 일반적으로 위젯에 고정되고(마우스 위치와 반대) 마우스 커서가 해당 위젯을 떠날 때 사라진다.
* **Popup panel(=플라이아웃)** - tool 설명과 유사하게 팝업 패널은 일반적으로 위젯에 고정된다. 주요 차이점은 패널은 탭 이벤트에서 가장 자주 표시되며 일반적으로 커서가 떠날 때 스스로를 숨기지 않는다는 것이다. 대신 일반적으로 패널 외부를 클릭하거나 닫기 또는 제출 버튼을 눌러 패널을 닫는다.  

Flutter에서 기본 Tooltip을 표시하려면 내장 Tooltip 위젯을 사용해라.  
```dart
return const Tooltip(
  message: 'I am a Tooltip',
  child: Text('Hover over the text to show a tooltip.'),
);
```  

사용 가능한 일부 package
* context_menus(컨텍스트 메뉴: 마우스 오른쪽 버튼을 클릭하거나 길게 누를 때 상황에 맞는 메뉴를 표시하는 패키지)
* anchored_popups(마우스 오른쪽 버튼을 클릭하거나 길게 누를 때 상황에 맞는 메뉴를 표시하는 패키지)
* flutter_portal(Flutter의 내장 Overlay / OverlayEntry 에 대한 개선 및 대체)
* super_tooltip(매우 유연하며 화면 오버레이에 도구 설명을 표시)
* custom_pop_up_menu(위젯 감싸기, 탭 또는 길게 이 위젯을 누르면 팝업 메뉴가 적절한 위치에 표시)  

### Horizontal button order(가로 버튼 순서)  
Windows 버튼 행 표시: 확인 버튼은 행 시작(왼쪽)에 배치
다른 모든 플랫폼: 반대
이것은 Row에 TextDirection 속성을 사용하여 Flutter에서 쉽게 처리할 수 있다.  

```dart
TextDirection btnDirection = 
  DeviceType.isWindows ? TextDirection.rtl : TextDirection.ltr;
return Row(
  children: [
    Spacer(),
    Row(
      textDirection: btnDirection,
      children: [
        DialogButton(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context, false)),
        DialogButton(
          label: 'Ok', onPressed: () => Navigator.pop(context, true)),      
      ],
    ),
  ],
);
```  

![](https://docs.flutter.dev/assets/images/docs/development/ui/layout/embed_image1.png)  
Ok와 Cancel: 가로 버튼 순서  

### Menu bar(메뉴바)  
데스크탑 앱의 또 다른 일반적인 패턴은 메뉴 모음입니다.  

### Drag and drop(끌어서 놓기)  
터치 기반 및 포인터 기반 입력의 핵심 상호 작용 중 하나는 **끌어서 놓기**다.  

* 사용자 정의 모양과 느낌을 위해 Draggable및 DragTarget API를 직접 사용해라.
* onPan Gesture Event에 연결하고 Parent Stack 내에서 직접 개체를 이동한다.
* pub.dev에 미리 만들어진 목록 Package 중 하나를 사용한다.  

<br/>

## 기본 사용성 원칙에 대해 교육

* Responsive(반응형) UI 레이아웃에 대한 Material 가이드라인
* 대형 스크린을 위한 Material 디자인
* 고품질 앱 빌드(Android)
* UI 디자인 해야 할 것과 하지 말아야 할 것(Apple)
* 휴먼 인터페이스 지침(Apple)
* Responsive(반응형) Design 기법(Microsoft)
* 머신 크기 및 중단점(Microsoft)

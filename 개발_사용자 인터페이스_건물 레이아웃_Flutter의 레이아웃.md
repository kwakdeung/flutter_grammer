# Flutter의 레이아웃  

> ## 포인트는 무엇인가?
>  * 위젯은 UI를 빌드하는 데 사용되는 클래스입니다.  
>  * 위젯은 레이아웃과 UI 요소 모두에 사용됩니다.
>  * 간단한 위젯을 구성하여 복잡한 위젯을 만듭니다.  

**Flutter 레이아웃** 메커니즘의 핵심은 **위젯**입니다.  

> Flutter에서는 거의 모든 것이 **위젯**
>  * 앱에서 보이는 것: 이미지, 아이콘, 텍스트
>  * 앱에서 보이지 않는 것: 보이는 위젯을 정렬, 제한 및 정렬하는 행, 열 및 그리드와 같은 위젯  
>  * 위젯을 구성하여 더 복잡한 위젯을 빌드하여 레이아웃을 만듭니다.  

> **참고:** 이 자습서의 대부분의 스크린샷은 시각적 레이아웃을 볼 수 있도록 true로 설정된 상태로 debugPaintSizeEnabled 표시됩니다. 자세한 내용은 시각적으로 레이아웃 문제 디버깅, Flutter 관리자 사용 섹션을 참조하세요.  

<br/>

**UI의 Widget Tree 다이어그램**
 
![](https://docs.flutter.dev/assets/images/docs/ui/layout/sample-flutter-layout.png)

**Container => Row => Column => Icon, Container => text**  

<br/>

## 위젯 레이아웃  

Flutter에서 단일 위젯을 배치  

## 1. 레이아웃 위젯 선택  
일반적으로 포함된 위젯에 전달되므로 보이는 위젯을 정렬하거나 제한하는 방법에 따라 다양한 레이아웃 위젯 중에서 선택합니다.  

## 2. 보이는 위젯 만들기  
예를 들어 Text위젯을 만듭니다.  
```dart
Text('Hello World'),
```  
Image 위젯을 만듭니다.  
```dart
Image.asset(
  'images/lake.jpg',
  fit: BoxFit.cover,
),
```   
Icon 위젯을 만듭니다.  
```dart
Icon(
  Icons.star, // Icons.모양
  color: Colors.red[500],
),
```  
## 3. 레이아웃 위젯에 보이는 위젯 추가  
모든 레이아웃 위젯에는 다음 중 하나가 있습니다.  

  * child 속성 예를 들어, 자녀가 한 명인 경우 (예: Center 또는 Container)
  * children 속성 위젯 목록을 사용하는 경우 (예: Row,Column,ListView 또는 Stack)  

Center 위젯에 Text 위젯 추가 :
```dart
const Center(
  child: Text('Hello World'),
),
```  

## 4. 페이지에 레이아웃 위젯 추가  
Flutter 앱은 그 자체로 위젯이며 대부분의 위젯에는 build()메서드가 있습니다. 앱의 build()메서드에서 위젯을 인스턴스화하고 반환하면 위젯이 표시됩니다.

### Material apps(머티리얼 앱)
Scaffold 위젯을 사용할 수 있습니다.   
기본 배너, 배경색을 제공하며 서랍, 스낵바 및 하단 시트를 추가하기 위한 API가 있습니다. 그런 다음 Center 위젯을 홈페이지의 body 속성에 직접 추가할 수 있습니다.  

>lib/main.dart (MyApp)
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```  
> **참고**: Material 라이브러리는 Material 디자인 원칙을 따르는 위젯을 구현합니다.  
UI를 디자인할 때 표준 위젯 라이브러리 의 위젯만 사용 하거나 재질 라이브러리의 위젯을 사용할 수 있습니다. 두 라이브러리의 위젯을 혼합하거나 기존 위젯을 사용자 정의하거나 고유한 사용자 정의 위젯 세트를 빌드할 수 있습니다.  

### Non-Material apps  

Material이 아닌 Center앱의 경우 앱의 build()메서드에 위젯을 추가할 수 있습니다.  
  * AppBar, 제목 또는 배경색이 포함되지 않습니다.(이러한 기능을 원하면 직접 빌드해야 함.)

>lib/main.dart (MyApp)
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
```  

<br/>

## 여러 위젯을 Row(수평, 세로) 및 Column(수직, 가로)로 배치  
: 가장 일반적인 레이아웃 패턴  
> ### 포인트는 무엇인가?  
>  * Row와 Column 가장 일반적으로 사용되는 두 가지 레이아웃 패턴입니다.
>  * Row와 Column 각각은 자식 위젯의 목록을 가져옵니다.
>  * 자식 위젯은 그 자체가 Row, Column 또는 기타 복잡한 위젯일 수 있습니다.
>  * Row 또는 Column은 자식을 수평, 세로 및 수직, 가로로 정렬 하는 방법을 지정할 수 있습니다.
>  * 특정 하위 위젯을 늘리거나 제한할 수 있습니다.
>  * 여러 개의 Row 또는 Column의 사용 가능한 공간을 하위 위젯이 사용하는 방법을 지정할 수 있습니다.  

<br/>
이 레이아웃은 Row 로 구성됩니다. Column 에는 두 개의 자식이 있습니다. 왼쪽에 Column이 있고 오른쪽에 이미지가 있습니다.

![](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-diagram.png)  
<br/>
왼쪽 Column의 위젯 트리는 Row과 Column을 중첩합니다.  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-left-column-diagram.png)  

Nesting rows and columns 에서 Pavlova의 레이아웃 코드 중 일부를 구현합니다.  
> **참고:** Row 및 Column은 수평 및 수직 레이아웃을 위한 가장 일반적인 기본 위젯입니다. 이러한 하위 수준 위젯은 최대 사용자화를 허용합니다. Flutter는 또한 귀하의 요구에 충분할 수 있는 전문화된 더 높은 수준의 위젯을 제공합니다. 예를 들어, 선행 및 후행 아이콘에 대한 속성과 최대 3줄의 텍스트가 있는 사용하기 쉬운 위젯을 Row 대신에 선호할 수 있습니다 . Column 대신에 내용이 너무 길어 사용 가능한 공간에 맞지 않는 경우 자동으로 스크롤되는 열과 같은 ListView 레이아웃을 선호할 수 있습니다. 자세한 내용은 공통 레이아웃 위젯을 참조하십시오.

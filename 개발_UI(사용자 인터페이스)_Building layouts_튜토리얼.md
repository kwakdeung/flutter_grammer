# Building layouts(레이아웃 빌드)  

> ## 배울 내용
> * Flutter의 레이아웃 메커니즘이 작동하는 방식
> * 위젯을 vertically 및 horizontally로 배치하는 방법
> * Flutter 레이아웃을 구축하는 방법  

<br/>
Flutter에서 레이아웃을 빌드하는 방법에 대한 가이드입니다.  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes.jpg)  
완성된 앱  

 Flutter의 레이아웃 접근 방식을 설명하고 화면에 단일 위젯을 배치하는 방법을 보여줍니다.  
 위젯을 horizontally 및 vertically으로 배치하는 방법에 대한 논의 후에 가장 일반적인 레이아웃 위젯 중 일부를 다룹니다.  

<br/>

## 0단계: 앱 기본 코드 만들기  

환경설정 확인 후 다음을 수행하십시오.  

  1. 기본 "Hello World" Flutter 앱을 만듭니다.
  2. appBar 제목과 앱 제목을 다음과 같이 변경합니다.  


```dart
// 0단계: 앱 기본 코드 만들기
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          // title: const Text('Welcome to Flutter'),  
          title: const Text('Flutter layout demo'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
```  

<br/>

## 1단계: 레이아웃 다이어그램  

레이아웃을 기본 요소로 나누는 것
* Row과 Column을 식별합니다.
* 레이아웃에 Grid가 포함되어 있습니까?
* overlapping(겹치는) 요소가 있습니까?
* UI에 탭이 필요합니까?
* alignment, padding 또는 borders가 필요한 영역을 확인합니다.  

먼저, 더 큰 요소를 식별합니다. 이 예에서 4개의 요소(이미지, Row 2개, 텍스트 블록)가 열로 정렬됩니다.  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes-column-elts.png)  

다음, 각 Row을 도표화하십시오. 제목 섹션이라고 하는 첫 번째 행에는 텍스트 Column, 별표 아이콘 및 숫자라는 3개의 하위 항목이 있습니다. 첫 번째 자식인 Column에는 2줄의 텍스트가 있습니다. 첫 번째 Column은 많은 공간을 차지하므로 Expanded 위젯으로 래핑되어야 합니다.

![](https://docs.flutter.dev/assets/images/docs/ui/layout/title-section-parts.png)  

Button 섹션이라고 하는 두 번째 Row에도 3개의 자식이 있습니다. 각 자식은 아이콘과 텍스트를 포함하는 Column입니다.  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/button-section-diagram.png)  

레이아웃을 도표화한 후에는 이를 구현하기 위해 상향식 접근 방식을 취하는 것이 가장 쉽습니다. 깊게 중첩된 레이아웃 코드의 시각적 혼란을 최소화하려면 일부 구현을 변수와 함수에 배치합니다.  

<br/>

## 2단계: 제목 행 구현  

먼저 제목 섹션에 왼쪽 column을 만듭니다. MyApp 클래스의 build() 메서드 상단에 다음 코드를 추가합니다.  

```dart
// 2단계: 제목 행 구현
Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        // Expanded 위젯을 내부에 Column을 넣으면 Row에 남아 있는 모든 여유 공간을 사용하도록 Column이 늘어납니다.
        // Row의 시작 부분에 Column을 배치 하도록 crossAxisAlignment 속성을 CrossAxisAlignment.start을 설정합니다.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            // 텍스트의 첫 번째 행을 Container 안에 넣으면 패딩을 추가할 수 있습니다. 텍스트의 두 번째 자식 Column도 회색으로 표시됩니다.
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      // 제목 행의 마지막 두 항목은 빨간색으로 칠해진 별 아이콘과 텍스트 "41"입니다.
      // 전체 Row는 Container에 있으며 각 가장자리를 따라 32픽셀로 채워집니다.
      // 다음과 같이 앱 본문에 제목 섹션을 추가합니다.
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      const Text('41'),
    ],
  ),
);
```  

> **팁:**  
> * 코드를 앱에 붙여넣을 때 들여쓰기가 비뚤어질 수 있습니다. 자동 재포맷 지원을 사용하여 Flutter 편집기에서 이 문제를 해결할 수 있습니다.
> * 더 빠른 개발 경험을 위해 Flutter의 hot reload 기능을 사용해 보세요.
> * 문제가 있는 경우 코드를 lib/main.dart와 비교하라.  

<br/>

## 3단계: 버튼 행 구현  

버튼 섹션에는 동일한 레이아웃을 사용하는 3개의 Column(텍스트 Row 위의 아이콘)이 있습니다. 이 Row의 Column 간격은 균일하고, 텍스트와 아이콘은 기본 색상으로 칠해집니다.  

각 Column을 작성하는 코드가 거의 동일하기 때문에 buildButtonColumn()라는 이름의 개인 도우미 메서드를 만들고 색상, Icon 및 Text를 사용하고 위젯이 지정된 색상으로 칠해진 Column을 반환합니다.  

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //..
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
```  
이 기능은 아이콘을 Column에 직접 추가합니다. 텍스트는 아이콘과 텍스트를 구분하는 상단 전용 여백이 있는 Container 내부에 있습니다.  
함수를 호출하고 해당 열에 특정한 색상, Icon 및 텍스트를 전달하여 이러한 Column을 포함하는 행을 작성합니다.  
각 Column의 앞, 사이, 뒤에 여유 공간을 고르게 배열하려면 MainAxisAlignment.spaceEvenly를 사용하여 주축을 따라 Column을 정렬합니다. build() 메서드 titleSection 내 선언 바로 아래에 다음 코드를 추가합니다.

``` dart
Color color = Theme.of(context).primaryColor;

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(color, Icons.call, 'CALL'),
    _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
    _buildButtonColumn(color, Icons.share, 'SHARE'),
  ],
);
```  

본문에 버튼 섹션을 추가합니다.
```dart
return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        // appBar: AppBar(
        //  title: const Text('Flutter layout demo'),
        // ),
        body: Column(
          children: [
            titleSection,
            buttonSection, // +
          ],
        ),
      ),
    );
  }
```  

<br/>

## 4단계: 텍스트 섹션 구현  
텍스트 섹션을 변수로 정의합니다. Container 안에 텍스트를 넣고 각 가장자리를 따라 padding을 추가합니다. buttonSection 선언 바로 아래에 다음 코드를 추가합니다.  

> lib/main.dart (textSection)
```dart
Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    'Alps. Situated 1,578 meters above sea level, it is one of the '
    'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    'half-hour walk through pastures and pine forest, leads you to the '
    'lake, which warms to 20 degrees Celsius in the summer. Activities '
    'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
```  

softwrap를 true로 설정하면 텍스트 줄은 단어 경계에서 줄 바꿈하기 전에 column 너비를 채웁니다.  

본문에 텍스트 섹션 추가:  
> {3단계 → 4단계}/lib/main.dart  
```dart
return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Flutter layout demo'),
        // ),
        body: ListView(
          children: [            
            titleSection,
            buttonSection,
            textSection, // +
        ],
    ),
),
```  

<br/>

## 5단계: 이미지 섹션 구현  

이제 4개의 column 요소 중 3개가 완료되어 이미지만 남습니다. 예제에 이미지 파일을 추가합니다.  

* 프로젝트 상단에 images 디렉토리를 생성합니다.
* lake.jpg 추가.  

> {4단계 → 5단계}/pubspec.yaml  
```dart
flutter:
	uses-material-design: true
	assets: // +
	 - images/lake.jpg // +
``` 

> **팁:** 
> * pubspec.yaml는 민감합니다. 대소문자 를 구분하므로 위와 같이 assets: 과 이미지 URL을 작성합니다.
> * pubspec 파일도 공백에 민감하므로 적절한 들여쓰기를 사용하십시오.
> * pubspec 변경 사항을 적용하려면 실행 중인 프로그램(시뮬레이터 또는 연결된 장치에서)을 다시 시작해야 할 수 있습니다.  

이제 코드에서 이미지를 참조할 수 있습니다.  

> {4단계 → 5단계}/lib/main.dart
```dart
        ),
        body: ListView(
          children: [
            Image.asset( // +
              'images/lake.jpg', // +
              width: 600, // +
              height: 240, // +
              fit: BoxFit.cover, // +
            ), // +
            titleSection,
            buttonSection,
            textSection,
```  

BoxFit.cover는 프레임워크에 이미지가 가능한 한 작아야 하지만 전체 렌더 상자를 덮어야 한다고 알려줍니다.  

<br/>

## 6단계: 최종 터치

이 마지막 단계에서는 앱이 작은 기기에서 실행될 때 앱 본문 스크롤을 ListView 지원ßß하기 때문에 Column보다는 ListView에 모든 요소를 ​​정렬합니다.  

**Dart code:** main.dart  
**Image:** images  
**Pubspec:** pubspec.yaml  

앱을 핫 리로드하면 이 페이지 상단의 스크린샷과 동일한 앱 레이아웃이 표시되어야 합니다.  
Flutter 앱에 상호 작용 추가에 따라 이 레이아웃에 상호 작용을 추가할 수 있습니다 .

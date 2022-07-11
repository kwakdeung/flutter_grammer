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

## 여러 위젯을 Row(수평, 가로) 및 Column(수직, 세로)로 배치  
: 가장 일반적인 레이아웃 패턴  
> ### 포인트는 무엇인가?  
>  * Row와 Column 가장 일반적으로 사용되는 두 가지 레이아웃 패턴입니다.
>  * Row와 Column 각각은 자식 위젯의 목록을 가져옵니다.
>  * 자식 위젯은 그 자체가 Row, Column 또는 기타 복잡한 위젯일 수 있습니다.
>  * Row 또는 Column은 자식을 수평, 가로 및 수직, 세로로 정렬 하는 방법을 지정할 수 있습니다.
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

<br/>

## Aligning(정렬) 위젯  

mainAxisAlignment및 crossAxisAlignment 속성을 사용하여 Row이나 Column이 자식을 정렬하는 방법을 제어합니다.  
 Row: 주 축은 **수평**, 교차 축 수직  
 Column: 주 축은 **수직**, 교차 축 수평

![](https://docs.flutter.dev/assets/images/docs/ui/layout/row-diagram.png)
![](https://docs.flutter.dev/assets/images/docs/ui/layout/column-diagram.png)  

>**참고:** 프로젝트에 이미지를 추가할 때 이미지에 액세스하려면 pubspec.yaml 파일을 업데이트해야 합니다. 이 예에서는 이미지를 표시하는 데 Image.asset 사용합니다. 자세한 내용은 이 예제의 pubspec.yaml 파일 또는 자산 및 이미지 추가를 참조하십시오 . Image.network를 사용하여 온라인 이미지를 참조하는 경우에는 이 작업을 수행할 필요가 없습니다.    

<br/>
다음 예에서 3개의 이미지 각각은 너비가 100픽셀입니다. 렌더 상자(이 경우 전체 화면)는 너비가 300픽셀 이상이므로 주축 정렬을 설정하면 여유 수평 공간이 각 이미지 사이, 이전, 이후에 균등하게 분할됩니다.  

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
  // Row - mainAxisAlignment
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/row-spaceevenly-visual.png)  

<br/>
Column은 Row와 같은 방식으로 작동합니다. 다음 예는 각각 높이가 100픽셀인 3개의 이미지 열을 보여줍니다. 렌더 박스(이 경우 전체 화면)의 높이는 300픽셀 이상이므로 주축 정렬을 설정하면 자유 수직 공간이 각 이미지 사이, 위, 아래에 균등하게 분할됩니다.  

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  // Column - mainAxisAlignment
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/column-visual.png)  

<br/>

## Sizing(사이즈 조정) 위젯  

레이아웃이 너무 커서 장치에 맞지 않으면 영향을 받는 가장자리를 따라 노란색 및 검은색 줄무늬 패턴이 나타납니다. 다음은 너무 넓은 Row 의 예:  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-too-large.png)  

이미지 Row이 렌더링 상자에 비해 너무 넓은 이전 예제를 수정하려면 Expanded로 조정합니다.  

Expanded: Row이나 Column에 맞게 위젯의 크기를 조정.  
```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(  
      child: Image.asset('images/pic1.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic2.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic3.jpg'),
    ),
  ],
);
```  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/row-spaceevenly-visual.png)  

아마도 위젯이 형제보다 두 배 많은 공간을 차지하기를 원할 것입니다.  
이를 위해 위젯의 요소를 결정하는 정수인 Expanded 위젯 flex 속성을 사용합니다.  기본 flex 요소는 1입니다. 다음 코드는 중간 이미지의 flex 요소를 2로 설정합니다.  
```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded( // 생략(기본) - flex: 1
      child: Image.asset('images/pic1.jpg'),
    ),
    Expanded(
      flex: 2,
      child: Image.asset('images/pic2.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic3.jpg'),
    ),
  ],
);
```  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/row-expanded-visual.png)  

<br/>

## Packing(포장) 위젯  
기본적으로 Row이나 Column은 주 축을 따라 가능한 한 많은 공간을 차지하지만 자식을 **밀접하게 묶고** 싶다면 **mainAxisSize: MainAxisSize.min.** 로 설정 하십시오  다음 예제에서는 이 속성을 사용하여 별 아이콘을 함께 묶습니다.  
```dart
Row(
  mainAxisSize: MainAxisSize.min, // 밀접하게 묶기
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
)
```  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/packed.png)  

## rows와 columns의 중첩  

레이아웃 프레임워크를 사용하면 필요한 만큼 깊이 Row과 Column 내부에 Row과 Column을 중첩할 수 있습니다. 다음 레이아웃의 개요 섹션에 대한 코드를 살펴보겠습니다.  

  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-large-annotated.png)  
개요 섹션: 2개의 Row  
평가 Row: 별 5개와 리뷰 수  
아이콘 Row: 아이콘, 텍스트의 3 Column  

평가 행의 위젯 트리:  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-rating-row.png)  
```dart
var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container(
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      const Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,  // 폰트 굵기
          fontFamily: 'Roboto',  // 폰트 종류
          letterSpacing: 0.5, // 철자 간격
          fontSize: 20,
        ),
      ),
    ],
  ),
);
```  
>**팁**: 많이 중첩된 레이아웃 코드로 인해 발생할 수 있는 시각적 혼란을 최소화하려면 변수 및 함수에서 UI 부분을 구현하십시오.  

<br/>

등급 행의 위젯 트리:  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-icon-row.png)  
```dart
const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            const Text('PREP:'),
            const Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            const Text('COOK:'),
            const Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            const Text('FEEDS:'),
            const Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);

// leftColumn - 등급 및 아이콘 Row와 Pavlova를 설명하는 "제목 및 텍스트"가 포함
final leftColumn = Container(  
  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20), 
  // fromLTRB(Left, Top, Right, Bottom) 
  child: Column(
    children: [
      titleText,
      subTitle,
      ratings,
      iconList,
    ],
  ),
);

body: Center(
  child: Container(
    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
    height: 600,
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox( // 왼쪽 Column은 너비를 제한하기 위해 SizedBox가 배치됩니다
            width: 440,
            child: leftColumn,
          ),
          mainImage,
        ],
      ),
    ),
  ),
),
```  

> **팁:** Pavlova 예제는 태블릿과 같은 넓은 장치에서 가로로 가장 잘 실행됩니다. **iOS 시뮬레이터에서 이 예제를 실행하는 경우 하드웨어 > 장치** 메뉴 를 사용하여 다른 장치를 선택할 수 있습니다. 이 예에서는 iPad Pro를 권장합니다. **하드웨어 > 회전** 을 사용하여 방향을 가로 모드로 변경할 수 있습니다 . **Window > Scale** 을 사용하여 (논리적 픽셀 수를 변경하지 않고) 시뮬레이터 창의 크기를 변경할 수도 있습니다.  

<br/>

## 일반적인 레이아웃 위젯  

Flutter에는 풍부한 레이아웃 위젯 라이브러리가 있습니다. 의도는 가능한 한 빨리 시작하고 실행하는 것입니다.  

### 표준 위젯  
* Container: 위젯에 **padding(패딩), margins(여백), borders(테두리), 배경색 또는 기타 장식**을 추가합니다.
* GridView: 위젯을 **스크롤 가능한 그리드**로 배치합니다.
* ListView: 위젯을 **스크롤 가능한 목록**으로 배치합니다. 
* Stack: 위젯을 **다른 위젯 위에 겹칩니다.**  

### Material 위젯  
* Card: 모서리가 둥글고 그림자가 있는 상자에 관련 정보를 구성합니다.
* ListTile: 최대 3줄의 텍스트와 선택적인 선행 및 후행 아이콘을 행으로 구성합니다.  

### Container  
* padding, margins, borders 추가
* 배경색 또는 이미지 변경
* 단일 하위 위젯을 포함하지만 해당 하위는 Row, Column 또는 위젯 트리의 루트일 수 있습니다.  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/margin-padding-border.png)  

### 예(Container)
```dart  

//
Widget _buildImageColumn() {
  return Container( // 이 Container는 열의 배경색을 밝은 회색으로 변경하는 데 사용
    decoration: const BoxDecoration(
      color: Colors.black26,
    ),
    child: Column(
      children: [
        _buildImageRow(1),
        _buildImageRow(3),
      ],
    ),
  );
}  

Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: Container( // 이 Container는 각 이미지에 둥근 테두리와 여백을 추가하는 데 사용됩니다.       
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('images/pic$imageIndex.jpg'),
      ),
    );

Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
```  

<br/>

## GridView(그리드 뷰)  

* 그리드에 위젯 배치
* column 콘텐츠가 렌더 상자를 초과할 때 감지하고 자동으로 스크롤 제공 
* 사용자 지정 그리드를 구축하거나 제공된 그리드 중 하나를 사용합니다.

  * GridView.count열 수를 지정할 수 있습니다.
  * GridView.extent타일의 최대 픽셀 너비를 지정할 수 있습니다.  

>**참고:** 셀이 차지하는 Row과 Column이 중요한 2차원 목록을 표시할 때(예: "아보카도" 행의 "칼로리" 열 항목) Table 또는 DataTable를 사용합니다.  

### 예(GridView)  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-extent.png)  

GridView.extent - **최대 150픽셀 너비**의 타일이 있는 그리드를 만드는 데 사용합니다.  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-count-flutter-gallery.png)  

세로 모드에서 너비가 2타일이고 가로 모드에서 너비가 3타일인 그리드를 만드는데 GridView.count를 사용합니다. 제목은 각각의 GridTile footer 속성을 설정하여 생성됩니다.
```dart
Widget _buildGrid() => GridView.extent( 
  // => : 람다식, extent: GridView의 범위 설정(maxCrossAxisExtent, padding, mainAxisSpacing, crossAxisSpacing 등)
  maxCrossAxisExtent: 150, 
  // maxCrossAxisExtent - 1개의 그리드 아이템의 "최대넓이 값"으로 Row 혹은 Column의 갯수 지정
  padding: const EdgeInsets.all(4),
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  children: _buildGridTileList(30));  

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate( 
  // List.generate - 리스트를 생성
  count, (i) => Container(child: Image.asset('images/pic$i.jpg)));
```  

<br/>

## ListView  

* 특화된 Column 상자 목록을 구성 
* horizontally 또는 vertically으로 배치 가능
* 콘텐츠가 맞지 않을 때 감지하고 스크롤 제공
* Column보다는 덜 구성 가능, 하지만 사용하기 쉽고 스크롤을 지원  
<br/>
![](https://docs.flutter.dev/assets/images/docs/ui/layout/listview.png)  

ListTiles를 사용하여 비즈니스 목록을 표시하는 데 ListView를 사용합니다. A Divider는 극장과 레스토랑을 구분합니다.


![](https://docs.flutter.dev/assets/images/docs/ui/layout/listview-flutter-gallery.png)  

특정 색상 군에 대한 재료 디자인 팔레트 Colors에서 표시하는 데 ListView를 사용합니다.  

```dart  
Widget _buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way', Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile(
          'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  ):
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );  
}
```
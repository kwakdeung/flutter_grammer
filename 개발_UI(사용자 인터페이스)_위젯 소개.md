# 위젯 소개  

Flutter 위젯은 React 에서 영감을 얻은 최신 프레임워크를 사용하여 구축되었습니다. 핵심 아이디어는 위젯으로 **UI**를 구축한다는 것입니다. 위젯은 현재 구성 및 상태가 주어지면 뷰가 어떻게 보여야 하는지 설명합니다. 위젯의 상태가 변경되면 위젯은 해당 설명을 다시 작성하고 프레임워크는 기본 렌더 트리에서 한 상태에서 다음 상태로 전환하는 데 필요한 최소한의 변경을 결정하기 위해 이전 설명과 비교합니다.  
UI: 사용자 인터페이스, 쉽게 말해서 사용자가 컴퓨터 프로그램 또는 모바일 앱을 사용할 때 마주하는 디자인, 레이아웃 등 직접 눈으로 보이는 것을 뜻합니다.  
(출처: https://ittrue.tistory.com/32)  

> **참고:** 몇 가지 코드를 자세히 살펴보고 Flutter에 대해 더 잘 알고 싶다면 기본 레이아웃 codelab , 레이아웃 빌드 및 Flutter 앱에 상호 작용 추가를 확인하세요.  

<br/>

## Hello world

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```
"Hello, world" 텍스트가 화면 중앙에 표시됩니다. runApp()함수 주어진 값을 가져와 Widget위젯 트리의 루트로 만듭니다. MaterialApp 위젯이 사용되면 나중에 설명하는 것처럼 이 작업이 자동으로 처리됩니다.

앱을 작성할 때 일반적으로 위젯이 상태를 관리하는지 여부에 따라 StatelessWidget 또는 StatefulWidget 작성합니다.

RenderObject 프레임워크는 위젯의 지오메트리를 계산하고 설명하는 기본을 나타내는 위젯에서 프로세스가 끝날 때까지 이러한 위젯을 차례로 빌드합니다 .

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child
          // to fill the available space.
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context) //
                  .primaryTextTheme
                  .headline6,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}
```

<br/>

## 기본 위젯  

강력한 기본 위젯 모음과 일반적으로 사용되는 위젯  


**Text**  
Text 위젯을 사용하면 응용 프로그램 내에서 스타일이 지정된 텍스트 실행을 만들 수 있습니다.

**Row(행),Column(열)**  
이러한 플렉스 위젯을 사용하면 가로(Row) 및 세로(Column) 방향 모두에서 유연한 레이아웃을 만들 수 있습니다. 

**Stack**  
선형 방향(가로 또는 세로) 대신 Stack위젯을 사용하면 위젯을 페인트 순서로 서로 위에 배치합니다. 그런 다음 Stack의 자식에 Positioned 위젯을 사용하여 스택의 위쪽, 오른쪽, 아래쪽 또는 왼쪽 가장자리를 기준으로 자식을 배치할 수 있습니다.  

**Container**
Container위젯을 사용하면 직사각형 시각적 요소를 만들 수 있습니다. 컨테이너는 배경, 테두리 또는 그림자와 같은 으로 BoxDecoration 장식할 수 있습니다. 크기에 여백, 패딩 및 제약 조건을 적용할 수도 있습니다. 행렬을 사용하여 3차원 공간에서 Container 를 변환할 수 있습니다.  

다음은 이러한 위젯과 다른 위젯을 결합한 몇 가지 간단한 위젯입니다.  

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child
          // to fill the available space.
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context) //
                  .primaryTextTheme
                  .headline6,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: MyScaffold(),
      ),
    ),
  );
}
```  

pubspec.yaml 파일 flutter 섹션에 **uses-material-design: true** 항목이 있어야 합니다.  
미리 정의된 머티리얼 아이콘 세트를 사용할 수 있습니다. 

<br/>

## 재료 구성 요소 사용  
MaterialApp: "경로"라고도 하는 문자열로 식별되는 위젯 스택을 관리  
Navigator: 화면 간에 원활하게 전환  

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Tutorial',
      home: TutorialHome(),
    ),
  );
}

class TutorialHome extends StatelessWidget {
  const TutorialHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: const Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

MyAppBar가 좀 더 Material로 보이기 시작합니다. appbar에는 그림자, 제목 text는 올바른 스타일을 자동으로 상속(child:), floatingActionButton도 추가되었습니다.  
위젯은 다른 위젯에 인수로 전달됩니다.  
Scaffold 위젯: 여러 위젯을 명명된 인수로 사용  
각 위젯은 Scaffold 레이아웃의 적절한 위치에 배치됩니다. AppBar위젯을 사용하면 leading위젯과 title(제목) action 위젯에 대한 위젯을 전달합니다.  

>**참고:** Material은 Flutter에 포함된 2개의 번들 디자인 중 하나입니다. iOS 중심 디자인을 만들려면 CupertinoApp 자체 버전 및 CupertinoNavigationBar가 있는 Cupertino 구성 요소 패키지를 참조하세요.  

<br/>

## 제스터 처리  

대부분의 응용 프로그램에는 시스템과의 사용자 상호 작용 형식이 포함되어 있습니다.  
대화형 애플리케이션을 구축하는 첫 번째 단계: 입력 제스처를 감지하는 것  
간단한 버튼을 만들어 작동 방식을 확인하십시오.  
```dart
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: const Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyButton(),
        ),
      ),
    ),
  );
}
```


GestureDetector 위젯에는 시각적 표현이 없지만 대신 사용자가 만든 제스처를 감지합니다. 사용자가 Container을 탭하면 GestureDetector 콜백을 호출하며 onTap()이 경우 콘솔에 메시지를 인쇄합니다. 탭, 드래그, 스케일 등 다양한 입력 제스처를 감지하는 데 GestureDetector를 사용할 수 있습니다. 많은 위젯이 GestureDetector를 사용하여 다른 위젯에 대한 선택적 콜백을 제공합니다.  

자세한 내용은 Flutter의 제스처를 참조하세요.  

<br/>

## 입력에 대한 응답으로 위젯 변경  
사용자 입력을 수락하고 해당 build()메서드에서 결과를 직접 사용합니다. 더 복잡한 응용 프로그램에서는 위젯 계층 구조의 다른 부분이 다른 문제를 담당할 수 있습니다.  
StatelessWidgets은 상위 위젯에서 인수를 수신하여 final멤버 변수에 저장합니다. build() 위젯이 요청되면 이러한 저장된 값을 사용하여 생성하는 위젯에 대한 새 인수를 파생합니다.  

여기서는 StatefulWidgets을 사용합니다.  
StatefulWidgets: 일반적으로 일부 상태를 전달, 상태를 유지하는 데 사용되는 개체를 생성하는 방법을 알고 있는 특수 위젯.  
더 복잡한 경험을 구축하기 위해(예: 사용자 입력에 더 흥미로운 방식으로 반응하기 위해) 애플리케이션은 "일반적으로 일부 상태를 전달"합니다.

```dart
import 'package:flutter/material.dart';




class Counter extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}


class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    ),
  );
}
```  

StatefulWidget와 State가 별개의 객체인 이유:  
서로 다른 수명 주기를 가짐  
StatefulWidget - 현재 상태에서 응용 프로그램의 프레젠테이션을 구성하는 데 사용되는 "임시" 개체  
State - build()에 대한 호출 사이에 지속되어 정보를 "기억"할 수 있습니다.  


Flutter에서 변경 알림은 콜백을 통해 위젯 계층을 "위로" 흐르고 현재 상태는 프레젠테이션을 수행하는 상태 비저장 위젯으로 "아래로" 흐릅니다. 이 흐름을 리디렉션하는 공통 부모는 State. 다음의 약간 더 복잡한 예는 이것이 실제로 어떻게 작동하는지 보여줍니다.  

카운터 표시(CounterDisplay)와 카운터 변경(CounterIncrementor) 문제를 명확하게 분리하는 두 개의 새로운 상태 "비저장 위젯 생성"에 주목  
최종 결과는 이전 예와 동일하다. 하지만 책임을 분리하면 "상위 위젯에서 단순성을 유지"하면서 "개별 위젯에 더 큰 복잡성을 캡슐화"할 수 있습니다.  

```dart
import 'package:flutter/material.dart';


class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ElevatedButton: 버튼
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // setState: State객체의 상태가 변경되었다는 것을 프레임워크에 알리는 메소드(출처: https://velog.io/@tmdgks2222/Flutter-State)
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CounterIncrementor(onPressed: _increment),
        const SizedBox(width: 16),
        CounterDisplay(count: _counter),
      ],
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Counter(),
        ),
      ),
    ),
  );
}
```  

<br/>

## 모든 것을 함께 가져옴  

가상의 쇼핑 애플리케이션은 판매용으로 제공되는 다양한 제품을 표시하고 의도한 구매를 위해 장바구니를 유지합니다.  
부모가 onCartChanged 콜백을 수신하면 부모가 내부 상태를 업데이트하여 부모 가 새 값 으로 inCart 새 변수와 함께 ShoppingListItem의 새 인스턴스를 다시 만들고 생성하도록 트리거합니다.

```dart
import 'package:flutter/material.dart';


class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart; // bool - 논리 true/false, 두 가지 시각적 표현 사이 - 현재 테마의 기본 색상과 회색
  final CartChangedCallback onCartChanged; // onCartChanged - 상위 위젯에서 받은 함수를 호출

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart // 두 가지 시각적 표현 사이 - 현재 테마의 기본 색상과 회색
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ShoppingListItem(
            // ShoppingListItem widget: 비저장 위젯의 일반적인 패턴, final 멤버 변수에 저장 -> build() 함수 중에 사용
            product: const Product(
                name: 'Chips'), // ShoppingListItem 결과 - Product의 name: Chips
            inCart: true,
            onCartChanged: (product, inCart) {},
          ),
        ),
      ),
    ),
  );
}
```  
다음은 변경 가능한 상태를 저장하는 상위 위젯의 예입니다.  
ShoppingList 제품을 터치할 시 회색 체크 한 번 더 터치 시 원 상태로 변함 

```dart
import 'package:flutter/material.dart';

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        // CircleAvatar - 내용을 원형으로 보여주는 위젯
        // (출처: https://blog.naver.com/PostView.naver?blogId=best__khs&logNo=222543485019&categoryNo=0&parentCategoryNo=0&viewDate=&currentPage=1&postListTopCurrentPage=1&from=postView)
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  // StatefulWidget - 속성이 변함. ShoppingList 제품을 터치할 시 회색 체크 한 번 더 터치 시 원 상태로 변함 
  const ShoppingList({required this.products, super.key}); // const - 코드 실행 이전

  final List<Product> products; // final - 코드 실행 이후

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inCart) {
        // If문
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        centerTitle:
            true, // 앱바 텍스트 위치 가운데 정렬함.(기본 위치- ios: 가운데 정렬, 안드로이드: 왼쪽 정렬)
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: [
        // 제품 목록
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
```  
ShoppingList위젯이 트리에 처음 삽입되면 프레임워크는 함수를 호출하여 트리 의 해당 위치와 연결할 createState()의 새 인스턴스를 생성합니다. (State의 하위 클래스는 일반적으로 개인 구현 세부 정보임을 나타내기 위해 선행 밑줄로 이름이 지정됩니다.) 이 위젯의 ​​상위가 다시 빌드될 때 상위는 ShoppingList의 새 인스턴스를 생성 하지만 프레임워크는 createState 다시 호출하는 대신 트리에 이미 있는 _ShoppingListState 인스턴스를 재사용합니다.  

<br/>

## 위젯 수명 주기 이벤트에 응답  

StatefulWidget의 createState()를 호출한 후 프레임워크는 새 상태 개체를 트리에 삽입한 다음 initState()상태 개체를 호출합니다. State의 하위 클래스는 한 번만 발생해야 하는 initState 작업을 재정의할 수 있습니다 . 예를 들어  애니메이션을 구성하거나 플랫폼 서비스에 가입하려면 initState 재정의합니다. super.initState.를 호출하여 시작하려면 initState의 구현이 필요합니다 

상태 개체가 더 이상 필요하지 않으면 프레임워크는 dispose() 상태 개체를 호출합니다. 정리 작업을 수행하는 dispose 함수를 재정의합니다 . 예를 들어 dispose 타이머를 취소하거나 플랫폼 서비스 구독을 취소하려면 재정의합니다. super.dispose.의 구현은 일반적으로 dispose를 호출하여 종료됩니다 

자세한 내용은 State.을(를) 참고하십시오 

<br/>

## 열쇠  
위젯이 다시 빌드될 때 프레임워크가 다른 위젯과 일치하는 위젯을 제어하려면 키를 사용하십시오. 기본적으로 프레임워크는 위젯 이 표시되는 순서와 runtimeType 위젯에 따라 현재 및 이전 빌드의 위젯을 일치시킵니다. 키를 사용하면 프레임워크는 두 위젯이 동일 key할 뿐만 아니라 동일한 runtimeType.

키는 동일한 유형의 위젯의 여러 인스턴스를 빌드하는 위젯에서 가장 유용합니다. 예를 들어, 보이는 영역을 채울 만큼만 ShoppingListItem 인스턴스를 빌드하는 ShoppingList 위젯은 다음과 같습니다.

키가 없으면 현재 빌드의 첫 번째 항목은 의미상 목록의 첫 번째 항목이 화면 밖으로 스크롤되어 뷰포트에 더 이상 표시되지 않는 경우에도 항상 이전 빌드의 첫 번째 항목과 동기화됩니다.

목록의 각 항목에 "의미론적" 키를 할당하면 프레임워크가 일치하는 의미론적 키와 유사한(또는 동일한) 시각적 모양과 항목을 동기화하기 때문에 무한 목록이 더 효율적일 수 있습니다. 또한 항목을 의미적으로 동기화한다는 것은 상태 저장 자식 위젯에 유지된 상태가 뷰포트의 동일한 숫자 위치에 있는 항목이 아닌 동일한 의미론적 항목에 연결된 상태로 유지된다는 것을 의미합니다.

자세한 내용은 KeyAPI를 참조하세요.



<br/>

## 전역 키  
전역 키를 사용하여 자식 위젯을 고유하게 식별합니다. 전역 키는 형제 간에만 고유해야 하는 로컬 키와 달리 전체 위젯 계층 구조에서 전역적으로 고유해야 합니다. **전역적으로 고유**하기 때문에 전역 키는 위젯과 연결된 상태를 검색하는 데 사용할 수 있습니다.

자세한 내용은 GlobalKeyAPI를 참조하세요.
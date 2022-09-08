# Simple app state management(간단한 앱 상태 관리)  
[선언적 UI 프로그래밍](https://docs.flutter.dev/development/data-and-backend/state-mgmt/declarative)과 difference between [임시와 앱 상태](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)에 대해 알았으므로 간단한 앱 상태 관리를 배울 준비가 되어있다.  

이 페이지에서는 **상태 관리** 중에서 **provider package**를 사용할 것이다.  
**provider package**는 이해하기 쉬우며 많은 코드를 사용하지 마라. 다른 모든 접근 방식에 적용할 수 있는 개념을 사용한다.  
즉, 다른 반응형 프레임워크의 상태 관리에 대한 강한 배경이 있는 경우, [옵션 페이지](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)에 나열된 패키지 및 튜토리얼을 찾을 수 있다.  

<br/>

## Our example  
설명을 위해 단순한 앱을 생각해라.  

앱은 2개의 분리된 화면을 가진다: catalog, cart(MyCatalog에 의해 나타남, Mycart 위젯)  
catalog 화면은 custom app bar(MyAppBar)와 많은 list item들의 scrolling view를 포함한다.  

widget tree로 시각화된 앱:  
![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/model-shopper-screencast.gif)  
![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree.png)  

그래서 우리는 위젯에서 최소 5개의 하위 클래스들을 가진다.  
그들 중 다수는 다른 곳에 "소속"된 상태에 대한 접근 권한이 필요하다.  

첫 번째 질문: cart의 현재 상태는 어디에 넣어야 할까?  

<br/>

## Lifting state up(상태 끌어올리기)  
Flutter에서는 **상태를 사용하는 위젯 위**에 **상태를 유지**하는 것이 합리적이다. 이유는 Flutter와 같은 선언적인 프레임워크, 만약 UI가 변하길 원한다면, 재빌드를 해야한다. MyCart.updateWith(somethingNew)를 쉽게 가질 수 없다. 위젯에 대한 메서드를 호출하여 외부에서 위젯을 명령적으로 변경하기가 어렵다.

```dart
// BAD: DO NOT DO THIS
void myTapHandler() {
    var cartWidget = somehowGetMyCartWidget();
    cartWidget.updateWith(item);
}
```  
심지어 코드가 작동한다해도, MyCart에서 다음과 같이 처리해야 한다.  
```dart
// BAD: DO NOT DO THIS
Widget build(BuildContext context) {
    return SomeWidget(
        // The initial state of cart
    );
}

void updateWith(Item item) {
    // Somehow you need to change the UI from here.
}
```  
UI의 현재 상태를 생각하고 새 데이터를 적용해야 한다.  
Flutter에서는 내용이 변경될 때마다 새 위젯을 생성한다.  
**MyCart.updateWith(somethingNew)**(메서드 호출) 대신 **MyCart(contents)**(생성자)를 사용한다. parent의 build 메서드에서만 새 위젯을 구성할 수 있기 때문에 contents를 변경하려면 MyCart의 parent 또는 위에 있어야 할 필요가 있다.  
```dart
// GOOD
void myTapHandler(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    cartModel.add(item);
}
```  
이제 Mycart는 building을 위한 UI의 모든 버젼을 오직 하나의 코드 경로를 가져라
```dart
Widget build(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    return SomeWidget(
        // Just construct the UI once, using the current state of the cart.
        // ...
    );
}
```
예를 들어, MyApp에서 컨텐츠들은 존재할 필요가 있다. 위로부터 MyCart는 언제든지 변할 수 있고, rebuild할 수 있다.  

![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree-with-cart.png)

이것이 우리가 위젯을 변경할 수 없다고 말할 때 의미하는 것이다. 그들은 바뀌지 않고 교체된다.  
Cart의 상태를 어디에 둘 것인지 알았으니 접근하는 방법을 살펴보자.

<br/>

## Accessing the state(상태 허용)

유저가 Catalog의 항목 중 하나를 클릭하면 Cart에 추가된다. 그러나 Cart가 MyListItem 위에 있기 때문에 어떻게 해야 할까?

간단한 옵션은 클릭할 때 MyListItem는 호출할 수 있는 콜백을 provide를 하는 것입니다. Dart의 기능은 일급 객체이므로 원하는 방식으로 전달할 수 있다.
내부 MyCatalog에서 다음을 정의할 수 있다:
```dart
@override
Widget build(BuildContext context) {
    return SomeWidget(
        // Construct the widget, passing it a reference to the method above.  
        MyListItem(myTapCallback),        
    );
}

void myTapCallback(Item item) {
    print('user tapped on $item');
}
```
InheritedWidget, InheritedNotifier, InheritedModel 등 위젯 - 위젯이 하위 항목(즉, 하위 항목뿐만 아니라 하위 위젯)에 데이터와 서비스를 제공하는 메커니즘.

이것들 대신에 여기서는 **provider**를 사용할 것이다.  
provider은 낮은 수준의 위젯과 함께 단순하게 사용한다.

**provider로 작업하기 전**에 **pubspec.yaml에 대한 dependency**을 잊지 말고 **추가**해라.

```dart
name: my_name
description: Blah blah blah

# ...

dependencies:
    flutter:
        sdk: flutter

    provider: ^6.0.0

dev_dependencies:
    # ...
```  
이제 import 'package:provider/provider.dart'; 할 수 있고 빌딩을 시작해라.  

**provider**와 함께 너는 콜백 또는 **InheritedWidgets**에 대해 걱정할 필요가 없다. 그러나 **3가지 개념**을 이해할 필요가 있다:  
* ChangeNotifier
* ChangeNotifierProvider
* Consumer  

<br/>

## ChangeNotifier

모든 위젯들이 listen 할 수 있는 ChangeNotifier 인스턴스를 생성한다.
**ChangeNotifier**은 listeners에게 공지 변화를 provide한 Flutter SDK에 포함된 단순한 클래스이다.  
다시 말해서, 만약 무언가가 ChangeNotifier인 경우, 변화를 구독할 수 있다.  

**provider, ChangeNotifier**은 앱 상태를 캡슐화할 한 가지 방법이다.  
다음과 같이 ChangeNotifier를 확장할 새 클래스를 생성한다:
```dart
class CartModel extends ChangeNotifier {
    /// Internal, private state of the cart.
    final List<Item> _items = [];

    /// An unmodifiable view of the items in the cart.
    UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

    /// The current total price of all items (assuming all items cost $42).
    int get totalPrice => _items.length * 42;

    /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
    /// cart from the outside(외부).
    void add(Item item) {
        _items.add(item);
        // This call tells the widgets that are listening to this model to rebuild.
        notifyListeners();
    }

    /// Removes all items from the cart.
    void removeAll() {
        _item.clear();
        // This call tells the widgets that are listening to this model to rebuild.
        notifyListeners();
    }
}
```  
**ChangeNotifier**의 유일한 코드는 notifyListeners()에 호출한다. 앱의 UI를 변경할 수 있는 방식으로 model이 변경될 때마다 이 메서드를 호출해라. **CartModel**에서 다른 모든 것은 model 자체와 비즈니스 logic이다.  

**ChangeNotifier**는 **flutter:foundation**과 Flutter 안에서 모든 높은 수준의 클래스들이 의존하지 않는 파트이다.  

예를 들면, CartModel의 단순한 unit text:
```dart
test('adding item increases total cost', () {
    final cart = CartModel();
    final startingPrice = cart.totalPrice;
    cart.addListener(() {
        expect(cart.totalPrice, greaterThan(startingPrice));
    });
    cart.add(Item('Dash'));
});
```

<br/>

## ChangeNotifierProvider  
**ChangeNotifierProvider**: 하위에 ChangeNotifier의 인스턴스를 provide하는 위젯이다.  
provider package로부터 온다.  

우리는 이미 **ChangeNotifierProvider**를 배치하는 곳을 안다: 허용할 필요가 있는 위젯 **위**에 배치.  
**CartModel** 같은 경우, **MyCart**와 **MyCatalog** 위에 둔다.  
```dart
void main() {
    runApp(
        ChangeNotifierProvider(
            create: (context) => CartModel(),
            child: const MyApp(),
        ),
    );
}
```  
CartModel의 새로운 인스턴스를 생성하기를 builder를 정의하고 있다.  
**ChangeNotifierProvider**는 절대적으로 필수가 아니라면 CartModel을 rebuild 하지 않아도 충분히 스마트하다. 그것은 또한 인스턴스가 더 이상 필요가 없을 때 CartModel 위에 자동적으로 dispose()를 호출한다.  

<br/>

## MultiProvider
만약 한 개의 클래스(ChangeNotifierProvider)보다 **더 많은 클래스**의 **provide**를 원한다면, **MultiProvider**를 사용할 수 있다.
```dart
void main() {
    runApp(
        MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => CartModel()),
                Provider(create: (context) => SomeOtherClass()),
            ],
            child: const MyApp(),
        );
    );
}
```

<br/>

## Consumer
Provider의 **데이터 값을 변경**하거나 **화면에 보여주는 것**을 의미한다.  
지금 CartModel은 위에서 선언한 ChangeNotifierProvider를 통해 우리의 앱에서 위젯에 provided 되고, 우리는 사용을 시작할 수 있다.

Consumer 위젯을 통해 수행한다.
```dart
return Consumer<CartModel>(
    builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
    },
);
```
우리는 허용을 원하는 model의 타입이 반드시 명확해야 한다. 이 경우는 CartModel을 원한다, 그래서 **Consumer&#60;CartModel>** 를 작성한다.  

**Consumer** 위젯의 유일하게 필요한 arguments(인수)는 builder이다. Builder는 **ChangeNotifier**이 변화하면서 언제든지 불려진 기능이다.  
Builder는 3개의 인수가 불려진다.  
1. context - 모든 build 메서드에서 얻을 수 있다.
2. ChangeNotifier의 instance - model의 data를 사용하여 주어진 지점에서 UI가 어떻게 보일지 정의할 수 있다.
3. 최적화의 child - model이 변경될 때, 변경되지 않은 큰 위젯 하위 트리가 있는 경우 한 번 구성하고 builder를 통해 가져올 수 있다.
```dart
return Consumer<CartModel>(
    builder: (context, cart, child) => Stack(
        children: [
            // Use SomeExpensiveWidget here, without rebuilding every time.
            if (child != null) child,
            Text('Total price: ${cart.totalPrice}'),
        ],
    ),
    // Build the expensive widget here.
    child: const SomeExpensiveWidget(),
);
```
가능한 트리 안에서 깊숙히 Consumer 위젯에 두는 것을 최고의 실행이다. 너는 단순히 어딘가 변화된 세부 사항 때문에 UI의 큰 일부를 rebuild하기를 원할 수 있다.  
```dart
// DON'T DO THIS
return Consumer<CartModel>(
    builder: (context, cart, child) {
        return HumongousWidget(
            // ...
            child: AnotherMonstrousWidget(
                // ...
                child: Text('Total price: ${cart.totalPrice}'),
            ),
        );
    },
);
```  
대신에:
```dart
// DO THIS
return HumongousWidget(
    // ...
    child: AnotherMonstrousWidget(
        // ...
        child: Consumer<CartModel>(
            builder: (context, cart, child) {
                return Text('Total price: ${cart.totalPrice}');
            },
        ),
    ),
);
```  

<br/>

## Provider.of  
때로는, UI가 변화하기 위한 model에 있는 데이터가 필요하지 않다. 그러나 여전히 그것을 허용하는 것 필요하다.  

Consumer<CartModel>를 사용해야 하지만 낭비가 될 수 있다. rebuilt가 필요하지 않는 위젯을 rebuild 하기 위해 프레임워크를 요청할 것이다.  

이것을 사용하는 경우는, **false**에 set할 **listen** parameter와 함께 Provider.of를 사용할 수 있다.
```dart
Provider.of<CartModel>(context, listen: false).removeAll();
```
build 메서드에서 line 위에 사용하는 것은 notifyListeners가 불려질 때 rebuild를 위해 위젯을 야기시키질 않을 것이다.  

<br/>

## Putting it all together(함께 모아서 두다)  
너는 기사에 covered된 [예제를 check out](https://github.com/flutter/samples/tree/main/provider_shopper) 할 수 있다. 만약 단순히 무언가를 원한다면, simple Counter 앱은 [built with provider](https://github.com/flutter/samples/tree/main/provider_counter)처럼 보이는 앱을 봐라.  

이 기사들을 팔로잉함으로써, 기본 상태 앱들을 생성하는 능력이 최고로 향상될 것이다. 이 스킬들을 마스터하기 위해 자체적으로 **provider**와 함께 앱에 building을 시도해라.

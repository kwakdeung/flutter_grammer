# Simple app state management(간단한 앱 상태 관리)  
[declarative UI programming](https://docs.flutter.dev/development/data-and-backend/state-mgmt/declarative)과 difference between [ephemeral and app state](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)에 대해 알았으므로 simple app state management를 배울 준비가 되어있다.  

이 페이지에서는 **provider package**를 사용할 것이다.  
**provider package**는 이해하기 쉽고 많은 code를 사용하지 마라. 다른 모든 접근 방식에 적용할 수 있는 개념을 사용한다.  
즉, 다른 reactive(반응형) framework의 state 관리에 대한 strong background이 있는 경우, [options page](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)에 나열된 package 및 튜토리얼을 찾을 수 있다.  

<br/>

## Our example  
illustration(설명)을 위해 단순한 앱을 생각해라.  

앱은 2개의 분리된 screen을 가진다: catalog, cart(MyCatalog에 의해 나타남, Mycart 위젯)  
catalog screen은 custom app bar(MyAppBar)와 많은 list item들의 scrolling view를 포함한다.  

widget tree로 visualized(시각화된) 앱:
![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/model-shopper-screencast.gif)  
![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree.png)  

그래서 우리는 위젯에서 최소 5개의 subclasses을 가진다.  
그들 중 다수는 다른 곳에 "belongs(소속)"된 state에 대한 access 권한이 필요하다.  

첫 번째 질문: cart의 현재 상태는 어디에 넣어야 할까?  

<br/>

## Lifting state up  
Flutter에서는 state를 사용하는 위젯 위에 state를 유지하는 것이 합리적이다. 이유는 Flutter와 같은 선언적인 frameworks, 만약 UI가 변하길 원한다면, rebuild를 해야한다. MyCart.updateWith(somethingNew)를 쉽게 가질 수 없다. 위젯에 대한 메서드를 호출하여 외부에서 위젯을 명령적으로 변경하기가 어렵다.

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
**MyCart.updateWith(somethingNew)**(메서드 호출) 대신 **MyCart(contents)**(constructor:생성자)를 사용한다. parent의 build 메서드에서만 새 위젯을 구성할 수 있기 때문에 contents를 변경하려면 MyCart의 parent 또는 위에 있어야 할 필요가 있다.  
```dart
// GOOD
void myTapHandler(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    cartModel.add(item);
}
```  
이제 Mycart는 building을 위한 UI의 모든 버젼을 오직 하나의 code path를 가져라
```dart
Widget build(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    return SomeWidget(
        // Just construct the UI once, using the current state of the cart.
        // ...
    );
}
```
예를 들어, MyApp에서 contents는 존재할 필요가 있다. 위로부터 MyCart는 언제든지 변할 수 있고, rebuild할 수 있다.  

![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree-with-cart.png)

이것이 우리가 위젯을 변경할 수 없다고 말할 때 의미하는 것이다. 그들은 바뀌지 않고 교체된다.  
Cart의 상태를 어디에 둘 것인지 알았으니 액세스하는 방법을 살펴보자.

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
provider은 low-level 위젯과 함께 단순하게 사용한다.

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
이제 import 'package:provider/provider.dart'; 할 수 있고 building을 시작해라.  

**provider**와 함께 너는 콜백 또는 **InheritedWidgets**에 대해 걱정할 필요가 없다. 그러나 **3가지 개념**을 이해할 필요가 있다:  
* ChangeNotifier
* ChangeNotifierProvider
* Consumer  

<br/>

## ChangeNotifier

**ChangeNotifier**은 listeners에게 notification 변화를 provide한 Flutter SDK에 포함된 단순한 클래스이다.  
다시 말해서, 만약 무언가가 ChangeNotifier인 경우, 변화를 구독할 수 있다.  

**provider, ChangeNotifier**은 application state를 encapsulate(캡슐화)할 한 가지 방법이다.  
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
**ChangeNotifier**의 유일한 code는 notifyListeners()에 호출한다. 앱의 UI를 변경할 수 있는 방식으로 model이 변경될 때마다 이 메서드를 호출해라. **CartModel**에서 다른 모든 것은 model 자체와 비즈니스 logic이다.  

**ChangeNotifier**는 **flutter:foundation**과 Flutter 안에서 모든 higher-level classes가 의존하지 않는 파트이다.  

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
**ChangeNotifierProvider**: descendants(하위)에 ChangeNotifier의 인스턴스를 provide하는 위젯이다.  
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
**ChangeNotifierProvider**는 absolutely necessary가 아니라면 CartModel을 rebuild 하지 않아도 충분히 스마트하다. 그것은 또한 인스턴스가 더 이상 필요가 없을 때 CartModel 위에 자동적으로 dispose()를 호출한다.  

만약 한 개의 클래스보다 **더 많은 클래스**의 **provide**를 원한다면, **MultiProvider**를 사용할 수 있다.
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
지금 CartModel은 top에서 선언한 ChangeNotifierProvider를 통해 우리의 앱에서 위젯에 provided 되고, 우리는 사용을 시작할 수 있다.

Consumer 위젯을 통해 수행한다.
```dart
return Consumer<CartModel>(
    builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
    },
);
```


```dart

```
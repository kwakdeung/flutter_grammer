import 'package:flutter/material.dart';

//부모가 onCartChanged 콜백을 수신하면 부모가 내부 상태를 업데이트하여 부모 가 새 값 으로 inCart 새 변수와 함께 ShoppingListItem의 새 인스턴스를 다시 만들고 생성하도록 트리거합니다.
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

import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget {  // extends: 하나만 상속
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),  // 안쪽 공간에 여백
      decoration: BoxDecoration(color: Colors.blue[500]), // 박스 디자인
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
          Expanded( // 확장된, 위젯의 텍스트가 넘치는 것을 방지
            child: title,
          ),
          const IconButton( // (결정 상수) 코드 실행 이전: const, 코드 실행 이후: final
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
    const MaterialApp( // MaterialApp: 최상단(모든 하위 페이지, 구성요소를 담음)
      title: 'My app', // used by the OS task switcher
      home: SafeArea(  // SafeArea: 충분한 패딩(들여쓰기)으로 자식(child)을 삽입하는 위젯
      // (출처: https://steemit.com/sct/@wonsama/191014-flutter-safearea)
        child: MyScaffold(),
      ),
    ),
  );
}
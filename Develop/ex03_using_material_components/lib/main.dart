import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      // MaterialApp: "경로"라고도 하는 문자열로 식별되는 위젯 스택을 관리
      title: 'Flutter Tutorial',
      home: TutorialHome(),
    ),
  );
}

// Navigator: 화면 간에 원활하게 전환
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
        // floatingActionButton: 화면의 원형의 버튼
        tooltip: 'Add', // used by assistive technologies
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

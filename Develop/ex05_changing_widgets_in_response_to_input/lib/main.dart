import 'package:flutter/material.dart';

// 사용자 입력을 수락하고 해당 build()메서드에서 결과를 직접 사용합니다.
// 더 복잡한 응용 프로그램에서는 위젯 계층 구조의 다른 부분이 다른 문제를 담당할 수 있습니다.

// StatelessWidgets은 상위 위젯에서 인수를 수신하여 final멤버 변수에 저장합니다. build() 위젯이 요청되면 이러한 저장된 값을 사용하여 생성하는 위젯에 대한 새 인수를 파생합니다.
class Counter extends StatefulWidget {
  // StatefulWidgets을 사용
  // StatefulWidgets: 일반적으로 일부 상태를 전달, 상태를 유지하는 데 사용되는 개체를 생성하는 방법을 알고 있는 특수 위젯.
  // 더 복잡한 경험을 구축하기 위해(예: 사용자 입력에 더 흥미로운 방식으로 반응하기 위해) 애플리케이션은 "일반적으로 일부 상태를 전달"합니다.

  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

// StatefulWidget와 State가 별개의 객체인 이유: 서로 다른 수명 주기를 가짐
// StatefulWidget - 현재 상태에서 응용 프로그램의 프레젠테이션을 구성하는 데 사용되는 "임시" 개체
// State - build()에 대한 호출 사이에 지속되어 정보를 "기억"할 수 있습니다.
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

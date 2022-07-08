import 'package:flutter/material.dart';

// 카운터 표시(CounterDisplay)와 카운터 변경(CounterIncrementor) 문제를 명확하게 분리하는 두 개의 새로운 상태 "비저장 위젯 생성"에 주목
// 최종 결과는 이전 예와 동일하다. 하지만 책임을 분리하면 "상위 위젯에서 단순성을 유지"하면서 "개별 위젯에 더 큰 복잡성을 캡슐화"할 수 있습니다.

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

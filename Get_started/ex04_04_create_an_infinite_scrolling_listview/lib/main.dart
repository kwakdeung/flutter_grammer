import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // StatelessWidget: 속성이 변하지 않음.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0), // padding : 안쪽 영역
      itemBuilder: /*1*/ (context, i) {
        // itemBuilder: 리스트에 그려질 항목을 Lazy 하게, 해당 child가 화면에 보여야 할 때 생성한다. 많은 아이템을 그려주어야 할 때 사용
        if (i.isOdd) return const Divider(); /*2*/ // Divider- 시각적으로 구분하는 위젯

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          // length: 데이터의 길이
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          // 스트림 만들기 - 1초마다 데이터를 1개씩 만듬, 10개 까지만. (출처: https://software-creator.tistory.com/9)
        }
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  // StatefulWidget: 속성이 변함.
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

# Understanding constraints(제약 조건 이해)  

![](https://docs.flutter.dev/assets/images/docs/ui/layout/article-hero-image.png)  

먼저 Flutter 레이아웃이 HTML 레이아웃과 매우 다르다고 말하고(아마도 이러한 레이아웃의 출처일 수 있음) 다음 규칙을 외우도록 하세요.
* 제약이 줄어듭니다.
* 사이즈가 올라갑니다. 
* 부모는 위치를 설정합니다.  

더 자세하게:
 * **위젯은 부모**로부터 고유한 **제약 조건**을 받습니다. 제약 조건은 최소 및 최대 너비, 최소 및 최대 높이의 4배 집합입니다.
 * 그런 다음 위젯은 자체 **자식** 목록을 통과합니다 . 위젯은 하나씩 자식에게 **제약 조건**이 무엇인지 (각 자식마다 다를 수 있음) 알려주고 각 자식에게 원하는 크기를 묻습니다.
 * 그런 다음 위젯은 **자식**(축에서 가로로, x축에서 세로로 y)을 하나씩 배치합니다.
 * 그리고 마지막으로 위젯은 부모에게 자체 **크기** 를 알려줍니다 (물론 원래 제약 조건 내에서).  

예를 들어, 구성된 위젯에 padding이 있는 column이 포함되어 있고 다음과 같이 두 개의 children을 배치하려는 경우:  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/children.png)  

협상은 다음과 같이 진행됩니다.

위젯: "부모님, 제 제약 조건은 무엇입니까?"

부모: "너는 픽셀 80에서 300 너비와 높이 30에서 85 사이여야해.

위젯: "흠, 5 픽셀의 padding을 원하기 때문에 내 아이들은 최대 290 픽셀의 너비와 75 픽셀의 높이를 가질 수 있습니다."

위젯: "안녕, 첫째 아이야, 당신은 0에서 290 픽셀 너비와 0에서 75의 키가 커야합니다."

첫 번째 자녀: "알겠습니다. 그러면 너비는 290 픽셀로, 높이는 20 픽셀로 하고 싶습니다."

위젯 : "흠, 두 번째 아이를 첫 번째 아이 아래에 놓고 싶기 때문에 두 번째 아이의 높이 55 픽셀만 남아."

위젯 : "이봐 두 번째 아이, 당신은 넓이 0에서 290, 그리고 0 에서 55의 키가 커야해."

두 번째 자녀 : "알겠습니다. 너비는 140 픽셀로, 높이는 30 픽셀로 하고 싶습니다."

위젯 : "아주 잘 봤습니다. 내 첫 번째 자녀는 위치 x:5 와 y:5가 있고 두 번째 자녀는 x:80 와 y:25가 있습니다.”

위젯 : “부모님, 제 크기는 너비가 300픽셀이고 높이가 30 픽셀의 키로 결정했습니다.”

<br/>

## Limitations(제한 사항)  
* 위젯은 **부모가 지정한 제약 조건 내에서만** 자체 **크기**를 결정할 수 있습니다. 이것은 위젯이 일반적으로 **원하는 크기를 가질 수 없다**는 것을 의미합니다.
* 위젯은 **위젯의 위치를 ​​결정**하는 **위젯의 부모**이기 때문에 **위젯은 알 수 없고 화면에서 자신의 위치를 ​​결정하지 않습니다.**
* 부모의 크기와 위치는 차례로 **자신의 부모에 따라 달라지므로** 전체 트리를 고려하지 않고 위젯의 크기와 위치를 정확하게 정의하는 것은 불가능합니다.
* 자식이 부모와 다른 크기를 원하고 부모가 이를 정렬할 정보가 충분하지 않은 경우 **자식의 크기는 무시**될 수 있습니다. **정렬을 정의할 때 구체적으로 지정하십시오.**

<br/>

## 예  
```dart
import 'package:flutter/material.dart';

void main() => runApp(const HomePage());

const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = TextStyle(fontSize: 30);

//////////////////////////////////////////////////

class HomePage extends StatelessWidget {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
        return const FlutterLayoutArticle([
            Example1(),
            Example2(),
            Example3(),
            Example4(),
            Example5(),
            Example6(),
            Example7(),
            Example8(),
            Example9(),
            Example10(),
            Example11(),
            Example12(),
            Example13(),
            Example14(),
            Example15(),
            Example16(),
            Example17(),
            Example18(),
            Example19(),
            Example20(),
            Example21(),
            Example22(),
            Example23(),
            Example24(),
            Example25(),
            Example26(),
            Example27(),
            Example28(),
            Example29(),
        ]);
    },
},

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
    const Example({super.key});

    String get code;

    String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
    const FlutterLayoutArticle(
        this.examples, {
        super.key,
    });

    final List<Example> examples;

    @override
    State<FlutterLayoutArticle> createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
    late int count;
    late Widget example;
    late String code;
    late String explanation;

    @override
    void initState() {
        count = 1;
        code = const Example1().code;
        explanation = const Example1().explanation;

        super.initState();
    }

    @override
    void didUpdateWidget(FlutterLayoutArticle oldWidget) {
        super.didUpdateWidget(oldWidget);
        var example = widget.examples[count - 1];
        code = example.code;
        explanation = example.explanation;
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Layout Article',
            home: SafeArea(
                child: Material(
                    color: Colors.black,
                    child: FittedBox(
                        child: Container(
                            width: 400,
                            height: 670,
                            color: const Color(0xFFCCCCCC),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Expanded(
                                        child: ConstrainedBox(
                                            constraints: const BoxConstraints.tightFor(
                                                width: double.infinity, height: double.infinity),
                                            ),
                                            child: widget.examples[count - 1])),
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: Colors.black,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                    for (int i =0; i < widget.examples.length; i++)
                                                    Container(
                                                        width: 58,
                                                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                                        child: button(i + 1),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Container(
                                        height: 273,
                                        color: Colors.grey[50],
                                        child: Scrollbar(
                                            child: SingleChildScrollView(
                                                key: ValueKey(count),
                                                child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                        children: [
                                                            Center(child: Text(code)),
                                                            const SizedBox(height: 15),
                                                            Text(
                                                                explanation,                                                                    style: style: TextStyle(
                                                                    color: Colors.blue[900],
                                                                    fontStyle: FontStyle.italic),                                                                  
                                                            ),
                                                        ],                                                                
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ),        
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
Widget button(int exampleNumber) {
    return Button(
        key: ValueKey('button$exampleNumber'),
        isSelected: count == exampleNumber,
        exampleNumber: exampleNumber,
        onPressed: () {
            showExample(
                exampleNumber,
                widget.examples[exampleNumber - 1].code,
                widget.examples[exampleNumber - 1].explanation,
            );
        },
    );
},

void showExample(int exampleNumber, String code, String explanation) {
    setState(() {
        count = exampleNumber;
        this.code = code;
        this.explanation = explanation;
    });
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
    final bool isSelected;
    final int exampleNumber;
    final VoidCallback onPressed;

    const Button({
        required Key key,
        required this.isSelected,
        required this.exampleNumber,
        required this.onPressed,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: isSelected ? Colors.grey : Colors.grey[800],
            ),
            child: Text(exampleNumber.toString()),
            onPressed: () {
                Scrollable.ensureVisible(
                    context,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                    alignment: 0.5,
                );
                onPressed();
            },
        );
    },
},
//////////////////////////////////////////////////

class Example1 extends Example {
    const Example1({super.key});

    @override
    final code = 'Container(color: red)';

    @override
    final explanation = 'The screen is the parent of the Container, '
      'and it forces the Container to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen and paints it red.';

    @override
    Widget build(BuildContext context) {
        return Container(color: red);
    }
}

//////////////////////////////////////////////////

class Example2 extends Example {
    const Example2({super.key});

    @override
    final code = 'Container(width: 100, height: 100, color: red)';

    @override
    final String explanation = 'The red Container wants to be 100x100, but it can\'t, '
      'because the screen forces it to be exactly the same size as the screen.'
      '\n\n'
      'So the Container fills the screen.';

    @override
    Widget build(BuildContext context) {
        return Container(width: 100, height: 100, color: red);
    }
}

//////////////////////////////////////////////////

class Example3 extends Example {
    const Example3({super.key});

    @override
    final code = 'Center(\n'
        '   child: Container(width: 100, height: 100, color: red))';

    @override
    final String explanation = 
        'The screen forces the Center to be exactly the same size as the screen, '
        'so the Center fills the screen.'
        '\n\n'
        'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
        'Now the Container can indeed be 100x100.';


    @override
    Widget build(BuildContext context) {
        return Center(
            child: Container(width: 100, height: 100, color: red),
        );            
    }
}

//////////////////////////////////////////////////

class Example4 extends Example {
    const Example4({super.key});

    @override
    final code = 'Align(\n'
      '   alignment: Alignment.bottomRight,\n'
      '   child: Container(width: 100, height: 100, color: red))';

    @override
    final String explanation = 
        'This is different from the previous example in that it uses Align instead of Center.'
        '\n\n'
        'Align also tells the Container that it can be any size it wants, but if there is empty space it won\'t center the Container. '
        'Instead, it aligns the Container to the bottom-right of the available space.';


    @override
    Widget build(BuildContext context) {
        return Align(
            alignment: Alignment.bottomRight,
            child: Container(width: 100, height: 100, color: red),
        );            
    }
}

//////////////////////////////////////////////////

class Example5 extends Example {
    const Example5({super.key});

    @override
    final code = 'Center(\n'
        '   child: Container(\n'
        '              color: red,\n'
        '              width: double.infinity,\n'
        '              height: double.infinity))';

    @override
    final String explanation = 
        'The screen forces the Center to be exactly the same size as the screen, '
        'so the Center fills the screen.'
        '\n\n'
        'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
        'The Container wants to be of infinite size, but since it can\'t be bigger than the screen, it just fills the screen.';

    @override
    Widget build(BuildContext context) {
        return Center(            
            child: Container(
                width: double.infinity, height: double.infinity, color: red),
        );            
    }
}

//////////////////////////////////////////////////

class Example6 extends Example {
    const Example6({super.key});

    @override
    final code = 'Center(child: Container(color: red))';

    @override
    final String explanation = 
        'The screen forces the Center to be exactly the same size as the screen, '
        'so the Center fills the screen.'
        '\n\n'
        'The Center tells the Container that it can be any size it wants, but not bigger than the screen.'
        '\n\n'
        'Since the Container has no child and no fixed size, it decides it wants to be as big as possible, so it fills the whole screen.'
        '\n\n'
        'But why does the Container decide that? '
        'Simply because that\'s a design decision by those who created the Container widget. '
        'It could have been created differently, and you have to read the Container documentation to understand how it behaves, depending on the circumstances. ';

    @override
    Widget build(BuildContext context) {
        return Center(            
            child: Container(color: red),
        );            
    }
}

//////////////////////////////////////////////////

class Example7 extends Example {
    const Example7({super.key});

    @override
    final code = 'Center(\n'
        '   child: Container(color: red\n'
        '      child: Container(color: green, width: 30, height: 30)))';

    @override
    final String explanation = 
        'The screen forces the Center to be exactly the same size as the screen, '
        'so the Center fills the screen.'
        '\n\n'
        'The Center tells the red Container that it can be any size it wants, but not bigger than the screen.'
        'Since the red Container has no size but has a child, it decides it wants to be the same size as its child.'
        '\n\n'
        'The red Container tells its child that it can be any size it wants, but not bigger than the screen.'
        '\n\n'
        'The child is a green Container that wants to be 30x30.'
        '\n\n'
        'Since the red `Container` has no size but has a child, it decides it wants to be the same size as its child. '
        'The red color isn\'t visible, since the green Container entirely covers all of the red Container.';

    @override
    Widget build(BuildContext context) {
        return Center(            
            child: Container(
                color: red
                child: Container(color: green, width: 30, height: 30),
            ),
        );            
    }
}

//////////////////////////////////////////////////

class Example8 extends Example {
    const Example8({super.key});

    @override
    final code = 'Center(\n'
        '   child: Container(color: red\n'
        '      padding: const EdgeInsets.all(20.0),\n'
        '      child: Container(color: green, width: 30, height: 30)))';

    @override
    final String explanation = 
        'The red Container sizes itself to its children size, but it takes its own padding into consideration. '
        'So it is also 30x30 plus padding. '
        'The red color is visible because of the padding, and the green Container has the same size as in the previous example.';

    @override
    Widget build(BuildContext context) {
        return Center(            
            child: Container(
                padding: const EdgetInsets.all(20.0),
                color: red,
                child: Container(color: green, width: 30, height: 30),
            ),
        );            
    }
}

//////////////////////////////////////////////////

class Example9 extends Example {
    const Example9({super.key});

    @override
    final code = 'ConstrainedBox(\n'
        '   constraints: BoxConstraints(\n'
        '              minWidth: 70, minHeight: 70,\n'
        '              maxWidth: 150, maxHeight: 150),\n'
        '      child: Container(color: red, width: 10, height: 10)))';

    @override
    final String explanation = 
        'You might guess that the Container has to be between 70 and 150 pixels, but you would be wrong. '
        'The ConstrainedBox only imposes ADDITIONAL constraints from those it receives from its parent.'
        '\n\n'
        'Here, the screen forces the ConstrainedBox to be exactly the same size as the screen, '
        'so it tells its child Container to also assume the size of the screen, '
        'thus ignoring its \'constraints\' parameter.';

    @override
    Widget build(BuildContext context) {
        return ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 70,
                minHeight: 70,
                maxWidth: 150,
                maxHeight: 150,
            ),            
            child: Container(color: red, width: 10, height: 10),            
        );            
    }
}

//////////////////////////////////////////////////

class Example10 extends Example {
    const Example10({super.key});

    @override
    final code = 'Center(\n'
        '   child: ConstrainedBox(\n'
        '      constraints: BoxConstraints(\n'
        '                 minWidth: 70, minHeight: 70,\n'
        '                 maxWidth: 150, maxHeight: 150),\n'
        '        child: Container(color: red, width: 10, height: 10))))';

    @override
    final String explanation = 
        'Now, Center allows ConstrainedBox to be any size up to the screen size.'
        '\n\n'
        'The ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child.'
        '\n\n'
        'The Container must be between 70 and 150 pixels. It wants to have 10 pixels, so it will end up having 70 (the MINIMUM).';

    @override
    Widget build(BuildContext context) {
        return Center(
            ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 70,
                    minHeight: 70,
                    maxWidth: 150,
                    maxHeight: 150,
                ),            
                child: Container(color: red, width: 10, height: 10),            
            ),
        );    
    }
}

//////////////////////////////////////////////////

class Example11 extends Example {
    const Example11({super.key});

    @override
    final code = 'Center(\n'
        '   child: ConstrainedBox(\n'
        '      constraints: BoxConstraints(\n'
        '                 minWidth: 70, minHeight: 70,\n'
        '                 maxWidth: 150, maxHeight: 150),\n'
        '        child: Container(color: red, width: 1000, height: 1000))))';

    @override
    final String explanation =
        'Center allows ConstrainedBox to be any size up to the screen size.'
        'The ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child'
        '\n\n'
        'The Container must be between 70 and 150 pixels. It wants to have 1000 pixels, so it ends up having 150 (the MAXIMUM).';

    @override
    Widget build(BuildContext context) {
        return Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 70,
                    minHeight: 70,
                    maxWidth: 150,
                    maxHeight: 150,                
                ),
                child: Container(color: red, width: 1000, height: 1000),
            ),
        );    
    }
}

//////////////////////////////////////////////////

class Example12 extends Example {
    const Example12({super.key});

    @override
    final code = 'Center(\n'
      '   child: ConstrainedBox(\n'
      '      constraints: BoxConstraints(\n'
      '                 minWidth: 70, minHeight: 70,\n'
      '                 maxWidth: 150, maxHeight: 150),\n'
      '        child: Container(color: red, width: 100, height: 100))))';
        
    @override
    final String explanation =
        'Center allows ConstrainedBox to be any size up to the screen size.'
        'ConstrainedBox imposes ADDITIONAL constraints from its \'constraints\' parameter onto its child.'
        '\n\n'
        'The Container must be between 70 and 150 pixels. It wants to have 100 pixels, and that\'s the size it has, since that\'s between 70 and 150.';

    @override
    Widget build(BuildContext context) {
        return Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 70,
                    minHeight: 70,
                    maxWidth: 150,
                    maxHeight: 150,                
                ),
                child: Container(color: red, width: 1000, height: 1000),
            ),
        );    
    }
}

//////////////////////////////////////////////////

class Example13 extends Example {
    const Example13({super.key});

    @override
    final code = 'UnconstrainedBox(\n'
        '   child: Container(color: red, width: 20, height: 50));';

    @override
    final String explanation =
        'The screen forces the UnconstrainedBox to be exactly the same size as the screen.'
        'However, the UnconstrainedBox lets its child Container be any size it wants.';

    @override
    Widget build(BuildContext context) {
        return UnconstrainedBox(
        child: Container(color: red, width: 20, height: 50),
        );
    }
}

//////////////////////////////////////////////////

class Example14 extends Example {
    const Example14({super.key});

    @override
    final code = 'UnconstrainedBox(\n'
        '   child: Container(color: red, width: 4000, height: 50));';

    @override
    final String explanation =
        'The screen forces the UnconstrainedBox to be exactly the same size as the screen, '
        'and UnconstrainedBox lets its child Container be any size it wants.'
        '\n\n'
        'Unfortunately, in this case the Container has 4000 pixels of width and is too big to fit in the UnconstrainedBox, '
        'so the UnconstrainedBox displays the much dreaded "overflow warning".';

    @override
    Widget build(BuildContext context) {
        return UnconstrainedBox(
        child: Container(color: red, width: 4000, height: 50),
        );
    }
}

//////////////////////////////////////////////////

class Example15 extends Example {
    const Example15({super.key});

    @override
    final code = 'OverflowBox(\n'
        '   minWidth: 0.0,'
        '   minHeight: 0.0,'
        '   maxWidth: double.infinity,'
        '   maxHeight: double.infinity,'
        '   child: Container(color: red, width: 4000, height: 50));';

    @override
    final String explanation =
        'The screen forces the OverflowBox to be exactly the same size as the screen, '
        'and OverflowBox lets its child Container be any size it wants.'
        '\n\n'
        'OverflowBox is similar to UnconstrainedBox, and the difference is that it won\'t display any warnings if the child doesn\'t fit the space.'
        '\n\n'
        'In this case the Container is 4000 pixels wide, and is too big to fit in the OverflowBox, '
        'but the OverflowBox simply shows as much as it can, with no warnings given.';

    @override
    Widget build(BuildContext context) {
        return OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Container(color: red, width: 4000, height: 50),
        );
    }
}

//////////////////////////////////////////////////

class Example16 extends Example {
    const Example16({super.key});

    @override
    final code = 'UnconstrainedBox(\n'
        '   child: Container(color: Colors.red, width: double.infinity, height: 100));';

    @override
    final String explanation =
        'This won\'t render anything, and you\'ll see an error in the console.'
        '\n\n'
        'The UnconstrainedBox lets its child be any size it wants, '
        'however its child is a Container with infinite size.'
        '\n\n'
        'Flutter can\'t render infinite sizes, so it throws an error with the following message: '
        '"BoxConstraints forces an infinite width."';

    @override
    Widget build(BuildContext context) {
        return UnconstrainedBox(
        child: Container(color: Colors.red, width: double.infinity, height: 100),
        );
    }
}

//////////////////////////////////////////////////

class Example17 extends Example {
    const Example17({super.key});

    @override
    final code = 'UnconstrainedBox(\n'
        '   child: LimitedBox(maxWidth: 100,\n'
        '      child: Container(color: Colors.red,\n'
        '                       width: double.infinity, height: 100));';

    @override
    final String explanation = 'Here you won\'t get an error anymore, '
        'because when the LimitedBox is given an infinite size by the UnconstrainedBox, '
        'it passes a maximum width of 100 down to its child.'
        '\n\n'
        'If you swap the UnconstrainedBox for a Center widget, '
        'the LimitedBox won\'t apply its limit anymore (since its limit is only applied when it gets infinite constraints), '
        'and the width of the Container is allowed to grow past 100.'
        '\n\n'
        'This explains the difference between a LimitedBox and a ConstrainedBox.';

    @override
    Widget build(BuildContext context) {
        return UnconstrainedBox(
        child: LimitedBox(
            maxWidth: 100,
            child: Container(
            color: Colors.red,
            width: double.infinity,
            height: 100,
            ),
        ),
        );
    }
}

//////////////////////////////////////////////////

class Example18 extends Example {
    const Example18({super.key});

    @override
    final code = 'FittedBox(\n'
        '   child: Text(\'Some Example Text.\'));';

    @override
    final String explanation =
        'The screen forces the FittedBox to be exactly the same size as the screen.'
        'The Text has some natural width (also called its intrinsic width) that depends on the amount of text, its font size, and so on.'
        '\n\n'
        'The FittedBox lets the Text be any size it wants, '
        'but after the Text tells its size to the FittedBox, '
        'the FittedBox scales the Text until it fills all of the available width.';

    @override
    Widget build(BuildContext context) {
        return const FittedBox(
        child: Text('Some Example Text.'),
        );
    }
}

//////////////////////////////////////////////////

class Example19 extends Example {
    const Example19({super.key});

    @override
    final code = 'Center(\n'
        '   child: FittedBox(\n'
        '      child: Text(\'Some Example Text.\')));';

    @override
    final String explanation =
        'But what happens if you put the FittedBox inside of a Center widget? '
        'The Center lets the FittedBox be any size it wants, up to the screen size.'
        '\n\n'
        'The FittedBox then sizes itself to the Text, and lets the Text be any size it wants.'
        '\n\n'
        'Since both FittedBox and the Text have the same size, no scaling happens.';

    @override
    Widget build(BuildContext context) {
        return const Center(
        child: FittedBox(
            child: Text('Some Example Text.'),
        ),
        );
    }
}

////////////////////////////////////////////////////

class Example20 extends Example {
    const Example20({super.key});

    @override
    final code = 'Center(\n'
        '   child: FittedBox(\n'
        '      child: Text(\'…\')));';
        
    @override
    final String explanation =
        'However, what happens if FittedBox is inside of a Center widget, but the Text is too large to fit the screen?'
        '\n\n'
        'FittedBox tries to size itself to the Text, but it can\'t be bigger than the screen. '
        'It then assumes the screen size, and resizes Text so that it fits the screen, too.';

    @override
    Widget build(BuildContext context) {
        return const Center(
            child: FittedBox(
                child: Text(
                    'This is some very very very large text that is too big to fit a regular screen in a single line.'),
            ),
        );
    }
}

//////////////////////////////////////////////////

class Example21 extends Example {
    const Example21({super.key});

    @override
    final code = 'Center(\n'
        '   child: Text(\'…\'));';

    @override
    final String explanation = 'If, however, you remove the FittedBox, '
        'the Text gets its maximum width from the screen, '
        'and breaks the line so that it fits the screen.';

    @override
    Widget build(BuildContext context) {
        return const Center(
        child: Text(
            'This is some very very very large text that is too big to fit a regular screen in a single line.'),
        );
    }
}

//////////////////////////////////////////////////

class Example22 extends Example {
    const Example22({super.key});

    @override
    final code = 'FittedBox(\n'
        '   child: Container(\n'
        '      height: 20.0, width: double.infinity));';

    @override
    final String explanation =
        'FittedBox can only scale a widget that is BOUNDED (has non-infinite width and height).'
        'Otherwise, it won\'t render anything, and you\'ll see an error in the console.';

    @override
    Widget build(BuildContext context) {
        return FittedBox(
            child: Container(
                height: 20.0,
                width: double.infinity,
                color: Colors.red,
            ),
        );
    }
}

//////////////////////////////////////////////////

class Example23 extends Example {
    const Example23({super.key});

    @override
    final code = 'Row(children:[\n'
        '   Container(color: red, child: Text(\'Hello!\'))\n'
        '   Container(color: green, child: Text(\'Goodbye!\'))]';

    @override
    final String explanation =
        'The screen forces the Row to be exactly the same size as the screen.'
        '\n\n'
        'Just like an UnconstrainedBox, the Row won\'t impose any constraints onto its children, '
        'and instead lets them be any size they want.'
        '\n\n'
        'The Row then puts them side-by-side, and any extra space remains empty.';

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Container(color: red, child: const Text('Hello!', style: big)),
                Container(color: green, child: const Text('Goodbye!', style: big)),
            ],
        );
    }
}

//////////////////////////////////////////////////

class Example24 extends Example {
    const Example24({super.key});

    @override
    final code = 'Row(children:[\n'
        '   Container(color: red, child: Text(\'…\'))\n'
        '   Container(color: green, child: Text(\'Goodbye!\'))]';
        
    @override
    final String explanation =
        'Since the Row won\'t impose any constraints onto its children, '
        'it\'s quite possible that the children might be too big to fit the available width of the Row.'
        'In this case, just like an UnconstrainedBox, the Row displays the "overflow warning".';

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Container(
                color: red,
                    child: const Text(
                        'This is a very long text that '
                        'won\'t fit the line.',
                        style: big,
                    ),
                ),
                Container(color: green, child: const Text('Goodbye!', style: big)),
            ],
        );
    }
}

//////////////////////////////////////////////////

class Example25 extends Example {
    const Example25({super.key});

    @override
    final code = 'Row(children:[\n'
        '   Expanded(\n'
        '       child: Container(color: red, child: Text(\'…\')))\n'
        '   Container(color: green, child: Text(\'Goodbye!\'))]';
        
    @override
    final String explanation =
        'When a Row\'s child is wrapped in an Expanded widget, the Row won\'t let this child define its own width anymore.'
        '\n\n'
        'Instead, it defines the Expanded width according to the other children, and only then the Expanded widget forces the original child to have the Expanded\'s width.'
        '\n\n'
        'In other words, once you use Expanded, the original child\'s width becomes irrelevant, and is ignored.';

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Center(
                        child: Container(
                        color: red,
                            child: const Text(
                                'This is a very long text that won\'t fit the line.',
                                style: big,
                            ),
                        ),
                    ),
                ),
                Container(color: green, child: const Text('Goodbye!', style: big)),
            ],
        );
    }
}

//////////////////////////////////////////////////

class Example26 extends Example {
    const Example26({super.key});

    @override
    final code = 'Row(children:[\n'
        '   Expanded(\n'
        '       child: Container(color: red, child: Text(\'…\')))\n'
        '   Expanded(\n'
        '       child: Container(color: green, child: Text(\'Goodbye!\'))]';

    @override
    final String explanation =
        'If all of Row\'s children are wrapped in Expanded widgets, each Expanded has a size proportional to its flex parameter, '
        'and only then each Expanded widget forces its child to have the Expanded\'s width.'
        '\n\n'
        'In other words, Expanded ignores the preffered width of its children.';

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Container(
                        color: red,
                        child: const Text(
                        'This is a very long text that won\'t fit the line.',
                        style: big,
                        ),
                    ),
                ),
                Expanded(
                    child: Container(
                        color: green,
                        child: const Text(
                        'Goodbye!',
                        style: big,
                        ),
                    ),
                ),
            ],
        );
    }
}

//////////////////////////////////////////////////

class Example27 extends Example {
    const Example27({super.key});

    @override
    final code = 'Row(children:[\n'
        '   Flexible(\n'
        '       child: Container(color: red, child: Text(\'…\')))\n'
        '   Flexible(\n'
        '       child: Container(color: green, child: Text(\'Goodbye!\'))]';
        
    @override
    final String explanation =
        'The only difference if you use Flexible instead of Expanded, '
        'is that Flexible lets its child be SMALLER than the Flexible width, '
        'while Expanded forces its child to have the same width of the Expanded.'
        '\n\n'
        'But both Expanded and Flexible ignore their children\'s width when sizing themselves.'
        '\n\n'
        'This means that it\'s IMPOSSIBLE to expand Row children proportionally to their sizes. '
        'The Row either uses the exact child\'s width, or ignores it completely when you use Expanded or Flexible.';

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Flexible(
                child: Container(
                    color: red,
                    child: const Text(
                    'This is a very long text that won\'t fit the line.',
                    style: big,
                    ),
                ),
                ),
                Flexible(
                child: Container(
                    color: green,
                    child: const Text(
                    'Goodbye!',
                    style: big,
                    ),
                ),
                ),
            ],
        );
    }
}

//////////////////////////////////////////////////

class Example28 extends Example {
    const Example28({super.key});

    @override
    final code = 'Scaffold(\n'
        '   body: Container(color: blue,\n'
        '   child: Column(\n'
        '      children: [\n'
        '         Text(\'Hello!\'),\n'
        '         Text(\'Goodbye!\')])))';

    @override
    final String explanation =
        'The screen forces the Scaffold to be exactly the same size as the screen, '
        'so the Scaffold fills the screen.'
        '\n\n'
        'The Scaffold tells the Container that it can be any size it wants, but not bigger than the screen.'
        '\n\n'
        'When a widget tells its child that it can be smaller than a certain size, '
        'we say the widget supplies "loose" constraints to its child. More on that later.';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                color: blue,
                child: Column(
                    children: const [
                        Text('Hello!'),
                        Text('Goodbye!'),
                    ],
                ),
            ),
        );
    }
}

//////////////////////////////////////////////////

class Example29 extends Example {
    const Example29({super.key});

    @override
    final code = 'Scaffold(\n'
        '   body: Container(color: blue,\n'
        '   child: SizedBox.expand(\n'
        '      child: Column(\n'
        '         children: [\n'
        '            Text(\'Hello!\'),\n'
        '            Text(\'Goodbye!\')]))))';

    @override
    final String explanation =
        'If you want the Scaffold\'s child to be exactly the same size as the Scaffold itself, '
        'you can wrap its child with SizedBox.expand.'
        '\n\n'
        'When a widget tells its child that it must be of a certain size, '
        'we say the widget supplies "tight" constraints to its child. More on that later.';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SizedBox.expand(
                child: Container(
                color: blue,
                    child: Column(
                        children: const [
                        Text('Hello!'),
                        Text('Goodbye!'),
                        ],
                    ),
                ),
            ),
        );
    }
}

//////////////////////////////////////////////////
```  

<br/>

## 예 1  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-1.png)
```dart
Container(color: red)
```
화면은 Container의 부모이며, 화면과 Container 정확히 같은 크기가 되도록 함.  
따라서, 먼저 Container를 화면에 채우고 빨간색으로 칠함.  

<br/>

## 예 2  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-2.png)
```dart
Container(width: 100, height: 100, color: red)
```
Container는 100 x 100이 되기를 원하지만 할 수 없음.  
화면에서 강제로 화면과 정확히 같은 크기가 되기 때문  
그래서 Container 화면을 채움.

<br/>

## 예 3  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-3.png)
```dart
Center(
    child: Container(width: 100, height: 100, color: red),
)
```  
화면은 화면은 정확히 같은 크기가 되도록 강제하여 Center 화면을 채움.  
Center는 원하는 크기가 될 수 있지만 Container 화면보다 크지는 않습니다. 이제 Container는 실제로 100 x 100 이 될 수 있음.

<br/>

## 예 4  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-4.png)
```dart
Align(
    alignment: Alignment.bottomRight,
    child: Contain(width: 100, height: 100, color: red),
)
```
Center 대신 Align을 사용한다는 점에서 앞의 예와 다름.  
Align 또한 Containe처럼 원하는 크기가 될 수 있지만 빈 공간이 있으면 Container가 중앙에 배치되지 않습니다.  대신 Container을 사용 가능한 공간의 bottom-right에 맞춤.

<br/>

## 예 5  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-5.png)
```dart
Center(
    child: Container(
        width: double.infinity, height: double.infinity, color: red),
    ),
)
```
화면은 Center 화면과 정확히 같은 크기가 되도록 강제하여 Center 화면을 채움.  
Container는 infinity(무한한) 크기를 원하지만 화면보다 클 수 없기 때문에 화면을 채울 뿐임.

<br/>

## 예 6  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-6.png)
```dart
Center(
    child: Container(color: red),
)
```
화면은 Center 화면과 정확히 같은 크기가 되도록 강제하여 Center 화면을 채움.  
Center는 원하는 크기가 될 수 있지만 Container 화면보다 크지는 않습니다. Container 이후로 자식이 없고 고정된 크기가 없기 때문에 최대한 크게 만들고자 하여 전체화면을 채움.  

그런데 왜 Container를 그렇게 결정합니까? 그것은 Container 위젯을 만든 사람들의 디자인 결정이기 때문임. 다르게 생성되었을 수 있으며 상황에 따라 작동 방식을 이해하려면 Container 설명서를 읽어야 함.

<br/>

## 예 7  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-7.png)
```dart
Center(
    child: Container(
        color: red,
        child: Container(color: green, width: 30, height: 30),
    ),
)
```
화면은 Center 화면과 정확히 같은 크기가 되도록 강제하여 Center 화면을 채움.  
Center는 원하는 크기가 될 수 있지만 red Container보다 크지 않음을 알려줌.  
red Container는 이후로 크기가 없지만 자식이 있으므로 자식과 같은 크기를 원한다고 결정함.  
red Container는 자식에게 원하는 모든 크기가 가능하지만 화면보다는 크지 않음을 알려줌.  
아이의 green Container는 30 x 30이 되고자 함. 빨강 Container이 자식의 크기에 맞게 크기가 조정된다는 점을 감안할 때 역시 30 x 30입니다. green Container가 red Container를 완전히 덮기 때문에 red(빨강)가 보이지 않음.  

<br/>

## 예 8  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-8.png)
```dart
Center(
    child: Container(
        padding: const EdgeInsets.all(20.0),
        color: red,
        child: Container(color: green, width: 30, height: 30),
    ),
)
```  
red Container는 child 크기에 맞게 자체적으로 크기를 조정하지만 자체 padding을 고려함.  따라서 red Container는 30 x 30에서 20.0씩 더해진 padding임. padding 때문에 빨간색이 보이고, green Container는 앞의 예시와 같은 크기를 가짐.  

<br/>

## 예 9  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-9.png)
```dart
ConstrainedBox(
    constraints: const BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
    ),
    child: Container(color: red, width: 10, height: 10),
)
```  
Container 70에서 150 픽셀 사이여야 한다고 추측할 수 있지만 이는 잘못된 것임. ConstrainedBox는 오직 **부모**로부터 받은 것들로부터 추가적인 제약을 부과함.  

여기에서 화면은 ConstrainedBox 화면과 정확히 **같은 크기**가 되도록 **강제**하므로 자식 Container에게도 화면 크기를 가정하도록 지시하여 constraints parameter를 무시함.

<br/>

## 예 10  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-10.png)
```dart
Center(
    child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 70,
            minHeight: 70,
            maxWidth: 150,
            maxHeight: 150,
        ),
        child: Container(color: red, width: 10, height: 10),
    ),
)
```  
이제 Center는 ConstrainedBox의 화면 크기까지 모든 크기를 허용. ConstrainedBox의 매개변수의 **추가** 제약 조건을 자식에 부과함.  
Container는 70~150 픽셀 사이여야함. 10 픽셀을 원하지만 최소 70이 됩니다.  
(minWidth: 70, minHeight: 70로 constraints 되어 있기 때문에)

<br/>

## 예 11  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-11.png)
```dart
Center(
    child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 70,
            minHeight: 70,
            maxWidth: 150,
            maxHeight: 150,
        ),
        child: Container(color: red, width: 1000, height: 1000),
    ),
)
```
이제 Center는 ConstrainedBox의 화면 크기까지 모든 크기를 허용. ConstrainedBox의 매개변수의 **추가** 제약 조건을 자식에 부과함.  
Container는 70~150 픽셀 사이여야함. 1000 픽셀을 원하지만 최대 150이 됨.  
(maxWidth: 150, maxHeight: 150로 constraints 되어 있기 때문에)

<br/>

## 예 12  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-12.png)
```dart
Center(
    child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 70,
            minHeight: 70,
            maxWidth: 150,
            maxHeight: 150,
        ),
        child: Container(color: red, width: 100, height: 100),
    ),
)
```
이제 Center는 ConstrainedBox의 화면 크기까지 모든 크기를 허용. ConstrainedBox의 매개변수의 **추가** 제약 조건을 자식에 부과함.  
Container는 70~150 픽셀 사이여야함. 크기가 70~150이기 때문에 100 픽셀을 원하고 구현됨.  

<br/>

## 예 13  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-13.png)
```dart
UnconstrainedBox(
    child: Container(color: red, width: 20, height: 50),
)
```  
화면은 UnconstrainedBox 화면과 정확히 같은 크기가 되도록 함. 그러나 UnconstrainedBox 자식 Container이 원하는 크기로 만들 수 있음.  

<br/>

## 예 14    
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-14.png)
```dart
UnconstrainedBox(
    child: Container(color: red, width: 4000, height: 50),
)
```  
화면은 UnconstrainedBox 화면과 정확히 같은 크기가 되도록 강제하고 UnconstrainedBox는 자식 Container이 원하는 크기가 되도록 함.  

안타깝게도, 이 경우는 Container의 너비가 4000픽셀이며 UnconstrainedBox가 너무 커서 맞지 않으므로, 오버플로 경고가 표시됨.  

<br/>

## 예 15  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-15.png)
```dart
OverflowBox(
    minWidth: 0.0,
    minHeight: 0.0,
    maxWidth: double.infinity,
    maxHeight: double.infinity,
    child: Container(color: red, width: 4000, height: 50),
)
```
화면은 OverflowBox화면과 정확히 같은 크기가 되도록 강제하고 OverflowBox는 자식 Container가 원하는 크기가 되도록함.   
OverflowBox와 UnconstrainedBox는 비슷합니다. 차이점은 OverflowBox는 아이가 공간에 맞지 않으면 **경고를 표시하지 않는다**는 것.  
이 경우 Container 너비가 4000 픽셀이고 너무 커서 OverflowBox에 맞지 않지만 OverflowBox 경고 없이 가능한 한 많이 표시됨.  

<br/>

## 예 16  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-16.png)
```dart
UnconstraintedBox(
    child: Container(color: Colors.red, width: double.infinity, height: 100),
)
```  
아무 것도 렌더링되지 않으며 콘솔에 오류가 표시됨.  
unconstrainedBox는 자식을 원하는 크기로 만들 수 있지만 자식은 Container 크기가 무한함.  
**Flutter**는 **무한한 크기를 렌더링 할 수 없으므로** 다음 메세지와 함께 오류가 발생: BoxConstraints forces an infinite width.  

<br/>

## 예 17  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-17.png)
```dart
UnconstrainedBox(
    child: LimitedBox(
        maxWidth: 100,
        child: Container(
            color: Colors.red,
            width: double.infinity,
            height: 100,
        ),
    ),
)
```  
여기서 더 이상 오류가 발생하지 않음. 왜냐하면 LimitedBox에 무한한 크기가 주어지기 때문임. 자식에게 maxWidth: 100을 전달함.  
만약 Center 위젯을 위한 UnconstrainedBox으로 바꾸면, LimitedBox는 더 이상 제한이 적용되지 않고(제한이 무한 제약 조건을 받을 때만 적용되기 때문) Container의 너비가 100을 초과될 수 있음.  
이것은 ConstrainedBox와 LimitedBox의 차이점을 설명함.  

<br/>

## 예 18  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-18.png)
```dart
const FittedBox(
    child: Text('Some Example Text.'),
)
```  
화면과 FittedBox 화면은 정확히 같은 크기가 되도록 합니다. Text는 텍스트의 양, 글꼴 크기 등에 따라 달라지는 자연스러운 너비(내재 너비라고도 함)가 있음.  
FittedBox는 원하는 모든 크기를 허용하지만 크기를 Text에 지정한 후 사용 가능한 모든 너비를 채울 때까지 Text의 크기를 조정합니다.  

<br/>

## 예 19  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-19.png)
```dart
const Center(
    child: FittedBox(
        child: Text('Some Example Text.'),
    ),
)
```  
하지만 FittedBox를 Center 위젯 내부에 넣으면 어떻게 될까요? Center 화면 크기까지 FittedBox의 원하는 크기로 설정할 수 있음.  
그런 다음 FittedBox의 자체 크기를 Text의 원하는 크기로 설정함. FittedBox와 Text가 둘 다 크기가 같기 때문에 Scaling(스케일링)이 발생하지 않음.  

Scaling(스케일링): **리소스**를 보다 효율적으로 관리하기 위한 것으로 **용량을 조정**
(출처: https://youjin86.tistory.com/m/137)  

<br/>

## 예 20  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-20.png)
```dart
const Center(
    child: FittedBox(
        child: Text(
            'This is some very very very large text that is too big to fit a regular screen in a single line.'),
        ),
    ),
)
```  
그러나 Center 위젯의 FittedBox 내부에 있지만 너무 커서 화면에 맞지 않으면 어떻게 될까요?  
**FittedBox**는 크기를 조정하려고 하지만 **화면보다 클 수 없습니다.** 그런 다음 **화면 크기를 가정**하고 화면에 맞도록 크기도 조정함.

<br/>

## 예 21  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-21.png)
```dart
const Center(
    child: Text(
        'This is some very very very large text that is too big to fit a regular screen in a single line.'),
    ),
)
```  
그러나 예 20과 다르게 FittedBox를 제거하면, Text는 **화면에서 최대 너비**를 가져오고 화면에 맞도록 **줄을 나눔**.  

<br/>

## 예 22  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-22.png)
```dart
FittedBox(
    child: Container(
        height: 20.0,
        width: double.infinity,
        color: Colors.red,
    ),
)
```  
FittedBox **경계가 있는 위젯만 크기를 조정**할 수 있음.(너비와 높이가 무한하지 않음). 그렇지 않으면 아무 것도 렌더링되지 않으며 콘솔에 오류가 표시됨.  
현 상황: FittedBox 경계가 있는 위젯 밖의 크기를 조정함.(너비와 높이가 무한하지 않은데 너비을 무한하게 함(width: double.infinity)).  

<br/>

## 예 23  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-23.png)
```dart
Row(
    children: [
        Container(color: red, child: const Text('Hello!', style: big)),
        Container(color: green, child: const Text('Goodbye!', style: big)),
    ],
)
```  
화면은 Row 화면과 정확히 같은 크기가 되도록 함.  

UnconstrainedBox와 마찬가지로, Row의 자식에게 제약 조건을 부과하지 않고 **대신 원하는 크기로 허용함.** 그런 다음 Row는 **나란히** 놓고 **추가 공간은 비어있음.**  

<br/>

## 예 24  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-24.png)
```dart
Row(
    children: [
        Container(
            color: red,
            child: const Text(
                'This is a very long text that '
                'won\'t fit the line.',
                style: big,
            ),
        ),
        Container(color: green, child: const Text('Goodbye!', style: big)),
    ],
)
```  
Row 이후로 자식에게 제한 가하지 않기 때문에 자식이 **너무 커서 사용 가능한 너비에 맞지 않을 수 있음.** 이 경우 **UnconstrainedBox** 와 마찬가지로 Row에 **"오버플로우 경고"**가 표시됨.  

<br/>

## 예 25  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-25.png)
```dart
Row(
    children: [
        Expanded(
            child: Center(
                child: Container(
                    color: red,
                    child: const Text(
                        'This is a very long text that won\'t fit the line.',
                        style: big,
                    ),
                ),
            ),
        ),
        Container(color: green, child: const Text('Goodbye!', style: big)),
    ],
)
```
Row의 자식이 Expanded 위젯에 래핑되면 Row의 자식이 더 이상 자신의 너비를 정의하도록 허용하지 않음.  
대신 다른 자식에 따라 Expanded의 너비를 정의하고 Expanded 위젯은 원래 자식이 Expanded의 너비를 갖도록 강제함.  
즉, **Expanded를 사용**하면 원래 자식의 **너비가 무의미**해지고 무시됨.  

<br/>

## 예 26  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-26.png)
```dart
Row(
    children: [
        Expanded(
            child: Container(
                color: red,
                child: const Text(
                    'This is a very long text that won\'t fit the line.',
                    style: big,
                ),
            ),
        ),
        Expanded(
            child: Container(
                color: green,
                child: const Text(
                    'Goodbye!',
                    style: big,
                ),
            ),
        ),
    ],
)
```  
만약 Row의 모든 자식이 Expanded 위젯으로 래핑된 경우 각각의 Expanded의 크기는 flex 매개변수에 비례하며 각 Expanded 위젯은 자식이 Expanded 의 너비를 갖도록 강제함.  
즉, Expanded의 자식의 기본 너비를 무시함.  

<br/>

## 예 27  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-27.png)
```dart
Row(
    children: [
        Flexible(
            child: Container(
                color: red,
                child: const Text(
                    'This is a very long text that won\'t fit the line.',
                    style: big
                ),
            ),
        ),
        Flexible(
            child: Container(
                color: green,
                child: const Text(
                    'Goodbye!',
                    style: big,
                ),
            ),
        ),
    ],
)
```  
만약 Expanded 대신 Flexible을 사용하는 경우의 **유일한 차이점**은 Flexible의 자식이 자신보다 너비가 같거나 더 작도록 하고, **Flexible**이 **정확히 같은 너비**를 갖도록 한다는 것임. 그러나 **Expanded와 Flexible 둘 다 크기를 조정**할 때 **자녀의 너비를 무시**함.  
> **참고:** 즉, 크기에 비례하여 Row의 자식을 확장할 수 없음. Row는 Expanded 또는 Flexible의 정확한 자식의 너비를 사용하거나 또는 사용할 때 완전히 무시함.  

<br/>

## 예 28  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-28.png)
```dart
Scafford(
    body: Container(
        color: blue,
        child: Column(
            children: const [
                Text('Hello'),
                Text('Goodbye!'),
            ],
        ),
    ),
)
```  
화면은 Scafford 화면과 정확히 **같은 크기**가 되도록 강제하여 Scafford의 화면을 채움. Scafford 는 원하는 크기가 될 수 있지만 **Container 화면보다 크지는 않음.**  
> **참고:** 위젯이 특정 크기보다 작을 수 있다고 자식에게 알릴 때 위젯은 자식에게 느슨한 제약 조건을 제공한다고 말함. 나중에 더 자세히 설명할 것임.

<br/>

## 예 29  
![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-29.png)
```dart
Scaffold(
    body: SizedBox.expand(  // 박스 크기: Scaffold의 자식 = Scaffold
        child: Container(
            color: blue,
            child: Column(
                children: const [
                    Text('Hello'),
                    Text('Goodbye!'),
                ],
            ),
        ),
    ),
)
çç  
만약 Scaffold의 자식이 Scaffold 자신과 정확히 같은 크기가 되도록 하려면, 자식을 SizedBox.expand로 감싸면 됨.  
>**참고:** 위젯이 자식에게 특정 크기여야 한다고 말할 때 위젯은 **자식**에게 **엄격한 제약 조건을 제공**한다고 말함.  

<br/>

## Tight vs. loose constraints(빡빡한 구속과 느슨한 구속)  
어떤 제약 조건이 "Tight"하거나 "loose"하다는 말을 듣는 것은 매우 일반적인 의미.  

엄격한 제약 조건은 정확한 크기의 **단일 가능성**을 제공. 즉, 엄격한 제약 조건의 최대 너비는 최소 너비와 같음.  
Flutter의 box.dart 파일로 이동하여 BoxConstraints 생성자를 검색하면 다음을 찾을 수 있음.  
```dart
BoxConstraints.tight(Size size)  // BoxConstraints.tight - 빡빡한 제약 조건
    : minWidth = size.width,
      maxWidth = size.width,
      minHeight = size.height,
      maxHeight = size.height;
```  
위의 **예 2**를 다시 방문하면 화면에서 red Container 화면과 정확히 같은 크기가 되도록 강제한다고 알려줌. 물론 Container 화면은 엄격한 제약 조건  
반면에 느슨한 제약 조건은 최대 너비와 높이를 설정하지만 위젯을 원하는 만큼 작게 허용. 즉, 느슨한 제약 조건은 최소 너비와 높이가 모두 0과 같음.  
```dart
BoxConstraints.loose(Size size) // BoxConstraints.loose - 느슨한 제약 조건
    : minWidth = 0.0,
      maxWidth = size.width,
      minHeight = 0.0,
      maxHeight = size.height;
```  
예 3을 다시 방문하면, Center를 사용하면 red Container가 더 작아지지만 화면보다는 크지는 않다고 알려줌. 물론 Center는 느슨한 제약 조건이다. 궁극적으로 Center의 중요한 목적은 부모(화면)에서 얻은 엄격한 제약 조건을 아이(Container)의 **느슨한 제약 조건**으로 변환하는 것.  

<br/>

## 특정 위젯에 대한 레이아웃 규칙 배우기  
일반적인 레이아웃 규칙을 아는 것이 필요하지만 충분하지 못함. 왜냐하면 **일반 규칙**은 **많은 자유도**를 가지기 때문임.  

* 코드에서 Column를 찾아 소스 코드로 이동합니다. 이렇게 하려면 Android Studio 또는 IntelliJ 안에서 command+B(macOS) 또는 control+B(Windows/Linux)를 사용합니다. basic.dart 파일로 이동 합니다. Column extends Flex 이후 Flex 소스 코드 로 이동합니다.(또한 basic.dart).
* createRenderObject()라는 메서드를 찾을 때까지 아래로 스크롤합니다. 보시다시피, 이 메서드는 RenderFlex. 이것은 Column에 대한 렌더 객체입니다. 이제 RenderFlex의 소스 코드로 이동하여 flex.dart 파일로 이동합니다.
* performLayout()라는 메서드를 찾을 때까지 아래로 스크롤합니다. Column에 대한 레이아웃을 수행하는 방법입니다.

![](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-final.png)  

Marcelo Glasberg의 기사

알아야 하는 고급 레이아웃 규칙 으로 게시했습니다.(https://medium.com/flutter-community/flutter-the-advanced-layout-rule-even-beginners-must-know-edc9516d1a2)
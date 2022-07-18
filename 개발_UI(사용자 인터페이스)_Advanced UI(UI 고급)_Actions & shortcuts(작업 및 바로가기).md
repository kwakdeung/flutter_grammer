# Using Actions and Shortcuts(작업 및 바로가기)  
이 페이지는 UI안에서 actions를 위해 물리적 키보드 이벤드들을 묶는 법을 설명한다. 예를 들면, application에서 키보드 단축키를 정의하려면 이 페이지가 적합하다.  

<br/>

## Overview(개요)  
GUI application을 무엇이든 하기 위해 actions을 한다: 유저들은 무언가를 하도록 application이 말하기를 원한다. Actions은 직접적인 실행으로 수행하는 것으로 종종 단순한 기능이다(값 셋팅, 저장된 파일과 같은). 그러나 더 큰 application은 더 복잡하다: action을 호출한 코드와 action을 위한 코드는 자체적으로 다른 장소들 안에서 필요하게 된다. Shortcuts(키 바인딩)는 그들을 호출하는 action에 대해 아무 것도 아닌 것을 아는 level에서 정의가 필요하다.  
이것이 Flutter's의 actions 와 shortcuts 시스템이 들어오는 것이다.  
Intent 클래스 인스턴스: 유저 intent  
Action은 간단한 콜백(예:CallbackAction)이거나 entire undo/redo architectures(전체 실행 취소/재실행 아키텍쳐)(예) 또는 다른 논리와 합쳐지는 더 복잡한 것일 수 있다.
![](https://docs.flutter.dev/assets/images/docs/using_shortcuts.png)  
Shortcuts: 키 또는 결합 키들을 누름으로써 activate되는 키 바인딩들이다.  

<br/>

## Why separate Actions from Intents?(Intents에서 Actions를 분리하는 이유)  
키 매핑 정의가 있는 위치(종종 high level에 있음)와 작업 정의가 있는 위치(종종 low level에 있음)사이에 문제를 분리하는 것이 유용하고 다음을 수행할 수 있는 것이 중요하기 때문이다. 단일 키 조합이 앱의 의도된 작업에 매핑되고 focus가 맞춰진 context에 대해 의도된 작업을 수행하는 작업에 자동으로 적응하도록 한다.  
예를 들어, Flutter에는 각 유형의 컨트롤을 해당 버전에 매핑하는 ActivateIntent 위젯이 있다.  
Intents는 여러 용도로 serve 할 수 있는 같은 action을 하기 위해 action을 구성한다.  
이것의 예는 DirectionalFocusIntent,초점을 이동하는 방향에서 DirectionalFocusAction 허용 하는 focus를 이동하는 방향을 취하여 향한다.  

<br/>

## Why not use callbacks?(콜백을 사용하지 않는 이유)
주 이유는 isEnabled를 이행함으로 주된 이유는 action을 구현하여 활성화할지 여부를 결정하는 것이 유용하기 때문이다. 또한 키 바인딩과 이러한 바인딩의 구현이 서로 다른 위치에 있으면 종종 도움이 된다.  
실제로 필요한 모든 것이 Actions과 Shortcuts의 complexity(또는 flexibility) 없이 콜백이면 이를 위해 이미 위젯을 사용할 수 있다.  
```dart
class CallbackShortcuts extends StatelessWidget {
    const CallbackShortcuts({
        super.key,
        required this.bindings,
        required this.child,
    });
    final Map<ShortcutActivator, VoidCallback> bindings;
    final Widget child;

    @override
    Widget build(BuildContext context) {
        return Focus(
            onKey: (node, event) {
                KeyEventResult result = KeyEventResult.ignored;
                // all key bindings that match, returns handled if any handle it.
                for (final ShortcutActivator activator in bindings.keys) {
                    if (activator.accepts(event, RawKeyBord.instance)) {
                        bindings[activator]!.call();
                        result = KeyEventResult.handled;
                    }
                }
                return result;
            },
            child: child,
        );
    }
}
```  
이것은 일부 앱에 필요한 전부이다.  

<br/>

## Shortcuts  
Shortcuts 위젯의 용도: 가장 일반적인 사용 사례는 actions을 바로 가기 키에 바인딩하는 것이다.  
```dart
@override
Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
                SelectAllIntent(),
        },
        child: Actions(
            dispatcher: LoggingActionDispatcher(),
            actions: <Type, Action<Intent>>{
                SelectAllIntent: SelectAllAction(model),
            },
            child: Builder(
                builder: (context) => TextButton(
                    child: const Text('SELECT ALL'),
                    onPressed: Action.handler<SelectAllIntent>(
                        context,
                        SelectAllIntent(),
                    ),
                ),
            ),
        ),
    );
}
```  
Shortcuts 위젯은 Intent 인스턴스에서 LogicalKeySet(또는 ShortcutActivator)을 매핑한다.  
Shortcuts 위젯은 Intent 인스턴스를 찾기위해 맵에서 키 누름을 보여준다. invoke() 메서드에 action's이 주어진다.  

## The ShortcutManager  
shortcut manager는 그들에게 받을 때 key events에서 통과된 shortcuts 위젯보다 수명이 더 긴 객체이다.  
키를 다루는 법 결정을 위한 logic 그리고 다른 shortcut 매핑을 찾는 tree를 걸어 올라가기 위한 logic, intents의 키 조합의 맵을 포함한다.  


ShortcutManager의 기본 동작이 대개 바람직하지만 Shortcuts 위젯은 ShortcutManager 기능을 사용자 정의하기 위해 하위 클래스로 만들 수 있는 것을 취한다.

예를 들어 Shortcuts 위젯이 처리한 각 키를 기록하려면 LoggingShortcutManager을 수행할 수 있다:  
```dart
class LoggingShortcutManager extends ShortcutManager {
    @override
    KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
        final KeyEventResult result = super.handleKeypress(context, event);
        if (result == KeyEventResult.handled) {
            print('Handled shortcut $event in $context');
        }
        return result;
    }
}
```  
현재, Shortcuts 위젯의 모든 시간에는 key event와 관련된 context를 prints out하는 shortcut를 다룬다.  

## Actions(작업)  
Actions은 application은 Intent와 함께 그것들을 불러옴으로써 수행할 수 있다는 것을 작동의 정의를 위해 허용한다.  
Actions은 가능 또는 불가능해질 수 있고, intent에 의해 구성을 허용하는 것의 argument를 불러오는 intent 요소를 받을 수도 있다.  

## Defining actions(작업 정의)  
제일 단순한 형태의 Actions은 invoke() 메서드와 Action	&#60;Intent>의 단지 하위클래스이다. 단순히 제공된 모델에서 기능을 포함한 단순한 action이 여기 있다.  
```dart
class SelectAllAction extends Action<SelectAllIntent> {
    SelectAllAction(this.model);

    final Model model;

    @override
    void invoke(covariant SelectAllIntent) => model.selectAll();
    // covariant(공변)에 대해(출처: https://www.continue.cool/thread/101491.html)
}
```
또는, 만약 새로운 클래스를 생성하는 것이 너무 귀찮아지는 것이 많다면 CallbackAction을 사용해라:  
```dart
CallbackAction(onInvoke: (intent) => model.selectAll());
```
action을 할 때, Actions 위젯을 사용한 application에 추가해라. Action에서 Intent 유형의 맵을 가져온다:
```dart
@override
Widget build(Buildcontext context) {
    return Actions(
        actions: <Type, Action<Intent>>{
            SelectAllIntent: SelectAllAction(model),
        }
        child: child,
    );
}
```  
Shortcuts 위젯은 **Focus** 위젯 context와 **Action**을 사용한다.  

<br/>

## Invoking Actions(작업 호출)
actions 시스템이 Invoking Actions에서 몇몇의 방법을 가진다. 지금까지 가장 일반적인 방법은 이전 섹션에서 curvered된 Shortcut 위젯의 사용을 통해서다. 그러나 actions 하위시스템을 질문하기 위함과 action을 호출하기 위한 다른 방법들도 있다.  

예를 들면, 사용할 수 있는 intent와 함께 연관된 action을 찾는 것:
```dart
Action<SelectAllIntent>? selectAll = Actions.maybeFind<SelectAllIntent>(context);
```
주어진 context에서 이용가능한 SelectAllIntent 타입과 연관된 Action을 리턴한다.  

action을 호출하는 것:
```dart
Object? result;
if (selectAll != null) {
    result = Actions.of(context).invokeAction(selectAll, SelectAllIntent());
}
```
다음을 사용하여 하나의 호출을 결합한다:
```dart
Object? result = Actions.maybeInvoke<SelectAllIntent>(context, SelectAllIntent());
```
때때로 버튼을 누르거나 다른 control의 결과로써 action 호출을 원한다.  

intent에 활성화된 actioned에 대한 매핑이 있는 경우 handler closure를 생성하고, 그렇지 않은 경우 null을 반환하는 함수로 이 action을 수행하여 context에 일치하는 활성화된 작업이 없으면 버튼이 비활성화되도록 한다:
```dart
@override
Widget build(BuildContext context) {
    return Actions(
        actions: <Type, Action<Intext>>{
            SelectAllIntent: SelectAllAction(model),
        },
        child: Builder(
            builder: (context) => TextButton(
                child: const Text('SELECT ALL'),
                onPressed: Actions.handler<SelectAllIntent>(
                    context,
                    SelectAllIntent(controller: controller),
                ),
            ),
        ),
    );
}
```
Actions isEnabled(Intent intent) true로 리턴될 때 위젯 action에 오직 호출하므로 action에서 dispatcher 호출을 고려해야 하는지 여부를 결정하는 것이다. action이 활성화되지 않은 경우 Action위젯은 위젯 계층에서 상위에 있는 활성화된 다른 action에 실행할 기회를 제공한다.

<br/>

## Action dispatchers  

대부분의 시간에는 action을 호출하고 해당 action을 수행하고 잊어버리기를 원한다. 그러나 때때로 실행된 action을 기록하고 싶을 수도 있다.  
**ActionDispatcher**: 유저 정의 dispatcher로 바꾸는 곳.  
```dart
class LoggingActionDispatcher extends ActionDispatcher {
    @override
    Object? invokeAction(
        covariant Action<Intent> action,
        covariant Intent intent, [
        BuildContext? context,    
    ]) {
        print('Action invoked: $action($intent) from $context');
        super.invokeAction(action, intent, context);

        return null;
    }
}
```
top-level Action 위젯을 통과할 때:  
```dart
@override
Widget build(BuildContext context) {
    return Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: <Type, Action<Intent>> {
            SelectAllIntent: SelectAllAction(model),
        },
        child: Builder(
            builder: (context) => TextButton(
                child: const Text('SELECT ALL'),
                onPressed: Actions.handler<SelectAllIntent>(
                    context,
                    SelectAllIntent(),
                ),
            ),
        ),
    );
}
```
모든 action은 실행함으로써 기록한다.  
```dart
flutter: Action invoked: SelectAllAction#906fc(SelectAllIntent#a98e3) from Builder(dependencies: _[ActionsMarker])
```  

<br/>

## Putting it together(함께 두다)  
Actions 와 Shortcuts의 조합은 파워풀하다: 위젯 level에서 특정한 action을 매핑하는 것을 일반 intent로 정의할 수 있다. 다음은 위에서 설명한 개념을 설명하는 간단한 앱이다.  
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// A text field that also has buttons to select all the text and copy the
// selected text to the clipboard.
class CopyableTextField extends StatefulWidget {
    const CopyableTextField({super.key, required this.title});

    final String title;

    @override
    State<CopyableTextField> createState() =>  _CopyableTextFieldState();
}

class _CopyableTextFieldState extends State<CopyableTextField> {
    late TextEditingController controller = TextEditingController();

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Actions(
            dispatcher: LoggingActionDispatcher(),
            actions: <Type, Action<Intent>>{
                ClearIntent: ClearAction(controller),
                CopyIntent: CopyAction(controller),
                SelectAllIntent: SelectAllAction(controller),
            },
            child: Builder(builder: (context) {
                return Scaffold(
                    body: Center(
                        child: Row(
                            children: <Widget>[
                                const Spacer(),
                                Expanded(
                                    child: TextField(controller: controller),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.copy),
                                    OnPressed: Actions.handler<CopyIntent>(context, const CopyIntent()),             
                                ),
                                IconButton(
                                    icon: const Icon(Icons.select_all),
                                    OnPressed: Actions.handler<SelectAllIntent>(context, const SelectAllIntent()),             
                                ),
                                const Spacer(),
                            ],
                        ),
                    ),
                );
            }),
        );
    }
}
// A ShortcutManager that logs all keys that it handles.
class LoggingShortcutManager extends ShortcutManager {
    @override
    KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
        final KeyEventResult result = super.handleKeypress(context, event);
        if (result == KeyEventResult.handled) {
            print('Handled shortcut $event in $context');
        }
        return result;
    }
}
// An ActionDispatcher that logs all the actions that it invokes.
class LoggingActionDispatcher extends ActionDispatcher {
    @override
    Object? invokeAction(
        covariant Action<Intext> action,
        covariant Intent intent, [
        BuildContext? context,    
    ]) {
        print('Action invoked: $action($intent) from $context');
        super.invokeAction(action, intent, context);

        return null;
    }
}
// An intent that is bound to ClearAction in order to clear its
// TextEditingController.
class ClearIntent extends Intent {
    const ClearIntent();
}
// An action that is bound to ClearIntent that clears its
// TextEditingController.
class ClearAction extends Action<ClearIntent> {
    ClearAction(this.controller);

    final TextEdtingController controller;

    @override
    Object? invoke(covariant ClearIntent intent) {
        controller.clear();

        return null;
    }
}

// An intent that is bound to CopyAction to copy from its
// TextEditingController.
class CopyIntent extends Intent {
    const CopyIntent();
}

// An action that is bound to CopyIntent that copies the text in its
// TextEditingController to the clipboard.
class CopyAction extends Action<CopyIntent> {
    CopyAction(this.controller);

    final TextEditingController controller;

    @override
    Object? invoke(covariant CopyIntent intent) {
        final String selectedString = controller.text.substring(
        controller.selection.baseOffset,
        controller.selection.extentOffset,
        );
        Clipboard.setData(ClipboardData(text: selectedString));

        return null;
    }
}

// An intent that is bound to SelectAllAction to select all the text in its
// controller.
class SelectAllIntent extends Intent {
    const SelectAllIntent();
}

// An action that is bound to SelectAllAction that selects all text in its
// TextEditingController.
class SelectAllAction extends Action<SelectAllIntent> {
    SelectAllAction(this.controller);

    final TextEditingController controller;

    @override
    Object? invoke(covariant SelectAllIntent intent) {
        controller.selection = controller.selection.copyWith(
        baseOffset: 0,
        extentOffset: controller.text.length,
        affinity: controller.selection.affinity,
        );

        return null;
    }
}

// The top level application class.

// Shortcuts defined here are in effect for the whole app,
// although different widgets may fulfill them differently.
class MyApp extends StatelessWidget {
    const MyApp({super.key});

    static const String title = 'Shortcuts and Actions Demo';

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: title,
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: Shortcuts(
                manager: LoggingShortcutManager(),
                shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(LogicalKeyboardKey.escape): const ClearIntent(),
                    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
                        const CopyIntent(),
                    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
                        const SelectAllIntent(),
                },
                child: const CopyableTextField(title: title),
            ),
        );
    }
}

void main() => runApp(const MyApp());
```

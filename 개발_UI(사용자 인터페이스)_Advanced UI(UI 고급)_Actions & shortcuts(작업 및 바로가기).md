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
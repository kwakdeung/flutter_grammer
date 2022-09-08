# Differentiate between ephemeral state and app state(임시 상태와 앱 상태 구분)  

이 문서는 앱 상태, 임시 상태, Flutter 앱에서 각각 관리할 수 있는 법을 소개한다.  

가장 넓은 의미에서 앱 상태는 앱이 실행될 때 메모리에 존재하는 모든 것이다.  
```
1. (텍스쳐와 같은) 일부 상태는 심지어 관리하지 못한다.  
2. 자체적으로 관리하는 상태는 2개의 개념 타입으로 분리될 수 있다  
: 임시 상태, 앱 상태  
```  

<br/>

## Ephemeral state(임시 상태)  
(UI 상태 또는 지역 상태라 불리는) 임시 상태는 싱글 위젯에 가까이 포함할 수 있는 상태이다.  

의도적으로 막연한 정의이다. 그래서 몇몇의 예들이 여기 있다:  

* [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html)에서의 현재 페이지
* 복잡한 애니메이션의 현재 진행 상황
* **BottomNavigationBar**에서의 현재 선택된 탭  

(상태 관리 기법: ScopedModel, Redux 등)을 사용할 필요가 없습니다. 필요한 것은 StatefulWidget이다.  
```dart
class MyHomepage extends StatefulWidget {
    const MyHomepage({super.key});

    @override
    State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
    // _index - 임시 상태
    // _index 변수는 MyHomepage 위젯 내에서만 변경
    int _index = 0; // _index 재시작해도 0으로 재설정
    

    @override
    Widget build(BuildContext context) {
        return BottomNavigationBar(
            currentIndex: _index,
            onTap: (newIndex) {
                setState(() {
                    _index = newIndex;
                });
            },
            // ... items ...
        );
    }
}
```  

<br/>

## App state(앱 상태)  
일시적이지 않고 앱의 많은 부분에서 공유하고 유저 세션 간에 유지하려는 상태(때로는 공유 상태)  

앱 상태의 예:  
* User 참조
* Login 인포
* 사회적 네트워킹 앱에서의 공지
* e-commerce 앱에서 쇼핑 카트
* 뉴스앱에서 기사들의 Read/unread state

<br/>

## There is no clear-cut rule(명확한 규칙이 없다)  
명백하게, 앱에서 상태의 모든 것을 관리하기 위해 **상태**와 **setState()**s를 사용할 수 있다. 사실은 Flutter 팀은 많이 단순한 앱 샘플들은 이 작업을 수행한다.(매번 제공되는 시작 앱 flutter create 포함) 다른 방향으로도 간다.  
특정 변수가 Ephemeral state(임시 상태)인지 Ephemeral state(앱 상태)인지 구별하는 명확하고 보편적인 규칙은 **없다**. 때로는 하나를 다른 것으로 리팩토링 해야한다.  

**diagram**  
![diagram](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/ephemeral-vs-app-state.png)  

모든 Flutter 앱에는 2가지 개념적 상태 유형:  
* 임시 상태는 State, setState()를 사용하여 구현한다.
* 종종 싱글 위젯이 지역적이다. 나머지는 앱 상태이다.
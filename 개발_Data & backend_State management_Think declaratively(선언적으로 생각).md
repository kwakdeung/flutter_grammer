# Start thinking declaratively(선언적으로 생각하기 시작하라)  

만약 imperative(명령형) framework(Android SDK 또는 iOS UIKit)으로부터 Flutter에 온다면, 새로운 관점에서 앱 development를 생각을 시작할 필요가 있다.  

Flutter는 declaratively(선언적)이다. 이 Flutter는 앱 에서 현재 state를 반영하는 UI를 build한다는 의미이다.  
![](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/ui-equals-function-of-state.png)  

시작 가이드 에서 UI 프로그래밍에 대한 declarative(선언적) 접근 방식에 대해 자세히 알아보자.

declarative(선언적) style의 UI 프로그래밍에는 많은 이점이 있습니다. 놀랍게도 UI의 모든 상태에 대해 하나의 code path만 있습니다. 주어진 state에 대해 UI가 어떻게 생겼는지 한 번만 설명하면 된다.

처음에는 이러한 프로그래밍 style이 imperative(명령형) style만큼 직관적이지 않은 것처럼 보일 수 있다. 이것이 이 섹션이 여기에 있는 이유이다. [get started guide - declarative 부분](https://docs.flutter.dev/get-started/flutter-for/declarative)을 읽어보자.
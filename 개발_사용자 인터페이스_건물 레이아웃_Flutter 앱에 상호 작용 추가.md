# Flutter 앱에 상호 작용 추가  

> 배울 내용
> * 탭에 응답하는 방법
> * 사용자 정의 위젯을 만드는 방법
> * 상태 비저장 위젯과 상태 저장 위젯의 차이점  

**user input(사용자 입력)에 반응**하도록 앱을 어떻게 수정합니까? 이 자습서에서는 비대화형 위젯만 포함하는 앱에 **대화형 기능을 추가**함. 특히 두 개의 상태 비저장 위젯을 관리하는 **사용자 정의 상태 저장 위젯을 만들어** 아이콘을 탭할 수 있도록 수정함.  

Layout Build 자습서 에서는 다음 스크린샷의 레이아웃을 만드는 방법을 보여주었습니다.  
![레이아웃 튜토리얼 앱](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes.jpg)   

앱 처음 실행시 별은 빨간색으로 고정되어 즐겨찾기에 추가되었음. 
색이 채워진 별 옆에 있는 숫자는 41명이 좋아했음을 나타냄. 
완료 후 별을 탭하면 즐겨찾기 상태가 제거되고 속이 비워진 별로 바뀌고 명수가 줄어듬.  
다시 클릭 시 채워진 별이 되어 명수가 추가됨.

![레이아웃 튜토리얼 앱](https://docs.flutter.dev/assets/images/docs/ui/favorited-not-favorited.png)  

별과 개수를 모두 포함하는 단일 사용자 지정 위젯을 만듬. 별표를 탭하면 두 위젯의 상태가 변경되므로 동일한 위젯에서 두 위젯을 모두 관리해야 함.  

2단계: Subclass StatefulWidget 에서 코드를 바로 터치할 수 있음.  

상태를 관리하는 다양한 방법을 시도하려면 상태 관리 설명으로 건너뛰기.

<br/>

## Stateful and stateless widgets(상태 저장 및 상태 비저장 위젯)  

Widget은 Stateful Widget 또는 Stateless Widget.  

Stateful Witget - 위젯 변경 가능, 동적
* 예) Checkbox, Radio, Slider, InkWell, Form, TextField  

Stateless Witget - 위젯 변경 불가능, 고정, 정적 
* 예) Icon, IconButton, Text

Widget의 State는 State 객체에 저장되어 위젯의 상태의 모양과 분리.  
setState() - widget의 state가 변경 시 state 객체는 setState() 호출하여 프레임워크에 widget을 다시 그리도록 지시

<br/>

## Creating a stateful widget(상태 저장 위젯 만들기)

//////////////
![]() 
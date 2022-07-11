# Adaptive(적응형) 및 Responsive(반응형) 앱 만들기  

>Adaptive(적응형) 및 Responsive(반응형) 기본 개념 <br/>  
적응형 디자인: **다양한 장치**에 맞게 설계된 **여러 레이아웃**을 제공  
반응형 디자인: 사용자에게 **빠르고 원활한 탐색** 기능을 제공  
(출처: https://designlog.org/2512903)

Flutter의 주요 목표 중 하나: 모든 플랫폼에서 멋지게 보이고 느껴지는 단일 코드베이스에서 앱을 개발할 수 있는 프레임워크를 만드는 것  
즉, 시계에서 두 개의 화면이 있는 폴더블 전화기, 고화질 모니터에 이르기까지 다양한 크기의 화면에 앱이 표시될 수 있습니다.  
이 시나리오의 개념을 설명하는 두 가지 용어는 **적응형 및 반응형**입니다.  

<br/>

## Adaptive(적응형) 앱과 Responsive(반응형) 앱의 차이점  

적응형과 반응형은 앱의 별도 차원입니다.  

* Adaptive(적응형)  
모바일 및 데스크탑과 같은 다양한 장치 유형에서 실행되도록 앱을 조정하려면 마우스 및 키보드 입력과 터치 입력을 처리해야 합니다. 또한 앱의 시각적 밀도, 구성 요소 선택 작동 방식(예: 계단식 메뉴 대 하단 시트), 플랫폼별 기능(예: 최상위 창) 사용 등에 대해 서로 다른 기대치가 있음을 의미합니다.
 

* Responsive(반응형)
일반적으로 반응형 앱은 **사용 가능한 화면 크기에 맞게** 레이아웃을 조정했습니다. 예를 들어 사용자가 창의 크기를 조정하거나 장치의 방향을 변경하는 경우 UI를 다시 배치하는 경우가 많습니다. 이는 시계, 전화, 태블릿, 랩톱 또는 데스크톱 컴퓨터에 이르기까지 다양한 장치에서 동일한 앱을 실행할 수 있는 경우에 특히 필요합니다  

<br/>

## Adaptive(적응형) Flutter 앱 만들기  

gskinner팀이 작성한 적응형 앱 빌드 로 적응형 Flutter 앱을 만드는 방법에 대해 자세히 알아보세요.  

<br/>

### Adaptive(적응형) 레이아웃  

[![Adaptive Layouts (The Boring Flutter Development Show, Ep. 45)](http://img.youtube.com/vi/n6Awpg1MO6M/0.jpg)](https://youtu.be/n6Awpg1MO6M)  

### Adaptive(적응형) 레이아웃, 2부  

[![Adaptive Layouts part 2 (The Boring Flutter Development Show, Ep. 46)](http://img.youtube.com/vi/eikOZzfc0l4/0.jpg)](https://youtu.be/eikOZzfc0l4)  

### Adaptive(적응형) 앱의 훌륭한 예를 보려면 gskinner와 Flutter 팀과 협력하여 만든 스크랩북 앱인 Flutter Folio를 확인하세요.  

[![Flutter Folio walkthrough](http://img.youtube.com/vi/yytBENOnF0w/0.jpg)](https://youtu.be/yytBENOnF0w)  

<br/>

## Responsive(반응형) Flutter 앱 만들기


기기의 화면 크기와 방향에 **자동으로 적응**하는 앱을 만들 수 있습니다.  

Responsive(반응형) 디자인 앱 생성 2가지 기본 접근 방식  

1. **LayoutBuilder 클래스를 사용**  
builder 속성에서 BoxConstraints 객체를 얻습니다. 제약 조건의 속성을 검토하여 표시할 항목을 결정합니다. 예를 들어, 너의 maxWidth이 width breakpoint(너비 중단점)보다 큰 경우 왼쪽에 목록이 있는 Row가 있는 Scaffold 객체를 반환합니다. 더 좁으면 해당 목록이 포함된 서랍이 있는 Scaffold 객체를 반환합니다. 기기의 높이, 종횡비 또는 기타 속성에 따라 디스플레이를 조정할 수도 있습니다. 제약 조건이 변경되면(예: 사용자가 전화를 회전하거나 앱을 Nougat의 타일 UI에 배치) 빌드 기능이 실행됩니다.  

2. **MediaQuery.of() 빌드 함수에서 메서드 사용**
이것은 현재 앱의 크기, 방향 등을 제공합니다. 이것은 특정 위젯의 크기보다는 전체 컨텍스트를 기반으로 결정을 내리려는 경우에 더 유용합니다. 다시 말하지만, 이것을 사용하면 사용자가 어떻게든 앱의 크기를 변경하면 빌드 함수가 자동으로 실행됩니다.  


반응형 UI를 만들기 위한 기타 유용한 위젯 및 클래스:  
* AspectRatio
* CustomSingleChildLayout
* CustomMultiChildLayout
* FittedBox
* FractionallySizedBox
* LayoutBuilder
* MediaQuery
* MediaQueryData
* OrientationBuilder  

<br/>

## 기타 리소스
* Deven Joshi 의 Flutter에서 다중 화면 크기 및 방향 개발
* Raouf Rahiche 의 Flutter로 반응형 UI 빌드
* Priyanka Tyagi 의 크로스 플랫폼 Flutter 랜딩 페이지 반응형 만들기
* 다른 화면 크기에 따라 Flutter 앱을 반응형으로 만드는 방법은 무엇입니까?, StackOverflow에 대한 질문

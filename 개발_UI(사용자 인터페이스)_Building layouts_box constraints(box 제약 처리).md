# Dealing with box constraints(상자 제약 처리)  

> **참고:** framework가 box constraints과 관련된 문제를 감지하면 이 페이지로 이동할 수 있다.  

> **참고:** Flutter에서 constraints, size 조정 및 location 지정이 작동하는 방식이 혼란스럽다면 제약 조건 이해를 참조하기.  

Flutter에서 위젯은 기본 RenderBox 객체에 의해 Rendering됨. RenderBox는 Parent에 의해 constraints이 주어지며 이러한 constraints 내에서 크기가 지정된다.  
constraints(제약 조건) - min 및 max width와 height로 구성. size는 특정 width와 height로 구성  

제약 조건의 일반적 처리 방식 3가지  
* 최대한 크게 하려고 하는 사람들. 예) Center 및 ListView 에서 사용하는 상자임.
* children과 같은 size가 되려고 하는 사람들. 예) Transform 및 Opacity 에서 사용하는 상자임.
* 특정 size가 되려고 하는 사람들. 예) Image 및 Text 에서 사용하는 상자임.  

예를 들어 Container는 일부 위젯은 constructor arguments(생성자 인수)에 따라 유형이 다르다. Container의 경우 기본적으로 가능한 한 크게 하려고 하지만 , 예를 들어 width를 지정하면 이를 존중하고 특정 크기가 되도록 시도한다.  

예를 들어 Row 및 Column(flex boxes)와 같은 다른 것들은 아래 "Flex" 섹션에 설명된 대로 **주어진 constraints(제약 조건)에 따라 다른다.**

The constraints(제약 조건)은 때때로 "tight"하다. 즉, render box(렌더 상자)가 크기를 결정할 수 있는 여지가 없다.
즉, 응용 프로그램의 Render 트리 루트에서 서로 내부에 많은 box를 중첩하면 이러한 **엄격한 constraints**으로 인해 모두 서로 정확히 맞습니다. 

일부 상자는 **constraints**을 **loose** 합니다. 즉, 최대값은 유지되지만 최소값은 제거됩니다. 예를 들어, Center.

<br/>

# Unbounded constraints(무제한 제약)  
특정 상황에서 상자에 주어진 **constraints**은 **Unbounded(무제한) 또는 infinite(무한)**이다. 이는 maxWidth(최대 너비) 또는 maxHeight(최대 높이)가 설정되어 있다.  

렌더 상자가 일반적으로 제한되지 않은 constraints  
:flex box(Row, column) 및 **scroll 가능 영역**(ListView, 기타 ScrollView child class) 내  

특히, ListView 교차 방향에서 사용 가능한 공간에 맞게 확장 시도.  
ListView Row scroll 내부에 Column scroll을 중첩하는 경우, 내부 scroll ListView는 가능한 한 넓게 시도한다.  
외부 scroll은 해당 방향으로 scoll 할 수 있기 때문에 무한히 넓다.  

<br/>

# Flex  
Flex boxes(Row, Column)은 지정된 방향으로 bounded constraints(제한된 제약 조건)이 있는지 또는 Unbounded constraints(무제한 제약 조건)에 있는지 따라 다르게 동작한다.  

bounded constraints(제한된 제약 조건)에서는 해당 방향으로 최대한 크게한다
Unbounded constraints(무제한 제약 조건)에서는 children을 그 방향으로 크게 하려고함. 이 경우 flex children에 0 이외의 값을 설정할 수 없다.  
(Expanded flex 상자가 다른 flex 상자 또는 scroll 가능한 내부에 있을 때 사용 불가능), 예외 메시지 표현된다.
# List of state management approaches(상태 관리 접근 방식 목록)  

State management는 복잡한 주제이다.  

많은 following links에 있는 것을 배워라. Flutter community에 기여되고 있다.  

<br/>

## General overview(일반 개요)  

접근법을 선택하기 전에 review하는 것들  

* [Introduction to state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
* [Pragmatic State Management in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I)
* [Flutter Architecture Samples](https://fluttersamples.com/)  

<br/>

## Provider  

추천된 접근법  
* [Simple app state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)
* [Provider package](https://pub.dev/packages/provider)
* [You might not need Redux: The Flutter edition](https://proandroiddev.com/you-might-not-need-redux-the-flutter-edition-9c11eba006d7), Ryan Edge에 의해
* [Making sense of all those Flutter Providers](https://medium.com/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd)  

<br/>

## Riverpod(리버포드)  

다른 좋은 선택인 Riverpod는 Provider하는 것과 유사하며, 컴파일을 안전하게 테스트를 하는 것이다. Riverpod은 Flutter SDK에서 dependency 하지 않는다.  
* [Riverpod](https://riverpod.dev/) 홈페이지
* [Getting started with Riverpod](https://riverpod.dev/docs/getting_started/)  

<br/>

## setState  
위젯별 ephemeral state에 사용할 낮은 레벨의 접근법  
* [Adding interactivity to your Flutter app](https://docs.flutter.dev/development/ui/interactive), a Flutter tutorial
* [Basic state management in Google Flutter](https://medium.com/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d), by Agung Surya

<br/>

## InheritedWidget & InheritedModel  
낮은 레벨의 접근법은 ancestors과 widget tree안에서의 children 사이에 communicate에 사용되곤 한다. **provider**이다. 그리고 많은 다른 접근법을 hood 아래에서 사용해라.  

InheritedWidget 사용법:

[![How to manage application states using inherited widgets | Workshop)](http://img.youtube.com/vi/LFcGPS6cGrY/0.jpg)](https://youtu.be/LFcGPS6cGrY)  

유용한 다른 docs:
* [InheritedWidget docs](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
* [Managing Flutter Application State With InheritedWidgets](https://medium.com/flutter/managing-flutter-application-state-with-inheritedwidgets-1140452befe1), by Hans Muller
* [Inheriting Widgets](https://medium.com/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1), by Mehmet Fidanboylu
* [Using Flutter Inherited Widgets Effectively](https://ericwindmill.com/articles/inherited_widget/), by Eric Windmill
* [Widget - State - Context - InheritedWidget](https://www.didierboelens.com/2018/06/widget-state-context-inheritedwidget/), by Didier Bolelens

<br/>

## Redux

state container 접근법은 많은 web developers와 유사.  
* [Animation Management with Redux and Flutter](https://www.youtube.com/watch?v=9ZkLtr0Fbgk), a video from DartConf 2018 [Accompanying article on Medium](https://medium.com/flutter/animation-management-with-flutter-and-flux-redux-94729e6585fa)
* [Flutter Redux package](https://pub.dev/packages/flutter_redux)
* [Redux Saga Middleware Dart and Flutter](https://pub.dev/packages/redux_saga), by Bilal Uslu
* [Introduction to Redux in Flutter](https://blog.novoda.com/introduction-to-redux-in-flutter/), by Xavi Rigau
* [Flutter + Redux—How to make a shopping list app](https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65), by Paulina Szklarska on Hackernoon
* [Building a TODO application (CRUD) in Flutter with Redux—Part 1](https://www.youtube.com/watch?v=Wj216eSBBWs), a video by Tensor Programming
* [Flutter Redux Thunk, an example](https://medium.com/codechai/flutter-redux-thunk-27c2f2b80a3b), by Jack Wong
* [Building a (large) Flutter app with Redux](https://hillel.dev/2018/06/01/building-a-large-flutter-app-with-redux/), by Hillel Coren
* [Fish-Redux–An assembled flutter application framework based on Redux](https://github.com/alibaba/fish-redux/), by Alibaba
* [Async Redux–Redux without boilerplate. Allows for both sync and async reducers](https://pub.dev/packages/async_redux), by Marcelo Glasberg
* [Flutter meets Redux: The Redux way of managing Flutter applications state](https://thisisamir98.medium.com/flutter-meets-redux-the-redux-way-of-managing-flutter-applications-state-f60ef693b509), by Amir Ghezelbash
* [Redux and epics for better-organized code in Flutter apps](https://medium.com/upday-devs/reduce-duplication-achieve-flexibility-means-success-for-the-flutter-app-e5e432839e61), by Nihad Delic
* [Flutter_Redux_Gen - VS Code Plugin to generate boiler plate code](https://marketplace.visualstudio.com/items?itemName=BalaDhruv.flutter-redux-gen), by Balamurugan Muthusamy (BalaDhruv)

<br/>

## Fish-Redux  
Fish Redux는 Redux state management 기초로 된 flutter application framework가 모여졌다.  medium과 large application의 building에 알맞는다.  
* [Fish-Redux-Library](https://pub.dev/packages/fish_redux) package, by Alibaba
* [Fish-Redux-Source](https://github.com/alibaba/fish-redux), project code
* [Flutter-Movie](https://github.com/o1298098/Flutter-Movie), A non-trivial example demonstrating how to use Fish Redux, with more than 30 screens, graphql, payment api, and media player.

<br/>

## BLoC / Rx  
stream/observable based patterns의 가족  
* Architect your Flutter project using BLoC pattern, by Sagar Suri
* BloC Library, by Felix Angelov
* Reactive Programming - Streams - BLoC - Practical Use Cases, by Didier Boelens

<br/>

## GetIt
state management 접근법 토대로 된 service locator는 **BuildContext**가 필요하지 않는다.  
* [GetIt package](https://pub.dev/packages/get_it), the service locator. It can also be used together with BloCs.
* [GetIt Mixin package](https://pub.dev/packages/get_it_mixin), a mixin that completes GetIt to a full state management solution.
* [GetIt Hooks package](https://pub.dev/packages/get_it_hooks), same as the mixin in case you already use flutter_hooks.
* [Flutter state management for minimalists](https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1), by Suragch

<br/>

## MobX  
observables와 reactions 토대로 된 인기있는 library  
* [MobX.dart, Hassle free state-management for your Dart and Flutter apps](https://github.com/mobxjs/mobx.dart)
* [Getting started with MobX.dart](https://mobx.netlify.app/getting-started/)
* [Flutter: State Management with Mobx](https://www.youtube.com/watch?v=p-MUBLOEkCs), a video by Paul Halliday

<br/>

## Flutter Commands  

Reactive state management는 Command Pattern과 **ValueNotifiers**를 토대로 사용해라. [GetIt](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options#getit)과 함께 사용하는 것이 가장 좋지만 **Provider** 또는 다른 locators와 함께 사용할 수도 있다.  
* [Flutter Command package](https://pub.dev/packages/flutter_command)
* [RxCommand package](https://pub.dev/packages/rx_command), **Stream** based implementation.

<br/>

## Binder  
core에서 **InheritedWidget** 사용한 state management package.  
이 package는 concerns(관심사)의 분리를 증진한다.  
* [Binder package](https://pub.dev/packages/binder)
* [Binder examples](https://github.com/letsar/binder/tree/main/examples)
* [Binder snippets](https://marketplace.visualstudio.com/items?itemName=romain-rastel.flutter-binder-snippets), vscode snippets to be even more productive with Binder

<br/>

## GetX  
단순화된 reactive state management 해결책.
* [GetX package](https://pub.dev/packages/get)
* [Complete GetX State Management](https://www.youtube.com/watch?v=CNpXbeI_slw), a video by Tadas Petra
* [GetX Flutter Firebase Auth Example](https://jeffmcmorris.medium.com/getx-flutter-firebase-auth-example-b383c1dd1de2), by Jeff McMorris

<br/>

## states_rebuilder  
dependency injection(주입) 해결책과 integrated(통합) router와 함께 state management를 결합한 접근법  
* [States Rebuilder](https://github.com/GIfatahTH/states_rebuilder) project code
* [States Rebuilder documentation](https://github.com/GIfatahTH/states_rebuilder/wiki)

<br/>

## Triple Pattern (Segmented State Pattern)  
Triple은 Streams 또는 ValueNotifier을 사용한 state management을 위한 패턴이다.  
mechanism stream은 Segmented State pattern 토대로 3개의 값을 항상 사용해라  
: Error, Loading, State  
* [Triple documentation](https://triple.flutterando.com.br/)
* [Flutter Triple package](https://pub.dev/packages/flutter_triple)
* [Triple Pattern: A new pattern for state management in Flutter](https://blog.flutterando.com.br/triple-pattern-um-novo-padr%C3%A3o-para-ger%C3%AAncia-de-estado-no-flutter-2e693a0f4c3e) (blog post written in Portuguese but can be auto-translated)
* [VIDEO: Flutter Triple Pattern by Kevlin Ossada](https://www.youtube.com/watch?v=dXc3tR15AoA) (recorded in English)
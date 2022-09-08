# null safety 코드랩

다트들의 null-safe 타입 시스템에 대해 가르친다.  

<br/>

## Nullable and non-nullable types  

### Exercise: Non-nullable types
```dart
void main() {
  int a;
  a = null;
  print('a is $a.');
}
```  

### Exercise: Nullable types  
```dart
void main() {
  int a;
  a = null;
  print('a is $a.');
}
```  

### Exercise: Nullable type parameters for generics  
```dart
void main() {
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String> aNullableListOfStrings;
  List<String> aListOfNullableStrings = ['one', null, 'three'];

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.');
  print('aListOfNullableStrings is $aListOfNullableStrings.');
}
```  

<br/>

## The null assertion operator (!)  

### Exercise: Null assertion  
```dart
int? couldReturnNullButDoesnt() => -3;

void main() {
  int? couldBeNullButIsnt = 1;
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt;
  int b = listThatCouldHoldNulls.first; // first item in the list
  int c = couldReturnNullButDoesnt().abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}
```  

<br/>

## Null-aware operators  

### Exercise: Conditional property access  

```dart
// The following calls the 'action' method only if nullableObject is not null  
nullableObject?.action();  
```  

```dart
int? stringLength(String? nullableString) {
  return nullableString.length;
}
```  

### Exercise: Null-coalescing operators  
```dart
// Both of the following print out 'alternate' if nullableString is null
print(nullableString ?? 'alternate');
print(nullableString != null ? nullableString : 'alternate');
```  

```dart
// Both of the following set nullableString to 'alternate' if it is null
nullableString ??= 'alternate';
nullableString = nullableString != null ? nullableString : 'alternate';
```

```dart
abstract class Store {
  int? storedNullableValue;

  /// If [storedNullableValue] is currently `null`,
  /// set it to the result of [calculateValue] 
  /// or `0` if [calculateValue] returns `null`.
  void updateStoredValue() {
    TODO('Implement following documentation comment');
  }

  /// Calculates a value to be used,
  /// potentially `null`.
  int? calculateValue();
}
```  

<br/>

## Type promotion  

### Exercise: Definite assignment  

```dart
void main() {
  String text;

  //if (DateTime.now().hour < 12) {
  //  text = "It's morning! Let's make aloo paratha!";
  //} else {
  //  text = "It's afternoon! Let's make biryani!";
  //}

  print(text);
  print(text.length);
}
```  

### Exercise: Null checking
```dart
int getLength(String? str) {
  // Add null check here

  return str.length;
}

void main() {
  print(getLength('This is a string!'));
}
```

### Exercise: Promotion with exceptions  
```dart  
int getLength(String? str) {
  // Try throwing an exception here if `str` is null.

  return str.length;
}

void main() {
  print(getLength(null));
}
```  

<br/>

## The late keyword   
### Exercise: Using late
```dart  
class Meal {
  String _description;

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

void main() {
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
}
```  
### Exercise: Late circular references  
```dart 
class Team {
  final Coach coach;
}

class Coach {
  final Team team;
}

void main() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}
```  

### Exercise: Late and lazy  
```dart 
int _computeValue() {
  print('In _computeValue...');
  return 3;
}

class CachedValueProvider {
  final _cache = _computeValue();
  int get value => _cache;
}

void main() {
  print('Calling constructor...');
  var provider = CachedValueProvider();
  print('Getting value...');
  print('The value is ${provider.value}!');
}
```
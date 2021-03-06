# assets and images 추가  

Flutter 앱은 코드와 assets을 포함 할 수 있다. assets는 패키지와 분산시킨 파일이다. 그리고 런타임을 접근한다. assets의 공통 타입은 static data(ex.JSON files)과 구성 파일, icon, 그리고 이미지들(JPEG, WebP, GIF, animated WebP/GIF, PNG, BMP, and WBMP)을 포함한다.  

## assets 열거  

Flutter는 너의 프로젝트의 루트를 위치시키기 위해 pubspec.yaml 파일을 사용한다. 필요로 한 앱의 assets을 판별한다.  

```dart
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png
```
directory 아래에 모든 assets은 포함하려면 디렉토리 이름 끝에 **/** 를 지정하시오
```dart
flutter:
  assets:
    - directory/
    - directory/subdirectory/
```  
>**참고:** 하위 디렉토리 내에 동일한 이름을 가진 파일이 없는 한 디렉토리에 직접 위치한 파일만 포함된다. 하위 디렉터리에 있는 파일을 추가하려면 디렉터리 별로 항목을 만든다.  

<br/>

## Asset bundling(묶음)
flutter 섹션의 하위 섹션인 assets는 앱에 포함되어야 할 파일을 지정한다. pubspec.yaml은 상대적으로 각 asset 파일이 있는 명확한 경로(파일 기준)로 판별된다.  

빌드하는 동안, Flutter는 앱이 런타임에 읽는 Asset bundle이라는 특별한 공문에 assets을 배치한다.

<br/>

## Asset variants(변형)  
build 과정은 asset variants(변형)의사를 지원한다: 다른 컨텍스트에서 표시되는 asset의 다른 버전이다.  
asset의 경로가 pubspec.yaml의 부문의 asset이 지정되면 build 프로세스는 가까운 하위 디렉토리에서 동일한 이름을 가진 파일을 찾는다. 그러한 파일은 특정한 asset과 함께 asset 번들이 포함된다.  

예를 들면, 디렉토리:
```dart
.../pubspec.yaml
.../graphics/my_icon.png
.../graphics/background.png
.../graphics/dark/background.png
...etc.
```

그리고 너의 pubspec.yaml 파일은 다음이 포함된다.  
```dart
flutter:
    assets:
        - graphics/background.png
```  
graphics/background.png와 graphics/dark/background.png 둘 다 너의 asset 번들에 포함된다. 전자는 main asset, 후자는 variant가 간주된다.  

반면에 그래픽 디렉토리:  
```dart
flutter:
    assets:
        - graphics/
```  
이 때는 graphics/my_icon.png, graphics/background.png, graphics/dark/background.png 파일들이 포함된다.  

## Loading(로딩중인) assets  

너의 앱은 sAssetBundle 객체를 통해서 assets에 허용 할 수 있다.  
2개의 asset 번들의 메인 메서드는 너의 a string/text asset 또는 an image/binary asset (load())out of the bundle, given a logical key 로드를 허용한다.  
logical key는 build 타임 때 pubspec.yaml 안에 특정한 asset 경로를 찾는다.  

### Loading text assets  
각각의 flutter 앱은 main asset bundle에서 rootBundle 객체를 쉬운 허용을 해준다. 그것은 package:flutter/services.dart.에서 rootBundle global(전역) static을 사용이 load assets이 가능하다.  

```dart
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
```

## Loading images  
이미지 로딩중에, 위젯들의 build() 메서드에서 AssetImage 클래스는 사용한다.  
```dart
return const Image(image: AssetImage('graphics/background.png));
```
기본 asset 번들을 사용하는 모든 항목은 이미지를 로드할 때 해상도 인식을 상속한다.  
>**참고:** 디바이스 픽셀 비율이 Material 또는 CupertinoApp 중 하나는 MediaQueryData.size에 의존한다. 

### Declaring resolution-aware image assets(해상도 인식 이미지 asset 선언)  
AssetImage는 현재 디바이스 pixel ratio에서 가장 가까이 매치된 논리적으로 요청된 asset 매핑 사용법을 이해한다.  
일하기 위해 매핑을 하기 위해서, asset은 특히 디렉토리 구조에 따라서 배열되어야 한다.
```dart
.../image.png
.../Mx/image.png
.../Nx/image.png
...etc.
```  
M과 N은 내부에 포함된 이미지의 명목상 해결책에 반응하는 숫자 판별자이다.  
다시 말하면, 그들은 의도된 이미지의 특정한 디바이스 pixel ratio이다.  
main asset은 1.0의 해결책에 해당되게 가장되었다.  
예를 들어, my_icon.png 이미지를 위해 asset 레이아웃을 고려하라.
```dart
.../my_icon.png
.../2.0x/my_icon.png
.../3.0x/my_icon.png
```
디바이스 픽셀 비율이 1.8x -> .../2.0x/my_icon.png 선택  
디바이스 픽셀 비율이 2.7x -> .../3.0x/my_icon.png 선택  

pubspec.yaml의 asset 부문에 있는 각 항목은 main asset 입장을 제외하고 실제 파일과 **일치**해야 합니다.  
항목은 여전히 pubspec.yaml의 manifest안에서 포함되어야 합니다.  

<br/>

## Asset images in package dependencies(종속)  

**package dependency**로부터 **이미지를 로드** 하는 것, 그 package argument(논쟁)은 **AssetImage**에 틀림없이 제공되어야 한다. 
```dart
.../pubspec.yaml
.../icons/heart.png
.../icons/1.5x/heart.png
.../icons/2.0x/heart.png
...etc.
```
이미지를 로드 하는 것, use:  
```dart
return const AssetImage('icons/heart.png', package: 'my_icons');
```  
Assets는 위와 같이 자체적으로 package argument 사용하여 가져와야 하는 package에 의해 사용되었다.  

### Bundling of package assets  
만약 훌륭한 asset이 package의 pubspec.yaml 파일 안에서 명확하다면, 그것은 application과 함께 자동적으로 번들되었다. 부분적으로, assets은 자체적으로 pubspec.yaml에서 틀림없이 명확하게 package로 사용되었다.  
package는 지정되지 않은 asset을 폴더에 포함하도록 선택할 수 있다.  
```dart
.../lib/backgrounds/background1.png
.../lib/backgrounds/background2.png
.../lib/backgrounds/background3.png
```  
첫번째 image를 포함하는 것은 application의 pubspec.yaml은 assets 부문 안에서 명확해야 한다.  
```dart
flutter:
  assets:
    - packages/fancy_backgrounds/backgrounds/background1.png
```  
lib/은 함축된다. 그래서 그것은 asset path에 포함되지 않는다.  
만약 너가 package를 developing 하고 싶다면, package 내부에서 asset을 로드 하려면 package의 ‘pubspec.yaml’ 지정해라:  
```dart
flutter:
  assets:
    - assets/images/
```
너의 package 내부의 이미지를 로드 하는 것, use:  
```dart
return const AssetImage('packages/fancy_backgrouds/backgrounds/background1.png');
```  

<br/>

## Sharing assets with the underlying platform(기본적인 플랫폼과 함께 assets를 공유하는 것)  

### Loading Flutter assets in Android(안드로이드 버전)  

Android의 assets은 AssetManager API를 통해 이용 가능하다.  

예를 들면, 너는 pubspec.yaml 안에 명확하게 지정하라.  
```dart
flutter:
  assets:
    - icons/heart.png
```  
이것은 너의 Flutter 앱에 다음 구조를 반영한다.  
```dart
.../pubspec.yaml
.../icons/heart.png
...etc.
```  
너의 **Java plugin code**로부터 **icons/heart.png을 허용**하는 것:  
```dart
AssetManager assetManager = registrar.context().getAssets();
String key = registrar.lookupKeyForAsset("icons/heart.png");
AssetFileDescriptor fd = assetManager.openFd(key);
```  

### Loading Flutter assets in iOS(iOS 버전)  
iOS의 assets은 mainBundle을 통해 이용 가능하다.  

너의 **Objective-C(C언어) plugin code**로부터 **icons/heart.png 허용** 하는 것:  
```dart
NSString* key = [registrar lookupKeyForAsset:@"icons/heart.png"]
NSString* path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
```  

**Objective-C(C언어):**
```dart
[UIImage flutterImageWithName:@"icons/heart.png"];
```  
**Swift:**
```dart
UIImage.flutterImageNamed("icons/heart.png")
```  
### Loading iOS images in Flutter  
pub.dev의 **ios_platform_images** plugin을 사용하라  

<br/>

## assets 플랫폼  

### Updating the app icon  
Flutter 애플리케이션의 실행 아이콘 업데이트는 기본 Android 또는 iOS 애플리케이션의 실행 아이콘을 업데이트하는 것과 같은 방식으로 작동한다.  
![](https://docs.flutter.dev/assets/images/docs/assets-and-images/icon.png)

### Android
Flutter project's 루트 디렉토리에서 .../android/app/src/main/res.를 탐색하라  
![](https://docs.flutter.dev/assets/images/docs/assets-and-images/android-icon-path.png) 
>**참고:** 만약 너가 .png 파일의 이름을 변경한다면, 틀림없이 AndroidManifest.xml’s <application> tag’s android:icon 속성에서도 이름을 업데이트를 해야한다.   
<br/>

### iOS
Flutter project's 루트 디렉토리에서 .../ios/Runner.를 탐색하라.  
Assets.xcassets/AppIcon.appiconset 디렉토리는 이미 포함된 이미지이다.  
![](https://docs.flutter.dev/assets/images/docs/assets-and-images/ios-icon-path.png)  

<br/>

## Updating the launch screen(실행 화면을 업데이트 하는 것)  
![](https://docs.flutter.dev/assets/images/docs/assets-and-images/launch-screen.png)  
Flutter는 프레임워크 로딩을 하는 동안 transitional launch 스크린들을 그리기 위해 native platform mechanisms 또한 사용한다.  

### Android  
.../android/app/src/main에 splash screen을 추가하라.  

### iOS
 .../ios/Runner. 이미지의 center에 splash screen을 추가하라.  
 다른 파일 이름을 사용하는 경우 동일한 디렉토리에서 LaunchImage.pngLaunchImage@2x.pngLaunchImage@3x.pngContents.json 파일의 이름을 개선해라.  
 ![](https://docs.flutter.dev/assets/images/docs/assets-and-images/ios-launchscreen-xcode.png)  

 자세히보기: [splash screen 추가](https://docs.flutter.dev/development/ui/advanced/splash-screen)
  
# Adding a splash screen to your mobile app(모바일 앱에 splash screen 추가)  
![](https://docs.flutter.dev/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png)  

Splash screens는 mobile app load하는 동안 단순한 initial experience 제공한다. 그들은 앱 엔진이 load할 때와 앱 초기일 때의 허용하는 시간동안 application을 위한 stage를 set한다.  

## iOS launch screen
Apple App Store 제출한 모든 앱은 app’s launch screen을 제공하기 위해 반드시 Xcode storyboard를 사용해야 한다.  

default Flutter 템플릿은 자신의 assets와 함께 알맞게 봄으로써 customized될 수 있다. 지정된 **LaunchScreen.storyboard**는 Xcode storyboard를 포함한다. default일 때, storyboard는 blank image를 보여주지만 변할 수 있다. app directory의 root로부터 **open ios/Runner.xcworkspace** 유형에 의해 Flutter app’s Xcode project를 열기 위해 하는 일이다. 그때 LaunchImage image set에서 Project Navigator와 바람직한 images에서 떨어뜨림으로부터 **Runner/Assets.xcassets**를 선택해라.  

[Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/launching#launch-screens/)-시작 화면에 대한 지침 부분도 제공

## Android launch screen
안드로이드에서는 control 할 수 있는 화면이 2개로 분리된다: Android app initializes(초기화),  Flutter experience initializes(초기화) 하는 동안 보여주는 splash screen.  

### Initializing the app  

모든 Android 앱은 작동 시스템이 앱의 process를 set up 하는 동안 initialization 시간이 필요하다. Android는 앱이 initializing 하는 동안 **Drawable**를 보여주는 launch screen 개념을 제공한다.  
theme를 정의 할 수 있는 windowBackground는 launch screen일 때 보여주는 Drawable에서 set하는 styles.xml를 editing함으로써 customize를 할 수 있다.  
```dart
<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowBackground">@drawable/launch_background</item>
</style>
```  
게다가 style.xml은 launch screen 사라진 후에 **FlutterActivity**에 적용되어 있는 normal theme를 정의한다.  
그러므로,  normal theme를 Flutter UI의 primary background color를 단순하게 보여주는 solid background color를 사용하는 것을 권장한다.  
```dart
<style name="NormalTheme" parent="@android:style/Theme.Black.NoTitieBar">
    <item name="android:windowBackground">@drawable/normal_background</item>
</style>
```  

### Set up the FlutterActivity in AndroidManifest.xml  
AndroidManifest.xml에서 launch theme를 하기 위해 FlutterActivity의 theme를 set해라.  
그때, 적절한 시간에 normal theme에서 launch theme로부터 변화하기 위해 Flutter를 지시하는 것이 바람직한 FlutterActivity에 metadata element를 추가해라.
```dart
<activity
    android:name=".MyActivity"
    android:theme="@style/LaunchTheme"
    // ...
    >
    <meta-data
        android:name="io.flutter.embedding.andriod.NormalTheme"
        android:resource="@style/NormalTheme"
        />
    <intent-filter>
        <action android:name="andriod.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
</activity>
```  
android 앱은 app initializes 하는 동안 바람직한 launch screen 당장 보여준다.  

### Android S  
링크된 [Android S의 Android Splash Screen](https://developer.android.com/about/versions/12/features/splash-screen)을 봐라.  

API's가 아니므로 manifest에서 io.flutter.embedding.android.SplashScreenDrawable를 set도 아니고, provideSplashScreen 구현된 것도 아니다.  
어떤 앱들은 Flutter에서 Android splash screen의 마지막 frame에서 보여주는 것을 계속하기를 원할 수 있다.  

Java
```java
import android.os.Build;
import android.os.Bundle;
import android.window.SplashScreenView;
import androidx.core.view.WindowCompat;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            getSplashScreen()
                .setOnExitAnimationListener(
                    (SplashScreenView splashScreenView) -> {
                        splashScreenView.remove();
                    });
        }

        super.onCreate(savedInstanceState);
    }
}
```  

Kotlin
```kotlin
import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    // Aligns the Flutter view vertically with the window.
    WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
      // Disable the Android splash screen fade out animation to avoid
      // a flicker before the similar frame is drawn in Flutter.
      splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
    }

    super.onCreate(savedInstanceState)
  }
}
```  
그때 Flutter에서 첫 번째 frame을 재구현을 할 수 있다. Screen에서 동일한 positions안에 Android splash screen의 elements를 보여준다.    

### Migrating from Manifest / Activity defined custom splash screens  
이전 버전과 다르게 Flutter 2.5 이상에서 Flutter는 Flutter가 첫 번째 프레임을 그릴 때까지 Android 시작 화면을 자동으로 계속 보여준다. 개발자는 대신 이러한 API의 사용을 제거해야 한다.
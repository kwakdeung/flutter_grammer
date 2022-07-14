# Configuring the URL strategy on the web(웹에서의 URL 전략 구성)  

Flutter web의 앱들은 **URL-based navigation**으로 구성된 2개의 길로 지원한다.  

**Hash (default): #**  
Path들은 hash fragment(조각)를 읽고 쓴다.  
```
flutterexample.dev/#/path/to/screen.
```  

**Path**  
Path들은 hash 없이 읽고 쓴다.
```
flutterexample.dev/path/to/screen.
```  

## Configuring the URL strategy(URL 전략 구성)  

 SDK에서 flutter_web_plugins library에 의하여 제공된 **setUrlStrategy** function을 사용해라.  
 **setUrlStrategy** API는 오직 웹에서 불러진다.  

> **참고:** default에 의해서 flutter는 hash (**/#/**) location 전략을 사용한다. 이 지시서는 만약 **URL path 전략** 사용하기를 원할 때 오직 필요로 한다.  
위 지시서를 사용 대신에, 너는 **url_strategy** package를 사용 할 수 있다.
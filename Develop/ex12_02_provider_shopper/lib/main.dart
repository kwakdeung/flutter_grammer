import 'package:ex12_02_provider_shopper/screens/login.dart';
import 'package:flutter/material.dart';

import 'common/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyLogin(),
      },
    );
  }
}

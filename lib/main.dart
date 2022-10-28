import 'package:fl_qrreader/providers/ui_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fl_qrreader/pages/home_page.dart';
import 'package:fl_qrreader/pages/mapa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UiProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepPurple),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple,
            )),
      ),
    );
  }
}

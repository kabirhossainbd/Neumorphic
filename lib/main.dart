import 'package:calculator/calculator/calculator_logic.dart';
import 'package:calculator/calculator/calculator_view.dart';
import 'package:calculator/calculator/neumorphic_theme.dart';
import 'package:calculator/neumorphic_bar/neumorphic_bar.dart';
import 'package:calculator/neumorphic_pie/neumorphic_pie.dart';
import 'package:calculator/timer/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Widgets',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: kDarkBackgroundColour,
      ),
      theme: ThemeData(
        canvasColor: kBackgroundColour,
        scaffoldBackgroundColor: Color.fromRGBO(231, 240, 247, 1),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontSize: 43,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
          headlineMedium: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
        ),
      ),
      home: Builder(
        builder: (BuildContext context) {
          final brightnessValue = MediaQuery.of(context).platformBrightness;
          bool isDark = brightnessValue == Brightness.dark;
          final theme = isDark ? darkNeumorphicTheme : lightNeumorphicTheme;
          // Intro, need to show the first use case: 1+1 = 2 (iphone case)
          // part of -1 Since got 2 providers, use multiprovider
          return MultiProvider(
            providers: [
              ProxyProvider0<NeumorphicTheme>(update: (_, __) => theme),
              // part of -1. Explain wanted to do on mobx and did not pursue
              // and how it is not relevant. However, very good async stuff,
              // to the non-async part. Yeah. So, use what's availabe, which
              // is change notifier and change notifier provider
              ChangeNotifierProvider<Calculator>(create: (_) => Calculator())
            ],
            child: TimerScreen(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BarDays(),
          SizedBox(height: 40),
          NeumorphicPie(),
        ],
      ),
    );
  }
}

class BarDays extends StatelessWidget {
  const BarDays({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.5,
          text: 'Mon',
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.9,
          text: 'Tue',
          color: Color.fromRGBO(0, 200, 156, 1),
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.7,
          text: 'Wed',
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 1,
          text: 'Thur',
        ),
      ],
    );
  }
}

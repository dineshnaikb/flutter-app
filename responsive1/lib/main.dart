import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.80,
            child: Container(
              alignment: Alignment.centerLeft,
              color: const Color(0xffD18585),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      height: 40,
                      color: const Color(0xFFC4C4C4),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    height: 48,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                        color: const Color(0xffA8D8AD),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FractionallySizedBox(
                  widthFactor: 0.80,
                  child: Container(
                      color: const Color(0xffD18585),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        height: 70,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            color: const Color(0xffA8D8AD),
                          ),
                        ),
                      )),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: 300,
                  height: 40,
                  color: const Color(0xFFC4C4C4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'Simple Slider Game';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _highestStreakCounter = 0;
  int _currentStreakCounter = 0;
  int _randomNumber = 1;
  int _currentUserValue = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      _randomNumber = _generateRandomNumber();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _generateRandomNumber() {
    return Random().nextInt(101) + 1;
  }

  void _onCheckTapped() {
    if (_randomNumber == _currentUserValue) {
      Fluttertoast.showToast(msg: 'Bravo', toastLength: Toast.LENGTH_SHORT);
      setState(() {
        _currentStreakCounter++;
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Too bad. That\'s $_currentUserValue',
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        _currentStreakCounter = 0;
      });
    }

    setState(() {
      _highestStreakCounter = max(_currentStreakCounter, _highestStreakCounter);
      _randomNumber = _generateRandomNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double minValue = 1, maxValue = 100;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Highest Streak: $_highestStreakCounter'),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        'Slide the slider as close as you can to match the number'),
                    Text(
                      '$_randomNumber',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.cyan,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${minValue.round()}'),
                        Flexible(
                          child: Slider(
                            value: _currentUserValue.toDouble(),
                            onChanged: (v) => setState(() {
                              _currentUserValue = v.round();
                            }),
                            min: minValue,
                            max: maxValue,
                            label: null,
                          ),
                        ),
                        Text('${maxValue.round()}'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _onCheckTapped,
                      child: const Text('Check'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

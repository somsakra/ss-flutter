import 'package:flutter/material.dart';
import 'package:my_first_app/src/constants/asset.dart';

class ScreenArguments {
  final String name;
  final int age;

  ScreenArguments(this.name, this.age);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // final models = Map.from(arguments);
    // var name = models['name'];
    // var age = models['age'];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Back')),
          // Text(name.toString()),
          // Text(age.toString()),
          Image.asset(Asset.LOGO_IMAGE),
          Image.network(
              'https://images.dog.ceo/breeds/hound-english/n02089973_2017.jpg')
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: Center(
        child: TextButton(
          child: const Text('POP'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => const MyPage(title: Text('page A')),
        '/b': (BuildContext context) => const MyPage(title: Text('page B')),
        '/c': (BuildContext context) => const MyPage(title: Text('page C')),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/a');
                Navigator.push(context,
                    MaterialPageRoute<bool>(builder: (BuildContext context) {
                  return Center(
                    child: GestureDetector(
                        child: const Text('OK'),
                        onTap: () {
                          Navigator.pop(context, true);
                        }),
                  );
                }));
              },
              child: const Text('Go to page A'),
            ),
            ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/b');
                Navigator.push(
                    context,
                    PageRouteBuilder<void>(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return const Center(child: Text('My PageRoute'));
                        },
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: RotationTransition(
                              turns: Tween<double>(begin: 0.5, end: 1.0)
                                  .animate(animation),
                              child: child,
                            ),
                          );
                        }));
              },
              child: const Text('Go to page B'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/c');
              },
              child: const Text('Go to page C'),
            ),
          ],
        ),
      ),
    );
  }
}

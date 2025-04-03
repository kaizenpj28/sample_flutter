import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app_rest_api/register.dart';
import 'package:flutter_app_rest_api/restApiService.dart';
import 'package:flutter_app_rest_api/album.dart';

class MyRestExamApp extends StatelessWidget {
  const MyRestExamApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final restApiService = RestApiService();
  Future<Register>? _regitster;
  Future<List<Register>>? _registerList;
  bool _getData = false;
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('RestApi Get, Post'),
      ),
      body: _regitster == null && !_getData
        ? Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(hintText: 'Enter a Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllerPassword,
                decoration: const InputDecoration(hintText: 'Enter a Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _regitster = restApiService.postRegister(_controllerEmail.text, _controllerPassword.text);
                    _futureAlbum = createAlbum(_controllerEmail.text);
                  });
                },
                child: const Text('Post Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _registerList = restApiService.getRegisterList();
                    _getData = !_getData;
                  });
                },
                child: const Text('Get Register List'),
              ),
            ],
          ),
        )
      : _regitster != null && !_getData
        ? Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<Register>(
            future: _regitster,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Register: ${snapshot.data!.email}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      : Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<Register>>(
            future: _registerList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Text('Register: ${snapshot.data![index].email}'),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      
    );
  }
}

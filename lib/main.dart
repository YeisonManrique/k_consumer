import 'package:flutter/material.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/action.dart' as android_action;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demo Intent consumer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController _controller;

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
	    TextField(
	      controller: _controller,
	      decoration: InputDecoration(
		hintText: 'Text to send'
	      )
	    ),
	    ElevatedButton(
	      onPressed: () => android_intent.Intent()
                ..setAction(android_action.Action.ACTION_SEND)
                ..setType('text/plain')
                ..putExtra(android_extra.Extra.EXTRA_TEXT, '${_controller.text}')
                ..startActivity().catchError((e) => print(e)),
		// ..startActivityForResult().then(
                //   (data) => print(data),
                //   onError: (e) => print(e.toString()),
                //  ),
	      child: const Text('Send')
	    )
          ],
        ),
      ),
    );
  }
}

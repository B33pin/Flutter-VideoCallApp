import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  int _counter;
  List<Map<String,dynamic>> data;
  String dbdata ;
  void _insert() async {
  dbHelper.insert({
    DatabaseHelper.value: '$_counter'
  });
  }
  void _update() async {
    dbHelper.update({
      DatabaseHelper.columnId: 1,
      DatabaseHelper.value: '$_counter'
    });
  }
  void _getdata() async {
    data = await dbHelper.queryAllRows();
      dbdata= data[0]['age'];
      setState(() {
        _counter = int.parse(dbdata);
      });
  }
    void _incrementCounter()  {
    setState(() {
      _counter++;
    });
    _update();

  }
  @override
  void initState() {
    _getdata();
    super.initState();
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
            Text(
              'You have pushed the button this many times:',
            ),
            _counter!=null?Text(
             '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ): CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

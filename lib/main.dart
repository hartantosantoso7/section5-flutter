import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home:  MyApp(),
    ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

 enum Answer{YES, NO, MAYBE}

class _State extends State<MyApp> {

  String _value = '';

  void setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch(
      await showDialog(
        context: context,
        child: new SimpleDialog(
          title: Text('Do you like flutter'),
          children: <Widget>[
            SimpleDialogOption(child: Text('YES'), onPressed: (){Navigator.pop(context, Answer.YES);},),
            SimpleDialogOption(child: Text('NO'), onPressed: () {Navigator.pop(context, Answer.NO);},),
            SimpleDialogOption(child: Text('MAYBE'), onPressed: (){Navigator.pop(context, Answer.MAYBE);},)
          ],
        )
      )
    ) {
      case Answer.YES:
          setValue('Yes');
          break;
      case Answer.NO:
          setValue('No');
          break;
      case Answer.MAYBE:
          setValue('Maybe');
          break;
    }
  }
  

  void _showButton(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return new Container(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('some info here ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
              RaisedButton(onPressed:  () => Navigator.pop(context), child: Text('Close '),)
            ],
          ),
        );
      }
    );
  }


  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  void _showBar() {
    _scaffoldstate.currentState.showSnackBar(SnackBar(content: Text('Hello world'),));
  }


  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
      context: context,
      child: new AlertDialog (
        title: Text('Alert dialog'),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.pop(context), child: Text('ok'),)
        ],)
    );
  }

  String _value1 = '';

   final GlobalKey<ScaffoldState> _scaffoldstate2 = new GlobalKey<ScaffoldState>();

  void _showBar2(String message) {
    _scaffoldstate2.currentState.showSnackBar(SnackBar(content: Text(message),));
  }
 
  void _onChange(String value) {
    setState(() {
      _value1 = value;
    });
  }



 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldstate,
      key: _scaffoldstate2,
    
      appBar: AppBar(
        title: Text('Section 5'),
      ),

      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Add widget here'),
              RaisedButton(onPressed: _showButton, child: Text('Close'),),
              RaisedButton(onPressed: _showBar, child: Text('click me'),),
              RaisedButton(onPressed: () => _showAlert(context, 'Do you like flutter'), child: Text('Clik me'),),
              RaisedButton(onPressed: _askUser, child: Text('Klik'),),
              Text('Enter your name :'),
              TextField(onChanged: _onChange,),
              RaisedButton(onPressed: () => _showBar2('Hello ${_value1}'), child: Text('Click me'),)
            ],
          ),
        ),
      ),
    );
  }
}
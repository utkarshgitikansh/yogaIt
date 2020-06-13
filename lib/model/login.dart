import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yogait/model/dashboard.dart';
import 'package:yogait/model/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _pwd;
  String edited_date;
  bool _obscureText = true;

  int _count = 0;
  int old_count = 0;
  int pcount;

  List arr = [];

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  login() {

    Firestore.instance
        .collection('user')
        .document(_name)
        .get()
        .then((DocumentSnapshot ds) {

      if(ds.exists){
        print('yes');
      }
      else
        print('no');
    });

    var route = new MaterialPageRoute(builder: (BuildContext context) => new Dashboard(value: _name,));

    Navigator.of(context).pushReplacement(route);
    
    if(_name == 'yoga'){
      Navigator.pushNamed(context, '/second');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/yoga.png"), fit: BoxFit.cover)),
      child: Scaffold(

          backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('YogaIt'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,

        ),

        body:

        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formKey,

                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Material(
                        child:


                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                              fillColor: Colors.grey.shade400
//                              icon: const Padding(
//                                  padding: const EdgeInsets.only(top: 15.0),
//                                  child: const Icon(Icons.person_outline))
                          ),
                          // ignore: missing_return
                          validator: (String value){
                            if(value.isEmpty) return 'Username is Required';
                          },
                          onSaved: (String value) {
                            _name = value;

                          },
                        ),

                      ),


                      Material(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                              fillColor: Colors.grey.shade400
                             ),
                          validator: (val) => val.length < 6 ? 'Password too short.' : null,
                          onSaved: (val) => _pwd = val,
                          obscureText: _obscureText,
                          // ignore: missing_return
//                    validator: (String value){
//                      if(value.isEmpty) return 'Password is Required';
//                    },
                        ),
                      ),

                      SizedBox(height: 20),
//                  Text(
//                    'New item count',
//                    style: TextStyle(
//                        color: Colors.blue,
//                        fontSize: 16
//                    ),
//                  ),
                      SizedBox(height: 20),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//
//                      RawMaterialButton(
//                        onPressed: () {
//                          decrement();
//                        },
//                        elevation: 2.0,
//                        fillColor: Colors.white,
//                        child: Icon(
//                          Icons.remove,
//                          size: 20.0,
//                        ),
//                        padding: EdgeInsets.all(5.0),
//                        shape: CircleBorder(),
//                      ),
//
//                      Text(
//                        _count.toString(),
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 16
//                        ),
//                      ),
//
//                      RawMaterialButton(
//                        onPressed: () {
//                          increment();
//                        },
//                        elevation: 2.0,
//                        fillColor: Colors.white,
//                        child: Icon(
//                          Icons.add,
//                          size: 20.0,
//                        ),
//                        padding: EdgeInsets.all(5.0),
//                        shape: CircleBorder(),
//                      ),
//                    ],
//                  ),
                      SizedBox(height: 20),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
//                      RaisedButton(
//                        child: Text(
//                          'Add item',
//                          style: TextStyle(
//                              color: Colors.blue,
//                              fontSize: 16
//                          ),
//                        ),
//                        onPressed: () {
//                          if(!_formKey.currentState.validate()){
//                            return;
//                          }
//
//                          _formKey.currentState.save();
//
//
//                          if(_item.toString() == "") {
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                              content: Text("Please enter the item!!"),
//                            ));
//                          }
//
//                          write();
//                          _formKey.currentState.reset();
//
//                        },
//                      ),

                          RaisedButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16
                              ),
                            ),
                            onPressed: () {
                              if(!_formKey.currentState.validate()){
                                return;
                              }
                              _formKey.currentState.save();
                              login();
                              _formKey.currentState.reset();

                            },
                          ),


                        ],
                      ),



                      SizedBox(height: 30),

                      new Center(
                        child: new InkWell(
                            child: new Text('New User (Signup)',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                              ),),

                            onTap: () => Navigator.pushReplacementNamed(context, '/signup')
                        ),
                      ),

                    ],

                  ),
                )
            ),
          ),
        )
      ),
    );
  }
}

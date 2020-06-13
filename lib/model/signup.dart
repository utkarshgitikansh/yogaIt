import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _pwd;
  String _account;
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


  signup() {

    Firestore.instance.collection('user').document(_name.toLowerCase())
        .setData({ 'account' : _account.toLowerCase() , 'trial' : 30});

      Navigator.pushNamed(context, '/second');

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
                              ),
                            // ignore: missing_return
                            validator: (String value){
                              if(value.isEmpty) return 'Inventory is Required';
                            },
                            onSaved: (String value) {
                              _name = value;

                            },
                          ),

                        ),

                        SizedBox(height: 5),

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
                            ),
                        ),

                        SizedBox(height: 5),

                        Material(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Account Type (Trial or Premium)',
                              filled: true,
                               fillColor: Colors.grey.shade400
                               ),
                            // ignore: missing_return
                        validator: (String value){
                          if(value.isEmpty) return 'Account Type is Required';
                        },
                            onSaved: (String value) {
                              _account = value;

                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(height: 20),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            RaisedButton(
                              child: Text(
                                'Signup',
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
                                signup();
                                _formKey.currentState.reset();

                              },
                            ),

                                       ],
                        ),



                        SizedBox(height: 30),

                        new Center(
                          child: new InkWell(
                              child: new Text('Back to login',
                                style: TextStyle(
                                decoration: TextDecoration.underline,
                                  color: Colors.white,

                              ),),

                              onTap: () => Navigator.pushReplacementNamed(context, '/')
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

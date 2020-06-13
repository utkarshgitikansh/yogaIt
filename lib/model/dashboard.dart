import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  String value;

  Dashboard({Key key, this.value}) : super (key : key);

  @override
  _DashboardState createState() => _DashboardState();

}


class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin{

  TabController controller;
  final DBRef = Firestore.instance.collection('items');

  String _name;

  List url = [
    'https://www.proprofs.com/api/ckeditor_images/New%20Project%20(25)(37).jpg',
    'https://media.musely.com/u/4544003e-b174-4a11-bb35-0cca52436174.jpg',
    'https://cdn.pixabay.com/photo/2017/08/02/20/24/people-2573216__340.jpg',
    'https://img.icliniq.com/qa/please-suggest-yoga-asanas-that-would-improve-blood-flow-to-testicles.jpg'
  ];

  List plan = [
    'Task 1',
    'Task 2',
    'Task 3',
    'Task 4'
  ];

  List duration = [
    '30',
    '15',
    '45',
    '60'
  ];

  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot> provideDocumentFieldStream() {
      return Firestore.instance
          .collection('user')
          .document('${widget.value}')
          .snapshots();
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('YogaIt'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.collections)),
            new Tab(icon: new Icon(Icons.library_add)),
            new Tab(icon: new Icon(Icons.receipt)),
          ],
        ),
      ),

      body:
      new TabBarView(
        controller: controller,
        children: <Widget>[

      Container(
        color: Colors.deepOrangeAccent.shade100.withOpacity(0.5),
        child: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: url.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = url[index];

            return Card(

              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                item,
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            );
          },
        ),
      ),

        ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: plan.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = plan[index];
            final item2 = duration[index];

            return Card(
              color: Colors.deepOrangeAccent.shade100,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text(item),
                subtitle: Text(item2 + " days"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            );
          },
        ),

          Container(
//            color: Colors.deepOrangeAccent.shade100,
            child: StreamBuilder<DocumentSnapshot>(
                stream: provideDocumentFieldStream(),
                // ignore: missing_return
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  if(!snapshot.hasData) return new CircularProgressIndicator();

                  if (snapshot.hasData) {


                    Map documentFields = snapshot.data.data;


                    return
//                    Text(documentFields['account']);
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  leading: Icon(Icons.person_outline),
                                  title: Text('Customer'),
                                  subtitle: Text('${widget.value}')
                              ),
                               ListTile(
                                leading: Icon(Icons.account_balance_wallet),
                                title: Text('Account'),
                                subtitle: Text(documentFields['account'].toString())
                              ),
                              ListTile(
                                  leading: Icon(Icons.access_time),
                                  title: Text('Validity'),
                                  subtitle: Text(documentFields['trial'].toString() + " days")
                              ),

                              SizedBox(height: 30),

                              RaisedButton(
                                child: Text(
                                  'Log out',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                              ),


//                            ButtonBar(
//                              children: <Widget>[
//                                FlatButton(
//                                  child: const Text('BUY TICKETS'),
//                                  onPressed: () { /* ... */ },
//                                ),
//
//                              ],
//                            ),
                            ],
                          );
                  }
                }
            ),
          ),




        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//
//        },
//        child: Text('Add'),
//        backgroundColor: Colors.indigoAccent,
//      ),
    );
  }

}


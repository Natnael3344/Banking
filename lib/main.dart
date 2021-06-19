import 'package:banking/Customers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHome()
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(
          image: AssetImage('images/blue.png'), fit: BoxFit.fill,),),
        child: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 140),
              child: Text('Welcome To\nSimple \nBanking App!', style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),),
            )),
      ),
      floatingActionButton: Container(
        width: 120,
        height: 70,
        // ignore: deprecated_member_use
        child: RaisedButton(
            color: Colors.white,
            child: Text('Start'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(50, 50))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Customers()));
            }),
      ),
    );
  }

}
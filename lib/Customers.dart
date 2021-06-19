import 'package:banking/Individual.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'CustomersList.dart';
import 'Transfer.dart';

class Customers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250,18,85,137,),
        title: Text('Customers'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transfer()));
              },
              child: Text('Transfer'),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Tile(context, number: 0),
          Tile(context, number: 1),
          Tile(context, number: 2),
          Tile(context, number: 3),
          Tile(context, number: 4),
          Tile(context, number: 5),
          Tile(context, number: 6),
          Tile(context, number: 7),
          Tile(context, number: 8),
          Tile(context, number: 9),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Tile(BuildContext context, {int number}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(250,18,85,137,),
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(20, 20),
                bottomRight: Radius.elliptical(20, 20))),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Individual(
                        namE: name[number],
                        emaiL: email[number],
                        balancE: balance[number])));
          },
          title: Text(
            name[number],
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            email[number],
            style: TextStyle(color: Colors.white54),
          ),
          trailing: Text(
            balance[number].toString() + '₹',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

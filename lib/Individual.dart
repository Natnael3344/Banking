import 'dart:ui';
import 'package:flutter/material.dart';
import 'Customers.dart';

class Individual extends StatelessWidget {
  final namE;
  final emaiL;
  final balancE;
  Customers customers = Customers();

  Individual({this.namE, this.emaiL, this.balancE});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 18, 85, 137,),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color.fromARGB(250, 18, 85, 137,),
            child: Icon(
              Icons.person,
              size: 300,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(60, 60),
                      topRight: Radius.elliptical(60, 60))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        namE,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(250,18,85, 137,)),
                      ),
                      subtitle: Text(
                        emaiL,
                        style: TextStyle(
                            color: Color.fromARGB(250,18,85,137,)),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Balance',
                        style: TextStyle(
                            color: Color.fromARGB(250,18,85,137,)),
                      ),
                      trailing: Text(
                        balancE.toString() + '₹',
                        style: TextStyle(
                            color: Color.fromARGB(250,18,85,137,)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

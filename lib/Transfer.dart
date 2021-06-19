import 'dart:ui';
import 'package:flutter/material.dart';
import 'CustomersList.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  int initial;
  int num;
  int finaL;

  @override
  void initState() {
    initial = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 18, 85, 137,),
      appBar: AppBar(
        title: Text('Transfer Money'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(250, 18, 85, 137,),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.elliptical(60, 60),
                topRight: Radius.elliptical(60, 60))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: Text('Amount',
                style: TextStyle(fontSize: 20, color: Colors.black38),)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.remove_circle_outlined, size: 40,
                  color: Colors.black38,), onPressed: () {
                  setState(() {
                    initial = initial - 1;
                  });
                }),
                Text(' $initial' + '₹ ', style: TextStyle(fontSize: 40),),
                IconButton(icon: Icon(
                  Icons.add_circle, size: 40, color: Colors.black38,),
                    onPressed: () {
                      setState(() {
                        initial = initial + 1;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    child: TextFormField(
                      onChanged: (value) {
                        num = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Payable Amount.. ',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                    color: Color.fromARGB(250, 18, 85, 137,),
                    child: Text('Set', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      setState(() {
                        initial = num;
                      });
                    })
              ],
            ),
            Center(child: Text(
              'Select a recipient', style: TextStyle(color: Colors.black38),)),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Pay(0),
                  Pay(1),
                  Pay(2),
                  Pay(3),
                  Pay(4),
                  Pay(5),
                  Pay(6),
                  Pay(7),
                  Pay(8),
                  Pay(9),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

  Padding Pay(int number) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(250, 18, 85, 137,),
            borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),
                bottomRight: Radius.elliptical(20, 20))),
        child: ListTile(
          leading: Icon(Icons.person, color: Colors.white,),
          title: Text(name[number], style: TextStyle(color: Colors.white),),
          subtitle: Text(
            email[number], style: TextStyle(color: Colors.white54),),
          onTap: () {
            showDialog(context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text('Transfer'),
                      content: Text(
                        ' $initial' + '₹ ' + ' \n\nTo ' + name[number],),
                      actions: [
                        // ignore: deprecated_member_use
                        FlatButton(onPressed: () {
                          Navigator.pop(context);
                        },
                            child: Text('Cancel')),
                        // ignore: deprecated_member_use
                        FlatButton(onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title: Text('Transferred'),
                                    content: Icon(
                                      Icons.check, color: Colors.green,
                                      size: 50,),
                                    actions: [
                                      // ignore: deprecated_member_use
                                      FlatButton(onPressed: () {
                                        setState(() {
                                          balance[number] =
                                              balance[number] + initial;
                                          print(balance[number]);
                                        });

                                        Navigator.pop(context);
                                      }, child: Text('Done'))
                                    ],
                                  )
                          );
                        },
                            child: Text('Ok'))
                      ],
                    )
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lab12/db.dart';

class searchStudent extends StatefulWidget {
  const searchStudent({super.key});

  @override
  State<searchStudent> createState() => _searchStudentState();
}

class _searchStudentState extends State<searchStudent> {
  MyDb mydb = new MyDb();
  TextEditingController rollno = new TextEditingController();
  List<Map> std = [];

  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Student'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: rollno,
              decoration: InputDecoration(
                  labelText: 'Rollno', hintText: 'Enter Rollno'),
            ),
            ElevatedButton(
              onPressed: () async {
                String testroll = rollno.text;
                std = await mydb.db
                    .rawQuery("Select * from students where roll_no=$testroll");
                print(std);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Student"),
                        content: Column(children: [
                          Text(
                            std.toString(),
                          ),
                        ]),
                      );
                    });
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool checked = false;
  final DocumentReference lampRef =
      Firestore.instance.document('lampStates/main');
  _MyHomePageState() {
    lampRef.get().then((val) => setState(() => {
          checked =
              val.data.entries.singleWhere((entry) => entry.key == 'isOn').value
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            IconButton(
              icon:
                  Icon(checked ? MdiIcons.lightbulbOn : MdiIcons.lightbulbOutline),
              onPressed: () => {
                setState(() => {checked = !checked}),
                Firestore.instance.runTransaction((Transaction tx) async {
                  DocumentSnapshot postSnapshot = await tx.get(lampRef);
                  if (postSnapshot.exists) {
                    await tx.update(lampRef, <String, bool>{'isOn': checked});
                  }
                })
              },
              iconSize: 128,
            ),
          ]
        )
      ),
    );
  }
}

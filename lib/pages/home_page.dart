import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 4),
    Band(id: '3', name: 'héroes del silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(
          bands[i],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('ID: ${band.id}');
        //TODO Llamar el borrado en el server
      },
      background: Container(
          padding: EdgeInsets.only(left: 10),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name!.substring(0, 2),
          ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      //Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                onPressed: () => addBandToList(textController.text),
                child: Text('add'),
                elevation: 5,
                textColor: Colors.blue,
              ),
            ],
          );
        },
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New Band Name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop,
            )
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      // podemos agregar
      this.bands.add(
            (new Band(id: DateTime.now().toString(), name: name, votes: 0)),
          );
      setState(() {});
    }
    Navigator.pop(context);
  }
}

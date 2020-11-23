import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: "Metalica", votes: 5),
    Band(id: '2', name: "Bon Jove", votes: 7),
    Band(id: '3', name: "ACDC", votes: 9),
    Band(id: '4', name: "Nickelback", votes: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BandNames", style: TextStyle(color: Colors.black87) ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) =>  _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand ),
   );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direccion){
        print("direccion: $direccion");
        print("id: ${band.id}");
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Delete Band", style: TextStyle(color: Colors.white),)),
      ),
      key: Key(band.id),
          child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0,1)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
          onTap: (){
            print(band.name);
          },
        ),
    );
  }


  addNewBand(){

    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("New band name"),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              child: Text("Add"),
              onPressed: () => addBandToList(textController.text),
              textColor: Colors.blue,
            )
          ],
        );
      }

    );

    return;
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_){
          return CupertinoAlertDialog(
            title: Text("New band name"),
            content: TextField(
              controller: textController
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Add"),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text("Dismiss"),
                onPressed: () => Navigator.pop(context),
              ),

            ],
          );
        });
    }




  }


  void addBandToList(String name){
    if(name.length > 1){
      //podemos agregar
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0 ));

      setState(() {});
      Navigator.pop(context);
    }
  }


}


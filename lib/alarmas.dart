import 'package:flutter/material.dart';

class ListViewModel {
  final String medicina;
  final String descripcion;
  final String hora;

  ListViewModel({
    this.medicina,
    this.descripcion,
    this.hora,
  });
}

List listViewData = [
  ListViewModel(
    medicina: "Medicina",
    descripcion: "De la que cura",
    hora: "1:53 pm",
  ),
  ListViewModel(
    medicina: "Otra medicina",
    descripcion: "Que tambien cura",
    hora: "2:44 pm",
  ),
  ListViewModel(
    medicina: "Una medicina mas",
    descripcion: "Esta mas o menos",
    hora: "3:27 pm",
  ),
  ListViewModel(
    medicina: "Medicina plus",
    descripcion: "Una mejor",
    hora: "10:23 pm",
  ),
];

class DisplayListView extends StatefulWidget {
  @override
  _DisplayListViewState createState() => _DisplayListViewState();
}

class _DisplayListViewState extends State {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listViewData.length,
      itemBuilder: (context, int i) => Column(
        children: [
          new ListTile(
            leading: CircleAvatar(

              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.deepOrangeAccent,
                ),
                onPressed: () {},
              ),
            ),
            title: new Text(listViewData[i].medicina),
            subtitle: new Text(listViewData[i].descripcion),
            trailing: Text(
              listViewData[i].hora,
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontStyle: FontStyle.italic,
                fontSize: 26.0,
              ),
            ),
            onTap: () {},
            onLongPress: () {
              print(
                Text("Long Pressed"),
              );
            },
          ),
        ],
      ),
    );
  }
}

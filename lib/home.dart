import 'package:flutter/material.dart';
import 'package:mxhck/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mxhck/pages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  Widget bodyWidget = MapPage();

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MapPage(),
    TakePictureScreen(
      camera: firstCamera,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      bodyWidget = _widgetOptions.elementAt(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "pastillaMe",
          style: TextStyle(color: Colors.white),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         PageTransition(
        //           child: SearchPage(),
        //           type: PageTransitionType.upToDown,
        //         ),
        //       );
        //     },
        //   )
        // ],
      ),
      body: Container(
        height: double.infinity,
        child: bodyWidget,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      //floatingActionButton: BotonDoctor(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm,
            ),
            title: Text('Alarmas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            title: Text('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title: Text('Busqueda'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.black45,
        onTap: _onItemTapped,
        //backgroundColor: firstColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:page_transition/page_transition.dart';

class newMed extends StatefulWidget {
  @override
  _newMedState createState() => _newMedState();
}

class _newMedState extends State<newMed> {
  int _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 28.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add_circle,
                  color: Colors.orange,
                  size: 38.0,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  'Nueva Medicina',
                  style: TextStyle(
                    fontSize: 26.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 28.0,
                bottom: 18.0,
              ),
              child: Text(
                'Ingrese medicina',
                style: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: Offset(0, 10),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                      hintStyle: TextStyle(fontFamily: "sofiapro-light"),
                      icon: Icon(Icons.local_pharmacy),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 28.0,
                bottom: 18.0,
              ),
              child: Text(
                'Ingrese descripción',
                style: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: Offset(0, 10),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                      hintStyle: TextStyle(fontFamily: "sofiapro-light"),
                      icon: Icon(Icons.description),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 28.0,
                bottom: 18.0,
              ),
              child: Text(
                'Ingrese frecuencia',
                style: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NumberPicker.integer(
                  initialValue: _currentValue,
                  minValue: 0,
                  maxValue: 100,
                  onChanged: (newValue) =>
                      setState(() => _currentValue = newValue),
                ),
                Text(
                  'días',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     child: Container(),
                //     type: PageTransitionType.downToUp,
                //   ),
                // );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 64),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Guardar',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontFamily: "aBeeZee",
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

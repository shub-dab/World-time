import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm'),
          content: Text('You want to exit?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),

            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        )
      );
    }

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    // set background
    String bgImage = data['isDaytime'] ? 'daytime.jpg' : 'night.jpg';
    Color bgColor = data['isDaytime'] ? Colors.blue[300] : Colors.indigo[900];

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: <Widget>[
                  RaisedButton.icon(
                    color: Colors.transparent,
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                    ),
                    label: Text(
                        'Choose location',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                        ),
                    ),
                  ),
                  SizedBox(height: 70,),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15,),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/${data['flag']}'),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

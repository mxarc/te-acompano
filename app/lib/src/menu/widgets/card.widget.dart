import 'package:flutter/material.dart';

class PhraseCardWidget extends StatelessWidget {
  String phrase;

  PhraseCardWidget({@required this.phrase});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            gradient:
                RadialGradient(center: AlignmentDirectional.topStart, stops: [
          0,
          0.9
        ], colors: [
          Color.fromRGBO(132, 81, 161, 1),
          Color.fromRGBO(132, 81, 161, 0.8),
        ])),
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(phrase,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 32)),
              Divider(),
              Row(
                children: <Widget>[
                  Spacer(),
                  Text(
                    '¿Te gustó esta frase?',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 15),
              _likeButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _likeButtons() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Spacer(),
          OutlineButton(
            onPressed: () => print('Si'),
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up, size: 15.0),
                SizedBox(
                  width: 5,
                ),
                Text('Sí')
              ],
            ),
            textColor: Colors.white,
          ),
          SizedBox(width: 10),
          OutlineButton(
            onPressed: () => print('No'),
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_down, size: 15.0),
                SizedBox(
                  width: 5,
                ),
                Text('No')
              ],
            ),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}

// background-image: radial-gradient( circle farthest-corner at 10% 20%,  rgba(132,81,161,1) 0%, rgba() 90% );

import 'package:flutter/material.dart';

class FeelWidget extends StatelessWidget {
  final List<Map<dynamic, dynamic>> _emociones = [
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/happy.png'), 'text': 'Feliz'},
    {'image': AssetImage('assets/neutral.png'), 'text': 'Neutral'},
    {'image': AssetImage('assets/sad.png'), 'text': 'Triste'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            _caras(context),
          ],
        ));
  }

  Widget _caras(BuildContext context) {
    return Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: _emociones
                .map((item) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          image: item['image'],
                          width: 60,
                        ),
                        SizedBox(height: 10),
                        Text(item['text']),
                      ],
                    )))
                .toList()));
  }
}

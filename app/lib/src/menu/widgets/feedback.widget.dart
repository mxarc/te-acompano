import 'package:flutter/material.dart';

class FeedbackWidget extends StatefulWidget {
  FeedbackWidget({Key key}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  String _feedback = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          child: Column(children: <Widget>[
            TextField(
                onChanged: (value) => setState(() => _feedback = value),
                textCapitalization: TextCapitalization.none,
                minLines: 2,
                maxLines: 8,
                maxLength: 1024,
                decoration: InputDecoration(
                  hintText: 'Dime algo que te gustaría expresar',
                  prefixIcon:
                      Icon(Icons.edit, color: Color.fromRGBO(132, 81, 161, 1)),
                  hasFloatingPlaceholder: true,
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(.1),
                  labelStyle: TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(132, 81, 161, 0.5), width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(132, 81, 161, 1), width: 2),
                      borderRadius: BorderRadius.circular(5)),
                ))
          ]),
        ),
      ),
    );
  }
}

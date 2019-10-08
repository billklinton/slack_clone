import 'package:flutter/material.dart';

class WorkspacesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.5,
                height: 8.5,
                margin: EdgeInsets.only(right: 1.2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              Container(
                width: 8.5,
                height: 8.5,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(2.0)),
              )
            ],
          ),
          Divider(
            height: 1.2,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 8.5,
                height: 8.5,
                margin: EdgeInsets.only(right: 1.2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              Container(
                width: 8.5,
                height: 8.5,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(2.0)),
              )
            ],
          )
        ],
      ),
    );
  }
}

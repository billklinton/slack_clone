import 'package:flutter/material.dart';

import '../theme.dart';

class PopupMenuItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Widget>(
      elevation: 10,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: 30,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      itemBuilder: (BuildContext context) {
        return _menuItemList();
      },
    );
  }

  List<PopupMenuItem<Widget>> _menuItemList() {
    var list = List<PopupMenuItem<Widget>>();
    list = [
      PopupMenuItem<Widget>(
        height: 0,
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    height: 43,
                    width: 41,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: ExactAssetImage("images/user.png"))),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.fiber_manual_record,
                      color: iconColor,
                      size: 16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Bill",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
      popupMenu("Definir seu status", Icons.sentiment_satisfied),
      PopupMenuItem<Widget>(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 15, 0, 15),
        child: Row(
          children: <Widget>[
            Text(
              "@",
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Text(
                "Atividade",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 17),
              ),
            )
          ],
        ),
      )),
      popupMenu("Favoritos", Icons.star_border),
      popupMenu("Diretório", Icons.person_pin),
      popupMenu("Não pertube", Icons.notifications_none),
      popupMenu("Convidar Pessoas", Icons.person_add),
      popupMenu("Configurações", Icons.settings),
    ];
    return list;
  }

  Widget popupMenu(String text, IconData icon) {
    return PopupMenuItem<Widget>(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 15, 0, 15),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 28,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}

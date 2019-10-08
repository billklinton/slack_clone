import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:slack_clone/blocs/workspaces_bloc.dart';
import 'package:slack_clone/components/home_navigation.dart';
import 'package:slack_clone/components/workspaces_navigation.dart';
import 'package:slack_clone/models/channel.dart';
import 'package:slack_clone/models/message.dart';
import 'package:slack_clone/models/workspace.dart';
import 'package:slack_clone/widgets/popup_menu_item_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.getBloc<WorkspacesBloc>();
    initializeDateFormatting('pt_BR', null);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<WorkSpace>(
              stream: _bloc.outWorkspace,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    snapshot.data.title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                return Container();
              },
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                PopupMenuItemWidget()
              ],
            )
          ],
        ),
        leading: StreamBuilder<WorkSpace>(
          initialData: WorkSpace(),
          stream: _bloc.outWorkspace,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                  margin: EdgeInsets.all(13),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image:
                              ExactAssetImage("images/${snapshot.data.image}"),
                          fit: BoxFit.cover))),
            );
          },
        ),
      ),
      drawer: StreamBuilder<bool>(
        stream: _bloc.outAlternateNavigation,
        initialData: true,
        builder: (context, snapshots) {
          return snapshots.data ? HomeNavigation() : WorkspacesNavigation();
        },
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<Channel>(
            stream: _bloc.outChannel,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  color: Color.fromARGB(255, 242, 242, 242),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "#   ${snapshot.data.title}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4),
                      ),
                      Icon(Icons.expand_more)
                    ],
                  ),
                );
              return Container();
            },
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<Channel>(
                stream: _bloc.outChannel,
                builder: (context, snapshot) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: snapshot.data == null
                        ? 0
                        : snapshot.data.messages.length,
                    itemBuilder: (context, index) {
                      var message = Message(
                          dateTime: snapshot.data.messages[index].dateTime,
                          text: snapshot.data.messages[index].text,
                          user: snapshot.data.messages[index].user);
                      return Container(
                        padding: EdgeInsets.fromLTRB(18, 15, 0, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              DateFormat("dd 'd'e MMMM 'd'e yyyy", "pt_BR")
                                  .format(message.dateTime),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 43,
                                  width: 43,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              "images/${message.user.image}"))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            message.user.name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            " ${message.dateTime.hour}h${message.dateTime.minute}",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text("${message.text}",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          StreamBuilder<Channel>(
            stream: _bloc.outChannel,
            builder: (context, snapshot) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.3))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4.5),
                            hintText: "Mensagem #${snapshot.data?.title}",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color.fromARGB(255, 252, 252, 252)))),
                      ),
                    ),
                    Icon(
                      Icons.photo_camera,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.photo, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.note_add, color: Colors.grey),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

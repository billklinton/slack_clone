import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slack_clone/blocs/workspaces_bloc.dart';
import 'package:slack_clone/models/channel.dart';
import 'package:slack_clone/models/workspace.dart';
import 'package:slack_clone/theme.dart';
import 'package:slack_clone/widgets/workspaces_widget.dart';

class HomeNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _blocWorkspaces = BlocProvider.getBloc<WorkspacesBloc>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      color: primaryColor,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 21,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Página inicial",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    _blocWorkspaces.alternateNavigation();
                  },
                  child: WorkspacesWidget()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(9),
              color: primaryColorLight,
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                          child: Icon(
                        Icons.view_headline,
                        color: textColorGrey,
                        size: 20,
                      )),
                      Container(
                        margin: EdgeInsets.fromLTRB(9.5, 5.5, 0, 0),
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(10))),
                        child: Icon(
                          Icons.search,
                          color: textColorGrey,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Ir para...",
                      style: TextStyle(color: textColorGrey, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.chat,
                  color: textColorGrey,
                  size: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child:
                      Text("Conversas", style: TextStyle(color: textColorGrey)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "CANAIS",
                  style: TextStyle(fontSize: 17, color: textColorGrey),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: textColorGrey),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Icon(
                    Icons.add,
                    size: 13,
                    color: textColorGrey,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  child: StreamBuilder<WorkSpace>(
                      stream: _blocWorkspaces.outWorkspace,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          itemCount: snapshot.data == null
                              ? 0
                              : snapshot.data.channels.length,
                          itemBuilder: (context, index) {
                            var channel = Channel(
                                title: snapshot.data.channels[index].title,
                                messages:
                                    snapshot.data.channels[index].messages);
                            return GestureDetector(
                              onTap: () {
                                _blocWorkspaces.alternateChannel(channel);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 19),
                                child: Text(
                                  "#   ${channel.title}",
                                  style: TextStyle(
                                      color: textColorGrey, fontSize: 16),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "MENSAGENS DIRETAS",
                        style: TextStyle(fontSize: 17, color: textColorGrey),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: textColorGrey),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Icon(
                          Icons.add,
                          size: 13,
                          color: textColorGrey,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: ListView(
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              color: iconColor,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 10),
                              child: Text(
                                "slackbot",
                                style: TextStyle(
                                    color: textColorGrey, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.fiber_manual_record,
                              color: iconColor,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "User",
                                style: TextStyle(
                                    color: textColorGrey, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

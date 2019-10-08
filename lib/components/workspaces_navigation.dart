import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slack_clone/blocs/workspaces_bloc.dart';
import 'package:slack_clone/models/workspace.dart';
import 'package:slack_clone/theme.dart';

class WorkspacesNavigation extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> _containerWidth;

  WorkspacesNavigation({this.animationController, double width})
      : _containerWidth = Tween(
          begin: 0.0,
          end: width,
        ).animate(CurvedAnimation(
            curve: Interval(0.0, 0.150), parent: animationController));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    var _blocWorkspaces = BlocProvider.getBloc<WorkspacesBloc>();
    double addressTextSize = 14;
    double titleTextSize = 18;
    double initialPointer = 0;
    double endPointer = 1000;
    return Material(
      elevation: 80,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails dragStartDetails) {
          initialPointer = dragStartDetails.localPosition.dx;
        },
        onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
          if (initialPointer > endPointer) animationController.reverse();
        },
        onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
          endPointer = dragUpdateDetails.localPosition.dx;
        },
        child: Container(
          width: _containerWidth.value,
          color: primaryColor,
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 21,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 33,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            _blocWorkspaces.alternateNavigation();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Text(
                            "Workspaces",
                            style: TextStyle(fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 33,
                      ),
                      itemBuilder: (context) {},
                      onSelected: (selected) {},
                    )
                  ],
                ),
              ),
              StreamBuilder<List<WorkSpace>>(
                  stream: _blocWorkspaces.outWorkspaces,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount:
                          snapshot.data == null ? 0 : snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (!snapshot.data[index].isSelected) {
                              var workSpace = WorkSpace(
                                  title: snapshot.data[index].title,
                                  address: snapshot.data[index].address,
                                  image: snapshot.data[index].image,
                                  channels: snapshot.data[index].channels);
                              _blocWorkspaces.alternateWorkspace(workSpace);
                            }
                            animationController.reverse();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 14.5, 14.5, 14.5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 6,
                                  height:
                                      snapshot.data[index].isSelected ? 43 : 6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4),
                                          topRight: Radius.circular(4))),
                                  margin: const EdgeInsets.only(right: 14.5),
                                ),
                                Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                          "images/${snapshot.data[index].image}",
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].title,
                                        style:
                                            TextStyle(fontSize: titleTextSize),
                                      ),
                                      Text(
                                        snapshot.data[index].address,
                                        style: TextStyle(
                                            color: textColorGrey,
                                            fontSize: addressTextSize),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.5, 14.5, 14.5, 14.5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Icon(
                        Icons.add,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Adicionar Workspaces",
                            style: TextStyle(fontSize: titleTextSize),
                          ),
                          Text("Entrar ou criar um workspace",
                              style: TextStyle(
                                  color: textColorGrey,
                                  fontSize: addressTextSize))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

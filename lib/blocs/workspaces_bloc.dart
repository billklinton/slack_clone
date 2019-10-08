import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:slack_clone/models/channel.dart';
import 'package:slack_clone/models/message.dart';
import 'package:slack_clone/models/user.dart';
import 'package:slack_clone/models/workspace.dart';

class WorkspacesBloc extends BlocBase {
  BehaviorSubject<List<WorkSpace>> _controllerListWorkspaces =
      BehaviorSubject<List<WorkSpace>>();
  Stream<List<WorkSpace>> get outWorkspaces => _controllerListWorkspaces.stream;

  BehaviorSubject<bool> _controllerNavigation = BehaviorSubject<bool>();
  Stream<bool> get outAlternateNavigation => _controllerNavigation.stream;
  bool _alternateNavigation = true;

  BehaviorSubject<WorkSpace> _controllerWorkspace =
      BehaviorSubject<WorkSpace>();
  Stream<WorkSpace> get outWorkspace => _controllerWorkspace.stream;

  BehaviorSubject<Channel> _controllerChannel = BehaviorSubject<Channel>();
  Stream<Channel> get outChannel => _controllerChannel.stream;

  WorkspacesBloc() {
    _controllerListWorkspaces.add(mockData());
    _controllerNavigation.add(_alternateNavigation);
    var firstData = mockData().first;
    _controllerWorkspace.add(firstData);
    _controllerChannel.add(firstData.channels.first);
  }

  void alternateNavigation() {
    _alternateNavigation = !_alternateNavigation;
    _controllerNavigation.add(_alternateNavigation);
  }

  void alternateWorkspace(WorkSpace workSpace) {
    var newList = List<WorkSpace>();
    for (var item in mockData()) {
      if (item.isSelected) item.isSelected = !item.isSelected;

      if (workSpace.title == item.title) item.isSelected = !item.isSelected;

      newList.add(item);
    }
    _controllerWorkspace.add(workSpace);
    _controllerListWorkspaces.add(newList);
  }

  void alternateChannel(Channel channel) {
    _controllerChannel.add(channel);
  }

  @override
  void dispose() {
    _controllerListWorkspaces.close();
    _controllerNavigation.close();
    _controllerWorkspace.close();
    _controllerChannel.close();
    super.dispose();
  }

  List<WorkSpace> mockData() {
    var listWorkSpaces = List<WorkSpace>();

    var user = User(name: "Bill", image: "user.png");
    var user2 = User(name: "Pedro", image: "user.png");
    var user3 = User(name: "João", image: "user.png");
    var user4 = User(name: "Michel", image: "user.png");

    //WorkSpace 1
    var listMessages = List<Message>();
    listMessages.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now().add(Duration(days: -4)),
          user: user),
    );
    listMessages.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now().add(Duration(days: -3)),
          user: user2),
    );
    listMessages.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now().add(Duration(days: -2)),
          user: user3),
    );
    listMessages.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now().add(Duration(days: -1)),
          user: user3),
    );
    listMessages.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now(),
          user: user4),
    );

    var listMessagesTest = List<Message>();
    listMessagesTest.add(
      Message(
          text: "Ok",
          dateTime: DateTime.now().add(Duration(days: -2)),
          user: user),
    );
    listMessagesTest.add(
      Message(
          text: "Flutter",
          dateTime: DateTime.now().add(Duration(days: -1)),
          user: user2),
    );
    listMessagesTest.add(
      Message(
          text:
              "Lorem ipsum facilisis sit dapibus platea, inceptos nam sociosqu scelerisque quisque, eget laoreet pharetra tortor.",
          dateTime: DateTime.now(),
          user: user4),
    );

    var listChannels = List<Channel>();
    listChannels.add(Channel(title: "architecture", messages: listMessages));
    listChannels
        .add(Channel(title: "best-of-adbr", messages: listMessagesTest));
    listChannels.add(Channel(title: "code-help", messages: listMessages));
    listChannels.add(Channel(title: "design", messages: listMessages));
    listChannels.add(Channel(title: "flutter", messages: listMessages));
    listChannels.add(Channel(title: "intro", messages: listMessages));
    listChannels.add(Channel(title: "kotlin", messages: listMessages));

    listWorkSpaces.add(WorkSpace(
        title: "Android Dev BR",
        image: "androiddevbr.png",
        address: "androiddevbr.slack.com",
        isSelected: true,
        channels: listChannels));

    //WorkSpace 2
    var listMessages2 = List<Message>();
    listMessages2.add(
      Message(text: "New Message", dateTime: DateTime.now().add(Duration(days: -2)), user: user),
    );
    listMessages2.add(
      Message(text: "New Message 2", dateTime: DateTime.now().add(Duration(days: -1)), user: user2),
    );
    listMessages2.add(
      Message(text: "New Message 3", dateTime: DateTime.now(), user: user3),
    );

    var listChannels2 = List<Channel>();
    listChannels2.add(Channel(title: "community", messages: listMessages2));
    listChannels2.add(Channel(title: "events", messages: listMessages2));
    listChannels2.add(Channel(title: "general", messages: listMessages2));
    listChannels2.add(Channel(title: "jobs", messages: listMessages2));
    listChannels2.add(Channel(title: "questions", messages: listMessages2));
    listChannels2.add(Channel(title: "random", messages: listMessages2));

    listWorkSpaces.add(WorkSpace(
        title: "Betim Dev",
        image: "betimdev.png",
        address: "betimdev.slack.com",
        isSelected: false,
        channels: listChannels2));

    //WorkSpace 1

    var listChannels3 = List<Channel>();
    listChannels3.add(Channel(title: "general", messages: listMessages));
    listChannels3.add(Channel(title: "intro", messages: listMessages));
    listChannels3.add(Channel(title: "learn", messages: listMessages));
    listChannels3.add(Channel(title: "random", messages: listMessages));
    listChannels3.add(Channel(title: "showcases", messages: listMessages));
    listChannels3.add(Channel(title: "updates", messages: listMessages));
    listChannels3.add(Channel(title: "vagas", messages: listMessages));

    listWorkSpaces.add(WorkSpace(
        title: "Flutter Brasil",
        image: "flutterbr.png",
        address: "flutterbr.slack.com",
        isSelected: false,
        channels: listChannels3));

    var listChannels4 = List<Channel>();
    listChannels4.add(Channel(title: "comunidade", messages: listMessages));
    listChannels4
        .add(Channel(title: "cryptocurrencies", messages: listMessages));
    listChannels4.add(Channel(title: "diversidade", messages: listMessages));
    listChannels4.add(Channel(title: "duvidas", messages: listMessages));
    listChannels4.add(Channel(title: "eventos", messages: listMessages));
    listChannels4.add(Channel(title: "jobs", messages: listMessages));
    listChannels4.add(Channel(title: "off-topic", messages: listMessages));
    listChannels4.add(Channel(title: "remote-workers", messages: listMessages));
    listChannels4.add(Channel(title: "socials", messages: listMessages));

    listWorkSpaces.add(WorkSpace(
        title: "Minas Dev",
        image: "minasdev.png",
        address: "minasdev.slack.com",
        isSelected: false,
        channels: listChannels4));

    return listWorkSpaces;
  }
}

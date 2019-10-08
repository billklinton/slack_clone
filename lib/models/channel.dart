import 'package:slack_clone/models/message.dart';

class Channel {
  String title;
  List<Message> messages;

  Channel({this.title, this.messages});
}

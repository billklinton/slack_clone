import 'package:slack_clone/models/user.dart';

class Message{
  String text;
  DateTime dateTime;
  User user;

  Message({this.text, this.dateTime, this.user});
}
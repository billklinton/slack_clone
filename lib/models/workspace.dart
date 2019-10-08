import 'package:slack_clone/models/channel.dart';

class WorkSpace{
  String title;
  String address;
  String image;
  bool isSelected;
  List<Channel> channels;

  WorkSpace({this.title, this.address, this.image, this.channels, this.isSelected});
}
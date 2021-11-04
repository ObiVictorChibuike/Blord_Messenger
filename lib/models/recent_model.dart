import 'package:blord/utils/constant.dart';

class Recent {
  final String image;
  final String username;
  final String lastMsg;
  final String time;

  Recent(
      {required this.image,
      required this.username,
      required this.lastMsg,
      required this.time});
}

Recent firstModel = Recent(
    image: ConstanceData.user1,
    username: "Emman Charles",
    lastMsg: "Where are you? I was waiti...",
    time: "7:30 AM");
Recent secondModel = Recent(
    image: ConstanceData.user2,
    username: "Deep Sanker",
    lastMsg: "Haha! You would love to..",
    time: "7:20 AM");
Recent thirdModel = Recent(
    image: ConstanceData.user3,
    username: "Sonali tonwari",
    lastMsg: "See you in CP!",
    time: "7:10 AM");

List<Recent> allRecent = [
  firstModel,
  secondModel,
  thirdModel,
  firstModel,
  thirdModel,
  secondModel
];

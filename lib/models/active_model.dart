import 'package:blord/utils/constant.dart';

class Active {
  final String image;
  final String username;
  final String color;
  final String gmail;

  Active(
      {required this.image,
      required this.username,
      required this.color,
      required this.gmail});
}

Active firstModel = Active(
  image: ConstanceData.character14,
  username: "Jane Afolabi",
  color: "#E7F4FF",
  gmail: "manhhachkt08@gmail.com",
);

Active secondModel = Active(
  image: ConstanceData.character33,
  username: "Jane Afolabi",
  color: "#EEE7FF",
  gmail: "tienlapspktnd@gmail.com",
);

Active thirdModel = Active(
  image: ConstanceData.character46,
  username: "Jane Afolabi",
  color: "#E2FFF7",
  gmail: "trungkienspktnd@gamail.com",
);

Active fourthModel = Active(
  image: ConstanceData.character15,
  username: "Jane Afolabi",
  color: "#FFF8E4",
  gmail: "ckctm12@gmail.com",
);

Active fifthModel = Active(
  image: ConstanceData.character32,
  username: "Jane Afolabi",
  color: "#FFEBE4",
  gmail: "binhan628@gmail.com",
);

List<Active> allActive = [
  firstModel,
  secondModel,
  thirdModel,
  fourthModel,
  fifthModel
];

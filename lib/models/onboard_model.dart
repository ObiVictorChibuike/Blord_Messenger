import 'package:blord/utils/constant.dart';

class Onboard {
  final String image;
  final String text;

  Onboard({required this.image, required this.text});
}

Onboard firstModel = Onboard(
  image: ConstanceData.amico,
  text:
      "A good moment is like a good conversation among friends interacting to each other",
);

Onboard secondModel = Onboard(
  image: ConstanceData.mico,
  text:
      " “Glad to have you here, we look forward to putting a big smile on your face”",
);

Onboard thirdModel = Onboard(
  image: ConstanceData.rafiki,
  text: "One good conversation can shift the direction of change forever",
);

List<Onboard> allOnboard = [firstModel, secondModel, thirdModel];

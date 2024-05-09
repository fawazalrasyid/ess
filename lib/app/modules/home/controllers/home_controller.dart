import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final carouselItem = [
    'https://i.pinimg.com/736x/24/8f/5a/248f5aea7b78a60e2ea49b0187bbc602.jpg',
    'https://img.freepik.com/free-photo/futuristic-buildings-nature_23-2150832571.jpg',
    'https://img.freepik.com/free-photo/view-futuristic-urban-city_23-2150842698.jpg',
  ];

  @override
  void onInit() {
    user = auth.currentUser;
    super.onInit();
  }
}

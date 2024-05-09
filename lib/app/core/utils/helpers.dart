import 'dart:math';
import 'package:intl/intl.dart';

class Helpers {
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(1001);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
  }

  static String formatDateFromString(String dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(DateTime.parse(dateTime));
  }

  static String dayHourFunction(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(1, "0");
    String days = twoDigits(duration.inDays);
    String hours = twoDigits(duration.inHours.remainder(24));
    return "$days Hari $hours Jam";
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String formatGramToKg(int gram) {
    double kg = gram / 1000;
    String formattedKg = kg.toStringAsFixed(1);
    if (formattedKg.endsWith('.0')) {
      formattedKg = formattedKg.replaceAll('.0', '');
    }
    return '$formattedKg Kg';
  }

  static double gramToKg(int gram) {
    return gram / 1000;
  }

  static int kgToGram(double kg) {
    return (kg * 1000).toInt();
  }

  static String generatePhotoUrl(String name) {
    String formattedName = name.replaceAll(' ', '+');
    return 'https://ui-avatars.com/api/?name=$formattedName&uppercase=true&background=random&size=512';
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/configs/constants.dart';
import '../models/prediction_model.dart';

class PredictionService {
  Future<PredictionModel> predictImage(String imagePath) async {
    const url = '${Constants.BASE_URL}/predict';

    debugPrint('url => $url');

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    debugPrint('response => ${response.body}');

    if (response.statusCode == HttpStatus.ok) {
      return PredictionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load prediction');
    }
  }
}

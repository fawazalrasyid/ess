class PredictionModel {
  final String message;
  final String predictedClass;

  PredictionModel({
    required this.message,
    required this.predictedClass,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      message: json['message'],
      predictedClass: json['predictedClass'],
    );
  }
}

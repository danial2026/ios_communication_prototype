class IosCommunicationResponseModel {
  final int randomInt;
  final int timestamp;

  IosCommunicationResponseModel({
    required this.randomInt,
    required this.timestamp,
  });

  factory IosCommunicationResponseModel.fromJson(Map<String, dynamic> json) {
    return IosCommunicationResponseModel(
      randomInt: json['randomInt'] as int,
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'randomInt': randomInt,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
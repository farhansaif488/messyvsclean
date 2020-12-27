import 'package:flutter/rendering.dart';

class Stats {
  int totalPredictTime;
  int totalElapsedTime;
  int inferenceTime;

  int preProcessingTime;

  Stats(
      {this.totalPredictTime,
      this.totalElapsedTime,
      this.inferenceTime,
      this.preProcessingTime});

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, totalElapsedTime: $totalElapsedTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}

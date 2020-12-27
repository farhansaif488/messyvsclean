import 'dart:math';
//import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:cleanmessy/objdetect/ui/camera_view_singleton.dart';

///Represents the recognition output of the model
class Recognition {
  ///Index of the result
  ///
  int _id;

  ///Label of the result
  String _label;

  ///Confidence[0.0,1.0]
  ///
  double _score;

  ///Locationn of the bounding box rect
  ///the rectangle corresponds to the raw input image
  ///passed for inference
  Rect _location;
  Recognition(this._id, this._label, this._score, [this._location]);
  int get id => _id;
  String get label => _label;
  double get score => _score;
  Rect get location => _location;

  Rect get renderLocation {
    double ratioX = CameraViewSingleton.ratio;
    double ratioY = ratioX;

    double transLeft = max(0.1, location.left * ratioX);
    double transTop = max(0.1, location.top * ratioY);
    double transWidth = min(
        location.height * ratioY, CameraViewSingleton.actualPreviewSize.width);
    double transHeight = min(
        location.height * ratioY, CameraViewSingleton.actualPreviewSize.height);
    Rect transformedRect =
        Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score, location: $location)';
  }
}

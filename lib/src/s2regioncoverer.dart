import 'dart:math';

import 'package:s2geometry/s2geometry.dart';
import 'package:s2geometry/src/s2latlngrect.dart';

class S2RegionCoverer {
  final int level;
  final int maxCells;

  S2RegionCoverer({required this.level, required this.maxCells});

  // Returns a list of cell ids that cover the specified region
  List<S2CellId> getCovering(S2LatLngRect region) {
    List<S2CellId> result = [];

    double stepDegree = _calculateSideLengthsInDegrees(level);

    // Placeholder: Calculate covering using S2 algorithms
    // This should interact with the actual S2 library's geometry calculations
    // For the placeholder, we just simulate covering by assuming a grid
    for (double lat = region.lo.lat.degrees;
        lat <= region.hi.lat.degrees;
        lat += stepDegree) {
      for (double lng = region.lo.lng.degrees;
          lng <= region.hi.lng.degrees;
          lng += stepDegree) {
        var cellId =
            S2CellId.fromLatLng(S2LatLng.fromDegrees(lat, lng)).parent(level);
        if (!result.contains(cellId)) {
          result.add(cellId);
          if (result.length >= maxCells) {
            return result;
          }
        }
      }
    }
    return result;
  }

  double _calculateSideLengthsInDegrees(int level) {
    const double earthCircumferenceKm = 40075.0;
    const double kmToDegrees = 360.0 / earthCircumferenceKm;

    double sideLengthKm = earthCircumferenceKm / (4 * pow(2, level));
    double sideLengthDegrees = sideLengthKm * kmToDegrees;
    return sideLengthDegrees / level;
  }
}

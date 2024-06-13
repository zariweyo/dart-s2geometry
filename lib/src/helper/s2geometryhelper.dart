import 'package:s2geometry/s2geometry.dart';
import 'package:s2geometry/src/s2latlngrect.dart';
import 'package:s2geometry/src/s2regioncoverer.dart';

class S2GeometryHelper {
  /// Return all the S2CellId that cover a point
  static List<S2CellId> getCoveringCells(
      {required S2LatLng northEast,
      required S2LatLng southWest,
      required int level,
      required int maxCells}) {
    // Create a rectangle rectangle
    S2LatLngRect region = S2LatLngRect.fromPointPair(northEast, southWest);

    // Create the coverer region for that rectangle
    S2RegionCoverer coverer = S2RegionCoverer(level: level, maxCells: maxCells);

    // Get all the S2CellId that are in that area
    List<S2CellId> coveringCells = coverer.getCovering(region).toList();

    return coveringCells;
  }
}

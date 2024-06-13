import 'package:s2geometry/s2geometry.dart';

class S2LatLngRect {
  final S2LatLng lo; // Corner SW
  final S2LatLng hi; // Corner NE

  S2LatLngRect(this.lo, this.hi);

  // Create a rectangle from points
  S2LatLngRect.fromPointPair(S2LatLng p1, S2LatLng p2)
      : lo = S2LatLng.fromDegrees(min(p1.lat.degrees, p2.lat.degrees),
            min(p1.lng.degrees, p2.lng.degrees)),
        hi = S2LatLng.fromDegrees(max(p1.lat.degrees, p2.lat.degrees),
            max(p1.lng.degrees, p2.lng.degrees));

  // Check if a point exist in the rectangle
  bool contains(S2LatLng point) {
    return point.lat.degrees >= lo.lat.degrees &&
        point.lat.degrees <= hi.lat.degrees &&
        point.lng.degrees >= lo.lng.degrees &&
        point.lng.degrees <= hi.lng.degrees;
  }

  // Check if it is a empty rectangle
  bool isEmpty() {
    return lo.lat > hi.lat || lo.lng > hi.lng;
  }

  // Find the intersect between 2 rectangles
  S2LatLngRect intersection(S2LatLngRect other) {
    S2LatLng newLo = S2LatLng.fromDegrees(
      max(lo.lat.degrees, other.lo.lat.degrees),
      max(lo.lng.degrees, other.lo.lng.degrees),
    );
    S2LatLng newHi = S2LatLng.fromDegrees(
      min(hi.lat.degrees, other.hi.lat.degrees),
      min(hi.lng.degrees, other.hi.lng.degrees),
    );
    if (newLo.lat > newHi.lat || newLo.lng > newHi.lng) {
      return S2LatLngRect(newLo, newLo); // Return an empty rectangle
    }
    return S2LatLngRect(newLo, newHi);
  }

  // Return the String of the rectangle
  @override
  String toString() => 'S2LatLngRect($lo, $hi)';
}

double min(double a, double b) => a < b ? a : b;
double max(double a, double b) => a > b ? a : b;

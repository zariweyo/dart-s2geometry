import 'package:s2geometry/s2geometry.dart';
import 'package:test/test.dart';

void main() {
  group('S2CellId', () {
    test('S2CellId.fromLatLng', () {
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(49.703498679, 11.770681595))
              .id,
          0x47a1cbd595522b39);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(55.685376759, 12.588490937))
              .id,
          0x46525318b63be0f9);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(45.486546517, -93.449700022))
              .id,
          0x52b30b71698e729d);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(58.299984854, 23.049300056))
              .id,
          0x46ed8886cfadda85);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(34.364439040, 108.330699969))
              .id,
          0x3663f18a24cbe857);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-30.694551352, -30.048758753))
              .id,
          0x10a06c0a948cf5d);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-25.285264027, 133.823116966))
              .id,
          0x2b2bfd076787c5df);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-75.000000031, 0.000000133))
              .id,
          0xb09dff882a7809e1);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-24.694439215, -47.537363213))
              .id,
          0x94daa3d000000001);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(38.899730392, -99.901813021))
              .id,
          0x87a1000000000001);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(81.647200334, -55.631712940))
              .id,
          0x4fc76d5000000001);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(10.050986518, 78.293170610))
              .id,
          0x3b00955555555555);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-34.055420593, 18.551140038))
              .id,
          0x1dcc469991555555);
      expect(
          new S2CellId.fromLatLng(
                  new S2LatLng.fromDegrees(-69.219262171, 49.670072392))
              .id,
          0xb112966aaaaaaaab);
    });
    test('S2CellId.parent', () {
      expect(new S2CellId(0x47a1cbd595522b39).parent(),
          new S2CellId(0x47a1cbd595522b39).immediateParent());
      expect(new S2CellId(0x47a1cbd595522b39).parent(29),
          new S2CellId(0x47a1cbd595522b39).immediateParent());
      expect(new S2CellId(0x47a1cbd595522b39).parent(28),
          new S2CellId(0x47a1cbd595522b39).immediateParent().immediateParent());
      expect(
          new S2CellId(0x47a1cbd595522b39).parent(28).id, 0x47a1cbd595522b30);
      expect(new S2CellId(0x47a1cbd595522b39).parent(13).level, 13);
    });
    test('S2CellId.operator', () {
      expect(
          new S2CellId(0xf7a1cbd595522b39) > new S2CellId(0x07a1cbd595522b39),
          isTrue);
      expect(
          new S2CellId(0xf7a1cbd595522b39) > new S2CellId(0xe7a1cbd595522b39),
          isTrue);
      expect(
          new S2CellId(0x17a1cbd595522b39) > new S2CellId(0x07a1cbd595522b39),
          isTrue);
      expect(
          new S2CellId(0xf7a1cbd595522b39) < new S2CellId(0x07a1cbd595522b39),
          isFalse);
      expect(
          new S2CellId(0xf7a1cbd595522b39) < new S2CellId(0xe7a1cbd595522b39),
          isFalse);
      expect(
          new S2CellId(0x17a1cbd595522b39) < new S2CellId(0x07a1cbd595522b39),
          isFalse);
    });
    test('S2CellId.toToken', () {
      expect(new S2CellId(0x47a1cbd595522b39).toToken(), "47a1cbd595522b39");
      expect(new S2CellId(0x47a1cbd595522b39).parent(29).toToken(),
          "47a1cbd595522b3c");
      expect(new S2CellId(0x47a1cbd595522b39).parent(28).toToken(),
          "47a1cbd595522b3");
    });

    test('S2CellId.fromToken', () {
      expect(new S2CellId.fromToken("47a1cbd595522b39").id, 0x47a1cbd595522b39);
      expect(new S2CellId.fromToken("47a1cbd595522b3c").level, 29);
    });

    test('S2CellId.getCoveringCells 1', () {
      S2LatLng northEast = S2LatLng.fromDegrees(34.364439040, 108.330699969);
      S2LatLng southWest = S2LatLng.fromDegrees(34.364439040, 108.330699969);
      List<S2CellId> s2CellIds = S2GeometryHelper.getCoveringCells(
          northEast: northEast, southWest: southWest, level: 10, maxCells: 20);

      expect(s2CellIds.length == 1, true);
      expect(S2CellId.fromLatLng(northEast).parent(10).toToken(),
          s2CellIds.first.toToken());
    });

    test('S2CellId.getCoveringCells 2', () {
      List<String> expectedData = [
        '0d12654',
        '0d1265c',
        '0d12664',
        '0d1268c',
        '0d12694',
        '0d126bc',
        '0d126c4',
        '0d126dc',
        '0d126e4',
        '0d126ec',
        '0d126f4',
        '0d126fc'
      ]..sort((a, b) => a.compareTo(b));
      S2LatLng northEast = S2LatLng.fromDegrees(37.437379, -5.889369);
      S2LatLng southWest = S2LatLng.fromDegrees(37.338768, -6.021377);
      List<S2CellId> s2CellIds = S2GeometryHelper.getCoveringCells(
          northEast: northEast, southWest: southWest, level: 11, maxCells: 20);

      expect(s2CellIds.length, expectedData.length);
      expect(
          expectedData.join(","),
          (s2CellIds.map((e) => e.toToken()).toList()
                ..sort((a, b) => a.compareTo(b)))
              .join(","));
    });

    test('S2CellId.getCoveringCells 3', () {
      List<String> expectedData = [
        '0d12655d',
        '0d12655f',
        '0d126561',
        '0d126563',
        '0d126565',
        '0d126567',
        '0d126579',
        '0d12657b',
        '0d12657d',
        '0d12657f',
        '0d126581',
        '0d126583',
        '0d126585',
        '0d126587',
        '0d126589',
        '0d12658b',
        '0d12658d',
        '0d12658f',
        '0d1265f1',
        '0d1265f3',
        '0d1265f5',
        '0d1265f7',
        '0d1265f9'
      ];
      S2LatLng northEast = S2LatLng.fromDegrees(37.437379, -5.889369);
      S2LatLng southWest = S2LatLng.fromDegrees(37.338768, -6.021377);
      List<S2CellId> s2CellIds = S2GeometryHelper.getCoveringCells(
          northEast: northEast,
          southWest: southWest,
          level: 14,
          maxCells: 1000);

      expect(s2CellIds.length, 505);
      expect(
          s2CellIds.map((e) => e.toToken()).toList().contains(expectedData[0]),
          true);
    });
  });
}

import 'dart:ui';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = false}) =>
      '${leadingHashSign ? '#' : ''}'
      // '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension ListColorConverter on List<Color> {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static List<Color> fromStringColors(List<String> colorsString) {
    List<Color> converted = [];
    for (var item in colorsString) {
      converted.add(HexColor.fromHex(item));
    }
    return converted;
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  List<String> toStringList() {
    List<String> converted = [];
    forEach((item) {
      String value = '';
      value = item.toHex().replaceFirst('Color(', '');
      value = value.toString().replaceFirst('Color', '');
      value = value.replaceFirst(')', '');
      value = value.replaceFirst('(', '');
      if (value.contains("0xff")) {
        value = value.replaceFirst('0xff', '');
      } else if (value.length > 7) {
        value = value.substring(4, value.length);
      }
      converted.add(value);
    });
    return converted;
  }
}

///Colors

extension ColorExtensions on Color {
  /// Converts a [Color] to a `Map<String, double>`.
  Map<String, double> toMap() {
    return {
      "red": r,
      "green": g,
      "blue": b,
      "alpha": a,
    };
  }
}

extension MapToColorExtension on Map<Object?, Object?> {
  /// Converts a `Map<String, double>` to a [Color], clamping to valid range.
  Color toColor({bool clampValues = true}) {
    double getComponent(String key) => (this[key] as double?) ?? 0.0;

    double clamp(double value) => value.clamp(0.0, 1.0);

    final red = getComponent("red");
    final green = getComponent("green");
    final blue = getComponent("blue");
    final alpha = getComponent("alpha");

    return Color.from(
      red: clampValues ? clamp(red) : red,
      green: clampValues ? clamp(green) : green,
      blue: clampValues ? clamp(blue) : blue,
      alpha: clampValues ? clamp(alpha) : alpha,
    );
  }
}

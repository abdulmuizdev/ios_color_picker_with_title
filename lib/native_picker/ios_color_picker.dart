import 'dart:async';
import 'dart:ui';
import 'package:ios_color_picker_with_title/custom_picker/extensions.dart';
import 'ios_color_picker_platform_interface.dart';

class NativeIosColorPicker {
  Future<Color?> getPlatformColor(Color? defaultColor, bool? darkMode, String? title) {
    return IosColorPickerPlatform.instance
        .getPlatformColor(defaultColor?.toMap(), darkMode, title);
  }
}

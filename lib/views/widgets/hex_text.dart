import 'package:flutter/material.dart';

export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

export 'package:another_flushbar/flushbar.dart';
export 'package:audioplayers/audioplayers.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:camera/camera.dart';
export 'package:file_picker/file_picker.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart' hide DatePickerTheme;
export 'package:flutter/services.dart';
export 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:global_configuration/global_configuration.dart';
export 'package:hexcelon/views/auth/auth_scaffold.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:keyboard_attachable/keyboard_attachable.dart';
export 'package:pinput/pinput.dart';
export 'package:provider/provider.dart';
export 'package:record/record.dart';
export 'package:share_plus/share_plus.dart';
export 'package:url_launcher/url_launcher_string.dart';

export 'base_view.dart';
export 'colors.dart';
export 'hex_button.dart';
export 'hex_dialog.dart';
export 'hex_field.dart';
export 'hex_pin_field.dart';
export 'hex_progress.dart';
export 'money_masked_text.dart';
export 'remove_glow.dart';
export 'snackbar.dart';
export 'utils.dart';

class HexText extends StatelessWidget {
  const HexText(
    this.text, {
    Key? key,
    this.color,
    this.letterSpacing,
    this.height,
    this.align,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fontWeight,
    this.blur = false,
    this.fontSize = 14,
    this.fontFamily,
    this.fontStyle,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final double? letterSpacing;
  final double? height;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
      style: TextStyle(
        fontFamily: 'Nova',
        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        height: height,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}

class HardDataHolder {
  String id;
  String name;
  String desc;
  Widget? goto;
  List<String>? params;

  HardDataHolder(this.name, this.desc, this.id, {this.goto, this.params});
}

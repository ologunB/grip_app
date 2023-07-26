import 'package:google_fonts/google_fonts.dart';

import 'hex_text.dart';

class HexField extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
  final String? hintText;
  final String? title;
  final String? obscuringCharacter;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool? enabled;
  final bool enableCopy;
  final bool obscureText;
  final bool? autoFocus;
  final Color? hintColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? color;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const HexField({
    super.key,
    this.prefix,
    this.suffix,
    this.validator,
    this.labelText,
    this.textInputAction,
    this.textInputType,
    this.textAlign,
    this.onChanged,
    this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLines,
    this.onTap,
    this.autoFocus = false,
    this.focusNode,
    this.maxLength,
    this.title,
    this.enabled,
    this.inputFormatters,
    this.hintColor,
    this.enableCopy = true,
    this.hintText,
    this.color,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.only(top: 13.h, bottom: 7.h),
            child: HexText(
              labelText!,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: color ?? AppColors.black,
            ),
          ),
        CupertinoTextField(
          prefix: prefix,
          suffix: suffix,
          enableInteractiveSelection: enableCopy,
          cursorColor: AppColors.black,
          cursorWidth: 1.h,
          focusNode: focusNode,
          maxLines: obscureText ? 1 : maxLines,
          autofocus: autoFocus!,
          enabled: enabled ?? true,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          style: GoogleFonts.nunito(
            color: AppColors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          readOnly: readOnly,
          placeholder: hintText,
          placeholderStyle: GoogleFonts.nunito(
            color: hintColor ?? const Color(0xFF9E9E9E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 12.h),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.h, color: borderColor ?? const Color(0xffE0E0E0)),
            borderRadius: BorderRadius.circular(20.h),
            //  color: Colors.white,
          ),
          onTap: onTap,
          obscureText: obscureText,
          obscuringCharacter: '●',
          controller: controller,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: textInputType,
          onChanged: onChanged,
        )
      ],
    );
  }
}

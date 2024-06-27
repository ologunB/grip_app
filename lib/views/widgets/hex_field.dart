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
  final Widget? suffixIcon;
  const HexField({
    super.key,
    this.prefix,
    this.suffix,
    this.suffixIcon,
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
    InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.h,
        color: borderColor ?? context.textColor,
      ),
      borderRadius: BorderRadius.circular(10.h),
    );

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
              fontWeight: FontWeight.w600,
              color: color ?? context.primary,
            ),
          ),
        TextFormField(
          enableInteractiveSelection: enableCopy,
          cursorColor: AppColors.black,
          cursorWidth: 1.h,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.sentences,
          maxLines: obscureText ? 1 : maxLines,
          autofocus: autoFocus!,
          enabled: enabled ?? true,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          style: GoogleFonts.inter(
            color: context.textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          readOnly: readOnly,
          decoration: InputDecoration(
            counterStyle: const TextStyle(fontSize: 0),
            prefix: SizedBox(width: 16.h),
            contentPadding:
                EdgeInsets.symmetric(vertical: maxLines != null ? 10.h : 0.h),
            suffix: suffix,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: hintColor ?? AppColors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            border: border,
            errorBorder: border,
            enabledBorder: border,
            focusedBorder: border,
            focusedErrorBorder: border,
            disabledBorder: border,
          ),
          onTap: onTap,
          obscureText: obscureText,
          obscuringCharacter: '•',
          controller: controller,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: textInputType,
          onChanged: onChanged,
          validator: validator,
        )
      ],
    );
  }
}

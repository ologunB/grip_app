import 'hex_text.dart';

Future<dynamic> push(BuildContext context, Widget page,
    [bool dialog = false]) async {
  FocusScope.of(context).unfocus();
  return await Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => page, fullscreenDialog: dialog),
  );
}

void pushReplacement(BuildContext context, Widget page) {
  FocusScope.of(context).unfocus();
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(builder: (context) => page),
  );
}

void pushAndRemoveUntil(BuildContext context, Widget page) {
  FocusScope.of(context).unfocus();
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(builder: (context) => page),
    (Route<dynamic> route) => false,
  );
}

class Utils {
  static void offKeyboard() async {
    await SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
  }

  static Future<DateTime?> chooseDate(BuildContext context,
      [DateTime? start]) async {
    Utils.offKeyboard();
    DateTime? a = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1910, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        return date;
      },
      currentTime: start ?? DateTime.now(),
    );
    return a;
  }

  static String? isValidPassword(String? value) {
    value = value!.trim();
    if (value.trim().isEmpty) {
      return "Password cannot be Empty";
    } else if (value.trim().length < 8) {
      return "Password is too short";
    } /* else if (!value.trim().contains(RegExp(r'\d'))) {
      return "Password must contain a number";
    } else if (!value.trim().contains(RegExp(r'[a-z]'))) {
      return "Password must contain a lowercase letter";
    } else if (!value.trim().contains(RegExp(r'[A-Z]'))) {
      return "Password must contain a uppercase letter";
    } else if (!value.trim().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain a special character";
    }*/
    return null;
  }

  static String? isValidName(String? value,
      {String type = "Name", int length = 2}) {
    if (value!.isEmpty) {
      return '$type cannot be Empty';
    } else if (value.length < length) {
      return '$type is too short';
    } else if (value.length > 100) {
      return '$type max length is 100';
    }
    return null;
  }

  static String? isValidEmail(String? value) {
    value = value!.trim();
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
}

extension CustomStringExtension on String {
  toTitleCase() {
    final words = toString().toLowerCase().split(' ');
    var newWord = '';
    for (var word in words) {
      if (word.isNotEmpty) {
        newWord += '${word[0].toUpperCase()}${word.substring(1)} ';
      }
    }

    return newWord;
  }

  toAmount() {
    return NumberFormat("#,##0.00", "en_US")
        .format(double.tryParse(this) ?? 0.00);
  }

  get png {
    return 'assets/images/$this.png';
  }

  getSingleInitial() {
    return split('')[0].toUpperCase();
  }

  sanitizeToDouble() {
    return double.tryParse(replaceAll(",", ""));
  }
}

class PhoneNumFormatter extends TextInputFormatter {
  PhoneNumFormatter(this.code) : super();
  final String code;
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    String newVal = newValue.text;
    if ('+'.allMatches(newVal).length > 1) return oldValue;
    if (!newVal.startsWith(code)) return oldValue;
    List<String> a = newVal.split('');
    if (a.any((e) => !e.contains(RegExp(r'[0-9]')) && e != ' ' && e != '+')) {
      return oldValue;
    }
    if (code.length + 2 > newVal.length) {
      return oldValue;
    }
    return newValue;
  }
}

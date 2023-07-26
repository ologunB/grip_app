class Country {
  String? name;
  String? dialCode;
  String? code;

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dialCode = json['dial_code'];
    code = json['code'];
  }
}

class CurrencyName {
  String? entity;
  String? currency;
  String? code;
  String? numericCode;
  String? minorUnit;
  String? withdrawalDate;

  CurrencyName.fromJson(Map<String, dynamic> json) {
    entity = json['Entity'];
    currency = json['Currency'];
    code = json['AlphabeticCode'];
    numericCode = json['NumericCode']?.toString();
    minorUnit = json['MinorUnit'];
    withdrawalDate = json['WithdrawalDate'];
  }
}

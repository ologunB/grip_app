class BankModel {
  String? bankName;
  String? bankCode;
  BankModel({this.bankName, this.bankCode});
  BankModel.fromJson(dynamic json) {
    bankName = json['bankName'];
    bankCode = json['bankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankName'] = bankName;
    data['bankCode'] = bankCode;
    return data;
  }
}

class BeneficiaryModel {
  String? bankName;
  String? bankCode;
  String? bankAccountName;
  String? bankAccountNumber;
  String? id;
  String? userId;

  BeneficiaryModel.fromJson(dynamic json) {
    bankName = json['bankName'];
    bankCode = json['bankCode'];
    bankAccountName = json['accountName'];
    bankAccountNumber = json['accountNumber'];
    id = json['id'];
    userId = json['userId'];
  }
}

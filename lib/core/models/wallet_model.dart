class WalletModel {
  String? walletId;
  String? userId;
  String? userName;
  String? availableBalance;
  String? ledgerBalance;
  String? lastCreditDate;
  String? lastDebitDate;
  String? currency;
  String? currencySymbol;
  String? walletType;
  String? walletSubType;
  String? accountNumber;
  String? accountName;
  int? accountTier;
  String? country;
  String? totalDailyTransaction;
  String? bankName = 'Providus Bank';

  WalletModel.fromJson(Map<String, dynamic> json) {
    country = json['currency']?.substring(0, 2);

    walletId = json['walletId'];
    userId = json['userId'];
    userName = json['userName'];
    availableBalance = json['availableBalance'];
    ledgerBalance = json['ledgerBalance'];
    lastCreditDate = json['lastCreditDate'];
    lastDebitDate = json['lastDebitDate'];
    currency = json['currency'];
    currencySymbol = json['currencySymbol'];
    walletType = json['walletType'];
    walletSubType = json['walletSubType'];
    accountNumber = json['accounNumber'];
    accountName = json['accountName'];
    accountTier = json['accountTier'];
    totalDailyTransaction = json['totalDailyTransaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletId'] = walletId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['availableBalance'] = availableBalance;
    data['ledgerBalance'] = ledgerBalance;
    data['lastCreditDate'] = lastCreditDate;
    data['lastDebitDate'] = lastDebitDate;
    data['currency'] = currency;
    data['currencySymbol'] = currencySymbol;
    data['walletType'] = walletType;
    data['walletSubType'] = walletSubType;
    data['accounNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['accountTier'] = accountTier;
    data['totalDailyTransaction'] = totalDailyTransaction;
    return data;
  }
}

class ResolvedZoperWalletModel {
  String? id;
  String? userId;
  String? virtualAccountName;
  String? virtualAccountNumber;
  String? virtualAccountProvider;
  String? virtualAccountProviderCode;
  String? currency;
  bool? active;

  ResolvedZoperWalletModel({
    this.id,
    this.userId,
    this.virtualAccountName,
    this.virtualAccountNumber,
    this.virtualAccountProvider,
    this.currency,
    this.active,
    this.virtualAccountProviderCode,
  });

  ResolvedZoperWalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    virtualAccountName = json['virtualAccountName'];
    virtualAccountNumber = json['virtualAccountNumber'];
    virtualAccountProvider = json['virtualAccountProvider'];
    virtualAccountProviderCode = json['virtualAccountProviderCode'];
    currency = json['currency'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['virtualAccountName'] = virtualAccountName;
    data['virtualAccountNumber'] = virtualAccountNumber;
    data['virtualAccountProvider'] = virtualAccountProvider;
    data['virtualAccountProviderCode'] = virtualAccountProviderCode;
    data['currency'] = currency;
    data['active'] = active;
    return data;
  }
}

class ResolvedLocalWalletModel {
  String? bankCode;
  String? bankName;
  String? accountName;
  String? accountNumber;
  ResolvedLocalWalletModel({
    this.bankCode,
    this.accountName,
    this.accountNumber,
    this.bankName,
  });
  ResolvedLocalWalletModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    bankCode = json['bankCode'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankName'] = bankName;
    data['bankCode'] = bankCode;
    data['accountName'] = accountName;
    data['accountNumber'] = accountNumber;
    return data;
  }
}

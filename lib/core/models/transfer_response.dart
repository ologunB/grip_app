class TransferResponse {
  Transaction? transaction;

  TransferResponse({transaction});

  TransferResponse.fromJson(dynamic json) {
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    return data;
  }
}

class Transaction {
  Author? author;
  Source? source;
  Source? beneficiary;
  String? amount;
  String? settledAmount;
  String? feeAmount;
  String? narration;
  String? description;
  String? transactionRef;
  String? status;
  String? transactionCategory;
  String? transactionType;
  String? transferType;
  String? currency;
  String? transactionDate;
  String? transactionSignature;
  String? id;

  Transaction(
      {author,
      source,
      beneficiary,
      amount,
      settledAmount,
      feeAmount,
      narration,
      description,
      transactionRef,
      status,
      transactionCategory,
      transactionType,
      transferType,
      currency,
      transactionDate,
      transactionSignature,
      id});

  Transaction.fromJson(dynamic json) {
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    beneficiary = json['beneficiary'] != null
        ? Source.fromJson(json['beneficiary'])
        : null;
    amount = json['amount'];
    settledAmount = json['settledAmount'];
    feeAmount = json['feeAmount'];
    narration = json['narration'];
    description = json['description'];
    transactionRef = json['transactionRef'];
    status = json['status'];
    transactionCategory = json['transactionCategory'];
    transactionType = json['transactionType'];
    transferType = json['transferType'];
    currency = json['currency'];
    transactionDate = json['transactionDate'];
    transactionSignature = json['transactionSignature'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (source != null) {
      data['source'] = source!.toJson();
    }
    if (beneficiary != null) {
      data['beneficiary'] = beneficiary!.toJson();
    }
    data['amount'] = amount;
    data['settledAmount'] = settledAmount;
    data['feeAmount'] = feeAmount;
    data['narration'] = narration;
    data['description'] = description;
    data['transactionRef'] = transactionRef;
    data['status'] = status;
    data['transactionCategory'] = transactionCategory;
    data['transactionType'] = transactionType;
    data['transferType'] = transferType;
    data['currency'] = currency;
    data['transactionDate'] = transactionDate;
    data['transactionSignature'] = transactionSignature;
    data['id'] = id;
    return data;
  }
}

class Author {
  String? id;
  String? name;
  String? email;
  String? mobile;

  Author({id, name, email, mobile});

  Author.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}

class Source {
  String? accountName;
  String? accountNo;
  String? bankName;
  String? bankCode;

  Source.fromJson(dynamic json) {
    accountName = json['accountName'];
    accountNo = json['accountNo'];
    bankName = json['bankName'] ?? 'Providus Bank';
    bankCode = json['bankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountName'] = accountName;
    data['accountNo'] = accountNo;
    data['bankName'] = bankName;
    data['bankCode'] = bankCode;
    return data;
  }
}

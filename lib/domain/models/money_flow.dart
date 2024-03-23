class MoneyFlow {
  int? moneyFlowId;
  int flowType;
  double amount;
  int quantity;
  int productId;
  String? productName;
  DateTime date;
  MoneyFlow({
    this.productName,
    this.moneyFlowId,
    required this.amount,
    required this.quantity,
    required this.productId,
    required this.flowType,
    required this.date
  });

  Map<String, dynamic> toMap() {
    return {
      "quantity": quantity,
      "productId": productId,
      "amount": amount,
      "flowType": flowType,
      "date": date.millisecondsSinceEpoch
    };
  }

  static MoneyFlow toObject(Map<dynamic, dynamic> map) {
    return MoneyFlow(
        moneyFlowId: map["moneyFlowId"],
        productName: map["productName"],
        amount: map["amount"],
        quantity: map["quantity"],
        productId: map["productId"],
        flowType: map["flowType"],
        date: DateTime.fromMillisecondsSinceEpoch(map["date"]));

  }
}

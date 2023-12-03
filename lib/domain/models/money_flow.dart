class MoneyFlow {
  int? moneyFlowId;
  int flowType;
  double amount;
  int quantity;
  int productId;
  String? productName;

  MoneyFlow({
    this.productName,
    this.moneyFlowId,
    required this.amount,
    required this.quantity,
    required this.productId,
    required this.flowType,
  });

  Map<String, dynamic> toMap() {
    return {
      "quantity": quantity,
      "productId": productId,
      "amount": amount,
      "flowType": flowType
    };
  }

  static MoneyFlow toObject(Map<dynamic, dynamic> map) {
    return MoneyFlow(
        moneyFlowId: map["moneyFlowId"],
        productName: map["productName"],
        amount: map["amount"],
        quantity: map["quantity"],
        productId: map["productId"],
        flowType: map["flowType"]);
  }
}

import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:inventory_control/domain/interfaces/imoney_flow_model.dart';
import 'package:inventory_control/domain/models/money_flow.dart';

class MoneyFlowProvider extends ChangeNotifier with MessageNotifierMixin {
  List<MoneyFlow>? moneyFlows;
  IMoneyFlowModel iMoneyFlowModel;

  MoneyFlowProvider({required this.iMoneyFlowModel});

  Future<void> create(MoneyFlow t) async {
    try {
      int moneyFlowId = await iMoneyFlowModel.create(t);
      t.moneyFlowId = moneyFlowId;
      moneyFlows?.add(t);
      notifyListeners();
    } catch (e) {
      notifyError(e);
    }
  }

  Future<List<MoneyFlow>?> read() async {
    try {
      if (moneyFlows == null) {
        moneyFlows = await iMoneyFlowModel.read();
        notifyListeners();
      }
      return moneyFlows;
    } catch (e) {
      notifyError(e);
      return [];
    }
  }
}

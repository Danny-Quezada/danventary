import 'package:inventory_control/domain/db/inventory_db.dart';
import 'package:inventory_control/domain/interfaces/imoney_flow_model.dart';
import 'package:inventory_control/domain/models/money_flow.dart';

class MoneyFlowRepository implements IMoneyFlowModel {
  @override
  Future<int> create(MoneyFlow t) async {
    var db = await InventoryDB.instace.database;
    int moneyFlowId = 0;

    try {
      await db.transaction((txn) async {
        moneyFlowId = await txn.insert("MoneyFlow", t.toMap());
      });
      return moneyFlowId;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> delete(MoneyFlow t) async {
   throw Exception();
  }

  @override
  Future<List<MoneyFlow>> read() async {
    List<MoneyFlow> moneyFlows = [];
    var db = await InventoryDB.instace.database;
    try {
      List<Map> result = await db.rawQuery(
          "Select MoneyFlow.productId, MoneyFlow.flowType, MoneyFlow.amount, MoneyFlow.moneyFlowId,MoneyFlow.quantity, Product.productName from MoneyFlow inner join Product on Product.productId=MoneyFlow.productId");
      result.forEach((element) async {
        MoneyFlow moneyFlow = MoneyFlow.toObject(element);

        moneyFlows.add(moneyFlow);
      });
      return moneyFlows;
    } catch (e) {
      throw Exception("Ocurrió un error a la hora de buscar los flujos de dinero.");
    }
  }

  @override
  Future<String> update(MoneyFlow t) async {
    throw Exception("");
  }
}

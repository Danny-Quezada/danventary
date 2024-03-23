import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/money_flow.dart';
import 'package:inventory_control/provider/money_flow_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MoneyFlowProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: mounted
          ? Consumer<MoneyFlowProvider>(
              builder: (context, value, child) {
                if (value.moneyFlows == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (value.moneyFlows!.isEmpty) {
                    return Center(
                        child: EmptyModelWidget(model: "Ventas o compras"));
                  }
                  List<MoneyFlow> moneyflows = value.moneyFlows!;
                  List<MoneyFlow> purchases = moneyflows
                      .where((element) => element.flowType == 0)
                      .toList();
                  List<MoneyFlow> sales = moneyflows
                      .where((element) => element.flowType == 1)
                      .toList();
                  double sumPurchase = purchases.fold(
                    0,
                    (previousValue, element) =>
                        (element.amount * element.quantity) + previousValue,
                  );
                   double sumSale = sales.fold(
                    0,
                    (previousValue, element) =>
                        (element.amount * element.quantity) + previousValue,
                  );
                  double earnings=sumSale-sumPurchase;
                  return ListView(
                    padding:
                        const EdgeInsets.only(top: 25, right: 10, left: 10),
                    children: [
                      Row(
                      children: [
                        const SizedBox(width: 10,),
                        Text(
                          "Acerca del dinero",
                          style: Style.titleStyle,
                        ),
                        const SizedBox(width: 5,),
                        const Icon(
                          CupertinoIcons.money_dollar,
                          size: 30,
                          color: Colors.green,
                        )
                      ]),
                      const SizedBox(height: 10,),
                       Card(

                        child: ListTile(
                          leading: Icon(
                            earnings>0 ? Icons.arrow_circle_up_sharp : CupertinoIcons.exclamationmark_triangle,
                            color: earnings>0? Style.purchaseColor: Colors.red,
                          ),
                          title:  Text("Ganancias: ",style: Style.h1GreyStyle,),
                          trailing: Text(
                            "$earnings",
                            style:  TextStyle(color: earnings>0 ? Colors.green: Colors.red,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                      children: [
                        const SizedBox(width: 10,),
                        Text(
                          "Flujo de dinero",
                          style: Style.titleStyle,
                        ),
                        const SizedBox(width: 5,),
                        const Icon(
                          Icons.money,
                          size: 30,
                          color: Colors.green,
                        )
                      ]),
                      const SizedBox(height: 10),
                      Card(

                        child: ListTile(
                          leading: Icon(
                            Icons.add_shopping_cart,
                            color: Style.purchaseColor,
                          ),
                          title:  Text("Compras: ",style: Style.h1GreyStyle,),
                          trailing: Text(
                            "-$sumPurchase",
                            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                        Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.monetization_on_rounded,
                            color: Style.saleColor,
                          ),
                          title:  Text("Ventas: ",style: Style.h1GreyStyle,),
                          trailing: Text(
                            "$sumSale",
                            style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          : null,
    );
  }
}

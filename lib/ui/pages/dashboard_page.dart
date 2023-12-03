import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/money_flow.dart';
import 'package:inventory_control/provider/money_flow_provider.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MoneyFlowProvider>(context,listen: false).read();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<MoneyFlowProvider>(builder: (context, value, child) {
        if (value.moneyFlows == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.moneyFlows!.isEmpty) {
            return Center(child: EmptyModelWidget(model: "Ventas o compras"));
          }
          List<MoneyFlow> moneyflows = value.moneyFlows!;
          return ListView(
            children: [

            ],
          );
        }
      },),
    );
  }
}
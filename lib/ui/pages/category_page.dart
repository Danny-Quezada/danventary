import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product_category.dart';
import 'package:inventory_control/provider/category_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/utils/validator_textfield.dart';
import 'package:inventory_control/ui/widgets/button_widget.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:inventory_control/ui/widgets/custom_form_field.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:inventory_control/ui/widgets/search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

TextEditingController categoryController = TextEditingController();
ProductCategory? productCategory;
ScrollController listViewController = ScrollController();

class CategoryPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: searchBar(
              function: (value) {
                categoryProvider.changeFind(value);
              },
              controller: searchController,
              height: 35,
              padding: 0,
              iconColor: const Color(0xffABA5A5),
              backgroundColor: const Color(0xFFf2f2f2)),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "FABProductCategory",
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                content: CategoryForm(),
              ),
            );
            categoryController.text = "";
          },
          backgroundColor: Style.categoryColor,
          child: const Icon(CupertinoIcons.add),
        ),
        body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CategoriesList()),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.read();
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        if (value.categories == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.categories!.isEmpty) {
            return Center(child: EmptyModelWidget(model: "Categorías"));
          }
          List<ProductCategory> productsCategories = value.categories!
              .where((element) =>
                  element.categoryName.toLowerCase().contains(value.findName))
              .toList();

          return ListView.builder(
            itemCount: productsCategories.length,
            itemBuilder: (context, index) {
              CardWidget cardWidget = createProductWidget(context,
                  productsCategories[(productsCategories.length - 1) - index]);
              return cardWidget;
            },
          );
        }
      },
    );
  }

  CardWidget createProductWidget(
      BuildContext context, ProductCategory productCategoryIndex) {
    CardWidget cardWidget = CardWidget(
        function: () async {
          productCategory = productCategoryIndex;
          categoryController.text = productCategory!.categoryName;
          await showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              content: CategoryForm(),
            ),
          );
          categoryController.text = "";
          productCategory = null;
        },
        title: productCategoryIndex.categoryName);

    return cardWidget;
  }
}

class CategoryForm extends StatelessWidget {
  CategoryForm();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormField(
              textEditingController: categoryController,
              validator: ValidatorTextField.genericStringValidator,
              nextFocusNode: null,
              focusNode: null,
              labelText: "Nombre de categoría",
              hintText: "Pantalones 👖",
              obscureText: false),
          ButtonWidget(
              text: "Guardar categoría",
              size: const Size(200, 30),
              color: Style.categoryColor,
              rounded: 20,
              function: () async {
                final FormState form = _formKey.currentState!;
                if (form.validate()) {
                  if (productCategory != null) {
                    productCategory!.categoryName = categoryController.text;
                    categoryProvider.update(productCategory!);
                  } else {
                    categoryProvider.createCategory(
                        ProductCategory(categoryName: categoryController.text));
                  }
                  Navigator.pop(context);
                }
              },
              fontSize: 15)
        ],
      ),
    );
  }
}

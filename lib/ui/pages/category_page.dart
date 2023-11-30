import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_control/domain/models/product_category.dart';
import 'package:inventory_control/provider/category_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/utils/validator_textfield.dart';
import 'package:inventory_control/ui/widgets/button_widget.dart';
import 'package:inventory_control/ui/widgets/card_widget.dart';
import 'package:inventory_control/ui/widgets/custom_form_field.dart';
import 'package:inventory_control/ui/widgets/search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
  TextEditingController categoryController = TextEditingController();
    ProductCategory? productCategory;

class CategoryPage extends StatelessWidget {


  TextEditingController searchController = TextEditingController();
  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: searchBar(
              function: (value) {},
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: categoryProvider.read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  List<ProductCategory> productsCategories = snapshot.data!;
                  if (productsCategories.isEmpty) {
                    return const Center(
                      child: EmptyProductWidget(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: productsCategories.length,
                    itemBuilder: (context, index) {
                      CardWidget cardWidget = createProductWidget(
                          context, productsCategories[index]);
                      return cardWidget;
                    },
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    color: Colors.black,
                    width: 10,
                    height: 20,
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  CardWidget createProductWidget(
      BuildContext context, ProductCategory productCategoryIndex) {
    CardWidget cardWidget = CardWidget(
        function: () async{
          productCategory=productCategoryIndex;
          categoryController.text=productCategory!.categoryName;
           await showDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                content: CategoryForm(),
              ),
            );
            categoryController.text = "";
            productCategory=null;
        },
        title: productCategoryIndex.categoryName);

    return cardWidget;
  }
}

class CategoryForm extends StatelessWidget {
   CategoryForm({
    super.key,
  }) ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final categoryProvider=Provider.of<CategoryProvider>(context,listen: false);
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
                  if(productCategory!=null){
                    productCategory!.categoryName =categoryController.text;
                    categoryProvider.update(productCategory!);
                   

                  }
                  else{
                  categoryProvider.createCategory(ProductCategory(
                      categoryName: categoryController.text));
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

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/sadBoy.png",
          width: size.width * .64,
          height: size.height * .3,
        ),
        SizedBox(
            child: Text(
          "No hay productos por el momento, agrega productos.",
          style: Style.h2RedStyle,
        ))
      ],
    );
  }
}

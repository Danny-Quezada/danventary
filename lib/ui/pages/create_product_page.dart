import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:inventory_control/domain/models/money_flow.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/domain/models/product_category.dart';
import 'package:inventory_control/domain/models/product_image.dart';
import 'package:inventory_control/provider/category_provider.dart';
import 'package:inventory_control/provider/money_flow_provider.dart';
import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/utils/validator_textfield.dart';
import 'package:inventory_control/ui/widgets/button_widget.dart';
import 'package:inventory_control/ui/widgets/custom_form_field.dart';
import 'package:inventory_control/ui/widgets/empty_model_widget.dart';
import 'package:inventory_control/ui/widgets/flushbar_widget.dart';
import 'package:inventory_control/ui/widgets/text_button_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class CreateProductPage extends StatefulWidget {
  Product? product;
  List<String>? images;
  CreateProductPage({this.product, this.images});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillControllers(context);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double price = 1;
  int quantity = 1;
  double salePrice = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final moneyFlowProvider =
        Provider.of<MoneyFlowProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            widget.product == null ? "Crear producto" : "Actualizar producto"),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ProductImageWidget(),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                  textEditingController: nameController,
                  validator: ValidatorTextField.userNameValidator,
                  nextFocusNode: descriptionFocus,
                  focusNode: nameFocus,
                  hintText: "Nombre del producto",
                  labelText: "Nombre",
                  obscureText: false),
              const SizedBox(
                height: 32,
              ),
              CustomFormField(
                  textInput: TextInputType.multiline,
                  textEditingController: descriptionController,
                  validator: ValidatorTextField.genericStringValidator,
                  nextFocusNode: null,
                  focusNode: descriptionFocus,
                  hintText: "Descripción del producto",
                  labelText: "Descripción del producto",
                  obscureText: false),
              const SizedBox(
                height: 26,
              ),
              Text(
                "Precio de compra: ",
                style: Style.textInput,
              ),
              const SizedBox(
                height: 15,
              ),
              InputQty.double(
                initVal: widget.product?.price ?? 1,
                minVal: 1,
                decoration: const QtyDecorationProps(
                    width: 20, border: InputBorder.none),
                onQtyChanged: (val) {
                  price = val;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Precio de venta: ",
                style: Style.textInput,
              ),
              const SizedBox(
                height: 15,
              ),
              InputQty.double(
                initVal: widget.product?.salePrice ?? 1,
                minVal: 1,
                decoration: const QtyDecorationProps(
                    width: 20, border: InputBorder.none),
                onQtyChanged: (val) {
                  salePrice = val;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Cantidad: ",
                style: Style.textInput,
              ),
              const SizedBox(
                height: 15,
              ),
              InputQty.int(
                initVal: widget.product?.quantity ?? 1,
                minVal: 1,
                decoration: const QtyDecorationProps(
                    width: 20, border: InputBorder.none),
                onQtyChanged: (val) {
                  quantity = val;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<ProductProvider>(
                builder: (context, value, child) {
                  return TextButtonWidget(
                      text: value.productCategory == null
                          ? "Agrega categoría"
                          : "Categoría: ${value.productCategory!.categoryName}",
                      color: value.productCategory == null
                          ? Style.productColor
                          : Style.h3StyleBold.color!,
                      fontSize: 15,
                      function: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: SizedBox(
                                width: size.width,
                                height: size.height * .6,
                                child: const CategoriesList()),
                          ),
                        );
                      });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                  text: "Guardar producto",
                  size: Size(size.width, 50),
                  color: Style.productColor,
                  rounded: 12,
                  function: () async {
                    final FormState form = _formKey.currentState!;
                    if (form.validate()) {
                      if (productProvider.imagesProducts.isEmpty) {
                        flushbarWidget(
                            context: context,
                            title: "Debes agregar imagen.",
                            message: "Tienes que agregar imagenes al producto.",
                            error: true);
                      } else if (productProvider.productCategory == null) {
                        flushbarWidget(
                            context: context,
                            title: "Debes agregar categoría.",
                            message:
                                "Tienes que agregar categoría al producto.",
                            error: true);
                      } else {
                        Product product = Product(
                            widget.product?.productId ?? 0,
                            ProductImage.fromListString(
                                productProvider.imagesProducts),
                            productName: nameController.text,
                            description: descriptionController.text,
                            price: price,
                            category: productProvider.productCategory,
                            salePrice: salePrice,
                            quantity: quantity);

                        if (widget.product != null) {
                          await productProvider.update(product);

                          // Si tengo 30 productos pero ahora salen 40
                          int difference =
                              widget.product!.quantity - product.quantity;
                          int type = 0;
                          if (difference > 0) {
                            type = 1;
                          } else {
                            type = 0;
                          }
                          MoneyFlow moneyFlow = MoneyFlow(
                              amount:
                                  type == 0 ? product.price : product.salePrice,
                              quantity: difference.abs(),
                              productId: product.productId!,
                              date: DateTime.now(),
                              flowType: type);
                          await moneyFlowProvider.create(moneyFlow);
                        } else {
                          int productId =
                              await productProvider.createProduct(product);
                          MoneyFlow moneyFlow = MoneyFlow(
                              amount: product.price,
                              quantity: product.quantity,
                              productId: productId,
                              date: DateTime.now(),
                              flowType: 0);
                          await moneyFlowProvider.create(moneyFlow);
                        }

                        Future.delayed(Duration.zero, () {
                          Navigator.of(context).pop();
                        });
                      }
                    }
                  },
                  fontSize: 11)
            ],
          ),
        ),
      ),
    ));
  }

  fillControllers(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    descriptionController.text = widget.product?.description ?? "";
    nameController.text = widget.product?.productName ?? "";
    price = widget.product?.price ?? 1;
    salePrice = widget.product?.salePrice ?? 1;
    quantity = widget.product?.quantity ?? 1;
    productProvider.imagesProducts = widget.images ?? [];
    productProvider.productCategory = widget.product?.category;
  }
}

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    return productProvider.imagesProducts.isEmpty
        ? ChooseImageWidget()
        : const ImageProduct();
  }
}

class ChooseImageWidget extends StatelessWidget {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  ChooseImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        List<String> paths = [];
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          selectedImages.forEach((element) {
            paths.add(element.path);
          });
          productProvider.changeList(paths);
        }
      },
      child: const Center(
        child: Column(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.camera_enhance_sharp,
                color: Colors.white,
                size: 40,
              ),
              radius: 80,
              backgroundColor: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class ImageProduct extends StatelessWidget {
  const ImageProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return SizedBox(
      width: size.width,
      height: size.height * 0.2,
      child: Swiper(
        itemCount: productProvider.imagesProducts.length,
        itemBuilder: (context, index) {
          return Image.file(
            File(productProvider.imagesProducts[index]),
            fit: BoxFit.contain,
          );
        },
        control: const SwiperControl(),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
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
          List<ProductCategory> productsCategories = value.categories!;

          return ListView.builder(
              itemCount: productsCategories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    productProvider.changeProductCategory(productsCategories[
                        (productsCategories.length - 1) - index]);
                    Navigator.pop(context);
                  },
                  title: Text(productsCategories[
                          (productsCategories.length - 1) - index]
                      .categoryName),
                );
              });
        }
      },
    );
  }
}

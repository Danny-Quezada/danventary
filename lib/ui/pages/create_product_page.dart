import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:inventory_control/domain/models/product.dart';
import 'package:inventory_control/provider/product_provider.dart';
import 'package:inventory_control/ui/styles/styles.dart';
import 'package:inventory_control/ui/utils/validator_textfield.dart';
import 'package:inventory_control/ui/widgets/button_widget.dart';
import 'package:inventory_control/ui/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class CreateProductPage extends StatelessWidget {
  double price = 1;
  int quantity = 1;
  double salePrice = 1;
  Product? product;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  CreateProductPage({this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductProvider>(context,listen: false);
    fillControllers();
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(product == null ? "Crear producto" : "Actualizar producto"),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ProductImage(),
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
              height: 10,
            ),
            CustomFormField(
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
              height: 10,
            ),
            InputQty.double(
              initVal: product?.price ?? 1,
              minVal: 1,
              decoration:
                  const QtyDecorationProps(width: 20, border: InputBorder.none),
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
              height: 10,
            ),
            InputQty.double(
              initVal: product?.price ?? 1,
              minVal: 1,
              decoration:
                  const QtyDecorationProps(width: 20, border: InputBorder.none),
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
              height: 10,
            ),
            InputQty.int(
            
              initVal: product?.price ?? 1,
              minVal: 1,
              decoration:
                  const QtyDecorationProps(width: 20, border: InputBorder.none),
              onQtyChanged: (val) {
                quantity = val;
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
                function: () {
                  //productProvider.createProduct();
                },
                fontSize: 11)
          ],
        ),
      ),
    ));
  }
   fillControllers() {
    descriptionController.text = product?.description ?? "";
    nameController.text = product?.productName ?? "";
  

  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

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

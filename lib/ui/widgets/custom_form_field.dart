
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_control/ui/styles/styles.dart';


class CustomFormField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController textEditingController;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final String hintText;
  final String labelText;
  TextInputType? textInput;
  bool obscureText;
  bool? border;
  CustomFormField(
      {this.textInput = TextInputType.name,
      required this.textEditingController,
      required this.validator,
      required this.nextFocusNode,
      required this.focusNode,
      required this.hintText,
      required this.labelText,
      required this.obscureText,
      this.border = true});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isVisible=false;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextFocusNode?.requestFocus(),
      controller: widget.textEditingController,
     
      minLines: 1,
      maxLines: widget.border! ? 1: 10,
      keyboardType: widget.textInput,
      decoration: InputDecoration(
        
        hintStyle: Style.textFormStyle,
        labelStyle: Style.textFormStyle,
        hintText: widget.hintText,
        suffix: widget.obscureText ? IconButton(onPressed: (){
         
          setState(() {
             isVisible=!isVisible;
          });
        }, icon: Icon(!isVisible? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill)) : null,
        labelText: widget.labelText,
        helperText: "",
      ),
      validator: widget.validator,
      obscureText:isVisible ? false:  widget.obscureText,
    );
  }
}

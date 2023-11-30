
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

flushbarWidget({required BuildContext context,required String title, required message,bool error=false}){
    Flushbar(
            title: title,
            message:
                message,
            duration:const Duration(seconds: 3),
            backgroundColor: error==true ? Colors.red : Colors.green,
            icon: error==true ? const Icon(Icons.error_outline,color: Colors.white,) :const Icon(Icons.check,color: Colors.white,),
          ).show(context);
}
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController? controller ,
  required FormFieldValidator<String>? validator,
  required TextInputType? keyBoardType,
  GestureTapCallback? onTap,
  required String label,
  required String hintText,
  required IconData? prefixIcon,
  int? lines,
}) => TextFormField(
  controller:controller ,
  validator: validator,
  keyboardType:keyBoardType ,
  onTap:onTap ,
  maxLines:lines ,
  decoration: InputDecoration(
    labelText: label.tr(),
    prefixIcon:Icon(prefixIcon),
    hintText: hintText.tr(),
    isDense: true,
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

  ),
);
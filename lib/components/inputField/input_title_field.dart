import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/utils/text_frame.dart';

import '../post/custom_text_form_field.dart';

class InputTitleField extends StatelessWidget {
  final String hintText;
  final onEditingComplete;
  final TextEditingController _title;

  const InputTitleField({
    Key? key,
    required TextEditingController controller, required this.hintText, required this.onEditingComplete,
  }) : _title = controller, super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: height,
      child: CustomTextFormField(
        onChanged: (text) {
            onEditingComplete;
        },
        controller: _title,
        hint: hintText,
      ),
    );
  }
}
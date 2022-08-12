import 'package:flutter/material.dart';

import '../post/custom_text_form_field.dart';

class InputTitleField extends StatelessWidget {
  final String hintText;
  // final double height;
  final TextEditingController _title;

  const InputTitleField({
    Key? key,
    required TextEditingController controller, required this.hintText,
  }) : _title = controller, super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: height,
      child: CustomTextFormField(
        controller: _title,
        hint: hintText,
      ),
    );
  }
}
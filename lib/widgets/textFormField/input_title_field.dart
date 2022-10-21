import 'package:flutter/material.dart';
import 'package:waggly/widgets/textFormField/custom_text_form_field.dart';

class InputTitleField extends StatelessWidget {
  final String hintText;
  final onChanged;
  final onEditingComplete;
  final TextEditingController _title;

  const InputTitleField({
    Key? key,
    required TextEditingController controller,
    required this.hintText,
    required this.onChanged,
    this.onEditingComplete,
  })  : _title = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CustomTextFormField(
        onChanged: (text) {
          onChanged;
        },
        onEditingComplete: (text) {
          onEditingComplete;
        },
        controller: _title,
        hint: hintText,
      ),
    );
  }
}

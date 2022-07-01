import 'package:flutter/material.dart';

class renderTextFormField extends StatefulWidget {
  const renderTextFormField({Key? key, this.mode}) : super(key: key);
  final mode;
  @override
  State<renderTextFormField> createState() => _renderTextFormFieldState();
}

class _renderTextFormFieldState extends State<renderTextFormField> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    if(widget.mode == 'withButton') {
      return Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.fromLTRB(18, 40, 18, 40),
          child: Column(
            children: [
              Row(
                children: [
                  Text('학교 이메일',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                ],
              ),
              Row(children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(218, 175, 254, 0.5),
                          ),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    onSaved: (val) {},
                    validator: (val) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                      Border.all(color: Color.fromRGBO(182, 182, 182, 1))),
                  child: TextButton(
                    child: Text(
                      '인증하기',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff959595)),
                    ),
                    onPressed: () {},
                  ),
                )
              ]),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(218, 175, 254, 0.5),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                ),
                onSaved: (val) {},
                validator: (val) {},
              )
            ],
          ),
        ),
      )
    }

    return Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }
}

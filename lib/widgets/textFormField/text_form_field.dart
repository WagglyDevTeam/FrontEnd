import 'package:flutter/material.dart';

class RenderTextFormField extends StatefulWidget {
  const RenderTextFormField(
      {Key? key, this.mode, this.placeholder, this.buttonText, this.label})
      : super(key: key);
  final mode;
  final placeholder;
  final buttonText;
  final label;

  @override
  State<RenderTextFormField> createState() => _RenderTextFormFieldState();
}

class _RenderTextFormFieldState extends State<RenderTextFormField> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.mode == 'withButtonAndLabel') {
      return Container(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.label,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(218, 175, 254, 1))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(218, 175, 254, 0.5),
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    hintText: widget.placeholder,
                      hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12)
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
                    widget.buttonText,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff959595)),
                  ),
                  onPressed: () {},
                ),
              )
            ]),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      );
    }

    if (widget.mode == 'withButton') {
      Padding(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(children: [
          SizedBox(
            height: 4,
          ),
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              hintText: widget.placeholder,
                hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12)
            ),
            onSaved: (val) {},
            validator: (val) {},
          ),
          SizedBox(
            height: 12,
          ),
        ]),
      );
    }

    if (widget.mode == 'withLabel') {
      return Padding(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(children: [
          Row(
            children: [
              Text(widget.label,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              hintText: widget.placeholder,
                hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12)
            ),
            onSaved: (val) {},
            validator: (val) {},
          ),
          SizedBox(
            height: 12,
          ),
        ]),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(4)),
              hintText: widget.placeholder,
                hintStyle: TextStyle( color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12)
            ),
            onSaved: (val) {},
            validator: (val) {},
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

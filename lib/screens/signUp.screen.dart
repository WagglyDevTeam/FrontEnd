import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waggly/widgets/Button/Button.dart';
import 'package:waggly/widgets/TextFormFiled/TextFormFiled.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var steps = 0;

  handleClick(x) {
    setState(() {
      steps = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          SignUpInput(steps: steps, setSteps: handleClick)
        ],
      ),
    );
  }
}

// TopBar
class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      alignment: Alignment(0.9, 0.0),
      child: (IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: Color(0xffB6B6B6),
        ),
        iconSize: 20,
      )),
    );
  }
}

// 회원가입 부분
class SignUpInput extends StatefulWidget {
  const SignUpInput({Key? key, this.steps, this.setSteps}) : super(key: key);
  final steps;
  final setSteps;

  @override
  State<SignUpInput> createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Title(),
      Step(steps: widget.steps),
      Input(steps: widget.steps),
      Buttons(steps: widget.steps, setSteps: widget.setSteps)
    ]);
  }
}

// Title
class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
        child: Text(
          '회원가입',
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ));
  }
}

// Step
class Step extends StatefulWidget {
  const Step({Key? key, this.steps}) : super(key: key);
  final steps;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(18, 0, 2, 0),
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: widget.steps == 0
                                  ? Color(0xffB863FB)
                                  : Color(0xffE8E8E8),
                              width: 2,
                            ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 0
                              ? Color(0xffB863FB)
                              : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                              color: widget.steps == 0
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff959595)),
                        ))),
                Container(
                  height: 22,
                  margin: EdgeInsets.fromLTRB(18, 8, 0, 0),
                  child: Text(
                    '학교 인증',
                    style: TextStyle(
                      fontSize: widget.steps == 0 ? 16 : 10,
                      fontWeight:
                      widget.steps == 0 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 0
                          ? Color(0xff2B173B)
                          : Color(0xff959595),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(18, 4, 0, 0),
                  child: widget.steps == 0
                      ? Text(
                    '학교 인증을 위해 정보를 입력하세요.',
                    style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600),
                  )
                      : Text(
                    '',
                    style: TextStyle(fontSize: 11),
                  ),
                )
              ],
            ),
            flex: widget.steps == 0 ? 6 : 2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: widget.steps == 1
                                  ? Color(0xffB863FB)
                                  : Color(0xffE8E8E8),
                              width: 2,
                            ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 1
                              ? Color(0xffB863FB)
                              : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: widget.steps == 1
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff959595)),
                        ))),
                Container(
                  height: 22,
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '학교 정보',
                    style: TextStyle(
                      fontSize: widget.steps == 1 ? 16 : 10,
                      fontWeight:
                      widget.steps == 1 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 1
                          ? Color(0xff2B173B)
                          : Color(0xff959595),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: widget.steps == 1
                      ? Text(
                    '학교 정보를 입력해주세요.',
                    style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600),
                  )
                      : Text(
                    '',
                    style: TextStyle(fontSize: 11),
                  ),
                )
              ],
            ),
            flex: widget.steps == 1 ? 6 : 2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(2, 0, 18, 0),
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: widget.steps == 2
                                  ? Color(0xffB863FB)
                                  : Color(0xffE8E8E8),
                              width: 2,
                            ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 2
                              ? Color(0xffB863FB)
                              : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(
                              color: widget.steps == 2
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff959595)),
                        ))),
                Container(
                  height: 22,
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '아이디 생성',
                    style: TextStyle(
                      fontSize: widget.steps == 2 ? 16 : 10,
                      fontWeight:
                      widget.steps == 2 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 2
                          ? Color(0xff2B173B)
                          : Color(0xff959595),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: widget.steps == 2
                      ? Text(
                    '비밀번호와 닉네임을 입력해주세요.',
                    style: TextStyle(fontSize: 11),
                  )
                      : Text(
                    '',
                    style: TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            flex: widget.steps == 2 ? 6 : 2,
          ),
        ],
      ),
    );
  }
}

// Input
class Input extends StatefulWidget {
  const Input({Key? key, this.steps}) : super(key: key);
  final steps;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
        widget.steps == 0 ?
        Column(
          children: [
            RenderTextFormField(mode: 'withButton', label: '학교 이메일', placeholder: 'abc@email.com', buttonText: '인증하기'),
            RenderTextFormField(mode: 'withButton', label: '인증번호', placeholder: '인증번호 입력', buttonText: 'test',),
          ],
        )
            : widget.steps == 1 ? Text('hi') : Text('bye');

  }

}

// Button
class Buttons extends StatefulWidget {
  const Buttons({Key? key, this.steps, this.setSteps}) : super(key: key);
  final steps;
  final setSteps;

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
        width: double.infinity,
        height: 36,
        child: Stack(
          children: [
            if (widget.steps == 0)
              Container(
                width: double.infinity,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: widget.steps == 0
                        ? Color(0xffB863FB)
                        : Color(0xffE8E8E8)),
                child: TextButton(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: widget.steps == 0
                          ? Color(0xffFFFFFF)
                          : Color(0xff959595),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    widget.setSteps(1);
                  },
                ),
              ),
            if (widget.steps == 1)
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Color.fromRGBO(218, 175, 254, 0.2)),
                      child: TextButton(
                        child: Text(
                          '이전',
                          style: TextStyle(
                            color: Color(0xffA558E0),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(0);
                        },
                      ),
                    ),
                    Container(
                      width: 155,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Color(0xffE8E8E8),
                      ),
                      child: TextButton(
                        child: Text(
                          '다음',
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.steps == 2)
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Color.fromRGBO(218, 175, 254, 0.2)),
                      child: TextButton(
                        child: Text(
                          '이전',
                          style: TextStyle(
                            color: Color(0xffA558E0),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(1);
                        },
                      ),
                    ),
                    Container(
                      width: 155,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Color(0xffE8E8E8),
                      ),
                      child: TextButton(
                        child: Text(
                          '다음',
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          print('회원가입 완료');
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
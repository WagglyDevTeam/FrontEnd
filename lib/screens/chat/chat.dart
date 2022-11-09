import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/chat/chat.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  // final WebSocketChannel channel = IOWebSocketChannel.connect('ws://localhost:8080');

  @override
  State<ChatScreen> createState() => _ChatState();
  }


class _ChatState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  StompClient? stompClient;
  final socketUrl = "http://localhost:8080/ws";

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
        destination: '/topic/public',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            // Map<String, dynamic> obj = json.decode(frame.body!);
            Chat chat = Chat(senderId: 1, message: "테스트", messageTime: DateTime.now());
            setState(() =>
            {
              // list.add(message)
            });
          }
        }
    );
  }

  // https://velog.io/@carrykim/%EC%82%AC%EC%9D%B4%EB%93%9C-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-react-flutter-%EC%B1%84%ED%8C%85-%EC%95%B1-%EB%A7%8C%EB%93%A4%EA%B8%B0-4
  sendMessage() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바에 타이틀 텍스트 설정. widget을 통해 MyHomePage의 필드에 접근 가능
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                // 컨트롤러 항목에 _controller 설정
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            // Stream을 처리하기 위한 StreamBuilder 추가
            StreamBuilder(
              // 채널의 스트림을 stream 항목에 설정. widget을 통해 MyHomePage의 필드에 접근 가능
              // stream: widget.channel.stream,
              // 채널 stream에 변화가 발생하면 빌더 호출
              builder: (context, snapshot) {
                print(snapshot);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  // 수신 데이터가 존재할 경우 해당 데이터를 텍스트로 출력
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      // 플로팅 버튼이 눌리면 _sendMessage 함수 호출
      floatingActionButton: FloatingActionButton(
          onPressed: _sendMessage,
          tooltip: 'Send message',
          child: Icon(Icons.send)),
    );
  }

  // 플로팅 버튼이 눌리면 호출
  void _sendMessage() {
    // TextFormField에 입력된 텍스트가 존재하면
    if (_controller.text.isNotEmpty) {
      // 해당 텍스트를 서버로 전송. widget을 통해 MyHomePage의 필드에 접근 가능
      // widget.channel.sink.add(_controller.text);
    }
  }

  // 상태 클래스가 종료될 때 호출
  @override
  void dispose() {
    // 채널을 닫음
    // widget.channel.sink.close();
    super.dispose();
  }
}

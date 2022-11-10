import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {


  @override
  State<ChatScreen> createState() => _ChatState();
  }


class _ChatState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();

  // final WebSocketChannel channel = IOWebSocketChannel.connect('ws://localhost:8080/ws');
  late final StompClient stompClient;
  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/public',
      callback: (frame) {
        print("연결됨?");
        // List<dynamic>? result = json.decode(frame.body);
        // print(result);
      },
    );

    Timer.periodic(Duration(seconds: 10), (_) {
      stompClient.send(
        destination: '/app/chat.addUser',
        body: json.encode({ "sender": "username", "type": "JOIN" }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: 'http://localhost:8080/ws',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {},
        webSocketConnectHeaders: {},
      ),
    );

    print("before activate");
    stompClient.activate();
    print("after activate");

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
              // stream: stompClient.,
              // 채널 stream에 변화가 발생하면 빌더 호출
              builder: (context, snapshot) {
                // print(channel.stream);
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
      // channel.sink.add(_controller.text);
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

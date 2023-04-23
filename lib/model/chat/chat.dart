class Chat {
  final int? senderId;
  final String? message;
  final DateTime? messageTime;

  Chat({
    this.senderId,
    this.message,
    this.messageTime,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      senderId: json['senderId'],
      message: json['message'],
      messageTime: json['messageTime'],
    );
  }
}



class Message {
  final int? roomId;
  final Sender sender;
  final String? message;

  Message({
    required this.roomId,
    required this.sender,
    required this.message,
});

  @override
  String toString() {
    return '{id: $roomId, sender:$sender , message: $message}';
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      roomId: json['roomId'],
      message: json['message'],
      sender: Sender.fromJson(json['sender']),
    );
  }
}


class Sender {
  final int? userId;
  final String? nickName;
  final String? major;
  final String? profileImg;

  Sender({
    this.userId,
    this.nickName,
    this.major,
    this.profileImg
});

  @override
  String toString() {
    return '{userid: $userId, nickname:$nickName , major: $major, profile:$profileImg}';
  }


  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      userId: json['userId'],
      nickName: json['nickName'],
      major: json['major'],
      profileImg: json['profileImg'],
    );
  }
}


// sendMesage

class SendMessage{
  final int? roomId;
  final String? message;
  final String? token;

  SendMessage({
    this.roomId,
    this.message,
    this.token,
});

  Map<String, dynamic> toJson() => {
    "roomId": roomId,
    "message": message,
    "token": token,
  };
}






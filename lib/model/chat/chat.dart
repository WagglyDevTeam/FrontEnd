class Chat {
  final int? senderId;
  final String? message;
  final String? messageTime;


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

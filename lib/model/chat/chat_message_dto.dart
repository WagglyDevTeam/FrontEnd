
class ChatMessageDto{
  final int? roomId;
  final int? senderId;
  final String? body;
  final String? type;
  final DateTime? createdAt;

  ChatMessageDto({
    this.senderId,
    this.roomId,
    this.createdAt,
    this.body,
    this.type,
});

  factory ChatMessageDto.fromJson(Map<String, dynamic>json){
    return ChatMessageDto(
      roomId: json['roomId'],
      senderId: json['senderId'],
      body: json['body'],
      type: json['type'],
      createdAt: json['createdAt'],
    );
  }
}
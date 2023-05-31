
class ChatImageDto {
  final int? senderId ;
  final String? imageUrl;
  final DateTime? createdAt;

  ChatImageDto({
    this.createdAt,
    this.imageUrl,
    this.senderId,
});

  factory ChatImageDto.fromJson(Map<String, dynamic>json){
    return ChatImageDto(
        senderId: json['senderId'],
        imageUrl : json['imageUrl'],
        createdAt : json['createdAt'],
    );
  }

}
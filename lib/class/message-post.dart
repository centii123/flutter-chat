class ChatMessage {
  final String room;
  final String message;

  ChatMessage({
    required this.room,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'room': room,
      'message': message,
    };
  }
}


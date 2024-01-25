import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesProvider = StateProvider<List<Message>>((ref) {
  return List.empty();
});

class Message {
  Message({
    required this.message,
    required this.sentTime,
    required this.isSender,
  });
  final String message;
  final DateTime sentTime;
  final bool isSender;
}

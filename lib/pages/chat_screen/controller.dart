import 'package:course_view/pages/chat_screen/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ChatScreenController on Widget {
  Future<void> onSend(WidgetRef ref, TextEditingController controller) async {
    final msg = controller.text.trim();

    if (msg.isEmpty) return;

    final message = Message(
      message: msg,
      sentTime: DateTime.now(),
      isSender: true,
    );

    ref.read(messagesProvider.notifier).update((state) => [message, ...state]);
    controller.clear();

    final response = await getResponse(msg);

    final responseMsg = Message(
      message: response,
      sentTime: DateTime.now(),
      isSender: false,
    );

    ref
        .read(messagesProvider.notifier)
        .update((state) => [responseMsg, ...state]);
  }

  Future<String> getResponse(String message) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return '<A MESSAGE FROM AN ADMIN>';
  }
}

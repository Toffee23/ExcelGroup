import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String countDays(Timestamp time) {
  Duration difference = DateTime.now().difference(time.toDate());

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays == 1) {
    return 'yesterday';
  } else {
    return '${difference.inDays} days ago';
  }
}

final UseridProvider = Provider<String>((ref) {
  // The initial value of the counter is 0
  return '659e445d3d4c93ea3319a12d';
});

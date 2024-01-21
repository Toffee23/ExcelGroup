import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchForum(String forumId) async {
  final CollectionReference<Map<String, dynamic>> _collection =
      FirebaseFirestore.instance.collection('forum');

  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _collection.doc(forumId).get();

    if (documentSnapshot.exists) {
      // Document exists, return its data
      var data = documentSnapshot.data();
      return {
        'title': data!['title'],
        'category': data['category'],
        'about': data['about group'],
        'certification': data['certification'],
        'creator': data['creator'],
        'date': data['date'],
        'image': data['image']
      };
    } else {
      // Document doesn't exist
      return {};
    }
  } catch (e) {
    // Handle any potential errors
    print('Error fetching data from Firestore: $e');
    return {};
  }
}

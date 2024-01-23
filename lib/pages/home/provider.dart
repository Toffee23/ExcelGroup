import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_handler/api_services.dart';
import 'model.dart';

final coursesProvider = StreamProvider<List<CoursesModel>?>((ref) async* {
  final ClientApi clientApi = ClientApi();

  log('Got 111');
  final result = await clientApi.getAllCourses();
  log('Done 2222');

  yield* Stream.value(result.data.map<CoursesModel>((json) {
    return CoursesModel.fromJson(json);
  }).toList());
});

final cartsProvider = StateProvider<List<CoursesModel>>((ref) => []);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_handler/api_services.dart';
import 'model.dart';

final coursesProvider = StreamProvider<List<CoursesModel>?>((ref) async* {
  final ClientApi clientApi = ClientApi();

  final result = await clientApi.getAllCourses();

  yield* Stream.value(result.data.map<CoursesModel>((json) {
    return CoursesModel.fromJson(json);
  }).toList());
});

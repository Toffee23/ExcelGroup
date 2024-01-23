import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_handler/api_services.dart';
import 'model.dart';

final courseProvider =
    FutureProvider.family<CourseModel, String>((ref, id) async {
  final ClientApi clientApi = ClientApi();

  final result = await clientApi.getAllCourseById(id);
  return CourseModel.fromJson(result.data);
});

final canPlayVideoProvider = StateProvider.autoDispose<bool>((ref) => false);
final isForwardingProvider = StateProvider.autoDispose<bool>((ref) => false);
final isBackwardingProvider = StateProvider.autoDispose<bool>((ref) => false);
final doubleTapHandledProvider =
    StateProvider.autoDispose<bool>((ref) => false);

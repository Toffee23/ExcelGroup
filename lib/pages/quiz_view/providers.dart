import 'package:flutter_riverpod/flutter_riverpod.dart';

final opponentTypeProvider = StateProvider.autoDispose<String>((ref) => '');
final selectedCourseProvider = StateProvider.autoDispose<String>((ref) => '');

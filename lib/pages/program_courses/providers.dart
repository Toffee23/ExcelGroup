import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider.autoDispose<String>((ref) => '');

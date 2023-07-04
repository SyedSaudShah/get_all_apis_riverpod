import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_all_apis_riverpod/River_pod/state_provider.dart';


final getApiNotifierProvider = StateNotifierProvider<ApiStateNotifier,PostState >((ref) {
  return ApiStateNotifier();
});

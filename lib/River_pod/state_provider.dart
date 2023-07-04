


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_all_apis_riverpod/Model_class/getallproducts.dart';

import '../Api/apiproducts.dart';

@immutable
abstract class PostState {}

@immutable
class PostInitialState extends PostState {}

@immutable
class PostLoadingState extends PostState {}

@immutable
class PostLoadedState extends PostState {
  final List<GetProduct> list;
  PostLoadedState({
    required this.list,
  });
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({
    required this.message,
  });
}

class ApiStateNotifier extends StateNotifier<PostState>{
  ApiStateNotifier():super(PostInitialState());
  FetchApi fetchApi = FetchApi();
  dynamic fetchDataS() async {
    try{
      state = PostLoadingState();
      var listData = await fetchApi.fetchPosts();
     // state = PostLoadedState(list: listData);
state =PostLoadedState(list: listData);


    }catch (e){
      state = PostErrorState(message: e.toString());
    }
  }
}
//
// class PostStateNotifier extends StateNotifier<PostState> {
//   PostStateNotifier() : super(PostInitialState());
//   FetchApi fetchApi = FetchApi();
//   fetchDataS() async {
//     try {
//       state = PostLoadingState();
//       var listData = await fetchApi.fetchApi;
//       state = PostLoadedState(list: listData);
//     } catch (e) {
//       state = PostErrorState(message: e.toString());
//     }
//   }
// }
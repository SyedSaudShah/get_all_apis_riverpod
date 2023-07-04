import 'dart:convert';

import 'package:get_all_apis_riverpod/Model_class/getallproducts.dart';
import 'package:http/http.dart' as http;




abstract
class GetApiService {
  String baseurl = 'https://jsonplaceholder.typicode.com';
  String get endpoint;
  String get url => baseurl + endpoint;
  dynamic fetch()async {
    //await get(Uri.parse(url));
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      return response.statusCode;
    }
  }


}
class FetchApi extends GetApiService{
  static FetchApi? fetchApi;
  FetchApi._internal();
  factory FetchApi() {
    return fetchApi ??= FetchApi._internal();
  }
  Future<List<GetProduct>> fetchPosts() async {
    var posts = await fetch() as List;
    var data = posts.map((e) => GetProduct.fromJson(e)).toList();
    return data;
  }

  @override
  String get endpoint => '/posts';
}
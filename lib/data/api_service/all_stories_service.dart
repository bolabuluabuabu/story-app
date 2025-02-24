import 'dart:convert';

import 'package:starter/data/api_responses/all_stories_response.dart';
import 'package:starter/data/api_service/api_service.dart';
import 'package:http/http.dart' as http;

class AllStoriesService extends ApiService {
  AllStoriesService(super.auth) {
    assert(auth.isAuthorized);
  }

  Future<AllStoriesResponse> get({int page = 1, int size = 10}) async {
    final response = await http.get(Uri.parse("$baseUrl/stories?page=$page&size=$size"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth.token}',
    });
    final decodedResponse = json.decode(response.body);

    if (decodedResponse['error'] != null && decodedResponse['error'] == false) {
      return AllStoriesResponse.fromJson(decodedResponse);
    } else {
      throw Exception(decodedResponse['message']);
    }
  }
}

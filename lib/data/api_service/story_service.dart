import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:starter/data/api_responses/detail_story_response.dart';
import 'package:starter/data/api_service/api_service.dart';

class StoryService extends ApiService {
  StoryService(super.auth) {
    assert(auth.isAuthorized);
  }

  Future<DetailStoryResponse> get(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/stories/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${auth.token}',
      },
    );
    final decodedResponse = json.decode(response.body);

    if (decodedResponse['error'] != null && decodedResponse['error'] == false) {
      return DetailStoryResponse.fromJson(decodedResponse);
    } else {
      throw Exception(decodedResponse['message']);
    }
  }

  Future<void> create(File file, String description, LatLng? latlng) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/stories"),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${auth.token}',
    });

    if (latlng != null) {
      request.fields.addAll({
        'description': description,
        'lat': latlng.latitude.toString(),
        'lon': latlng.longitude.toString(),
      });
    } else {
      request.fields.addAll({
        'description': description,
      });
    }

    request.files.add(await http.MultipartFile.fromPath(
      'photo',
      file.path,
    ));

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final decodedResponse = json.decode(response.body);

    if (decodedResponse['error'] != null && decodedResponse['error'] == false) {
    } else {
      throw Exception(decodedResponse['message']);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/model/response.dart';
import 'package:vimigo_assessment/services/http/raw_data.dart';
class HttpRequest {

  static const String host = '';

  static Future<ResponseOrError> getResponse({
    int? page
  }) async {
    String? anyError;
    try {
      // http.Response response = await http.get(Uri(
      //   scheme: 'https',
      //   host: host,
      //   path: 'api/users',
      //   queryParameters: {'page': '${page ?? 1}'},
      // )).timeout(Duration(seconds: 7));
      // if (response.statusCode == 200) {
      //   HttpResponse postmanResponse = HttpResponse.fromJson(response.body);
      //   if (postmanResponse.data == null || postmanResponse.data!.isEmpty) {
      //     anyError = 'Response data is empty.';
      //   } else {
      //     return ResponseOrError(response: postmanResponse);
      //   }
      // } else {
      //   anyError = 'Response status is ${response.statusCode}.';
      // }
      List<Attendance> attendances = rawData.map((e) => Attendance.fromMap(e)).toList();
      debugPrint(attendances.length.toString());
      return ResponseOrError(response: HttpResponse(data: attendances));
    } catch (e) {
      debugPrint('ERROR getResponse() : $e');
      anyError = e.toString();
    }
    return ResponseOrError(anyError: anyError);
  }
}
import 'dart:convert';

import 'package:vimigo_assessment/model/attendance.dart';

class HttpResponse {
  List<Attendance>? data;
  
  HttpResponse({
    this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(data != null){
      result.addAll({'data': data!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory HttpResponse.fromMap(Map<String, dynamic> map) {
    return HttpResponse(
      data: map['data'] != null ? List<Attendance>.from(map['data']?.map((x) => Attendance.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HttpResponse.fromJson(String source) => HttpResponse.fromMap(json.decode(source));
}

class ResponseOrError {
  String? anyError;
  HttpResponse? response;

  ResponseOrError({
    this.anyError,
    this.response,
  });
}

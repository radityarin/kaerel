import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  final String BASE_URL = "https://www.api.comuline.com/v1/";

  Future<dynamic> getStation() async {
    var url = Uri.parse("${BASE_URL}station");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getScheduleByStationId(String stationId) async {
    var url = Uri.parse("${BASE_URL}schedule/$stationId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
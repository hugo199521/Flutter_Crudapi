import 'dart:convert';
import 'package:http/http.dart' as http;
import 'profile.dart';

class Services {
  static const String url = 'https://apihugo.azurewebsites.net/api/carro';

  static Future<List<Profile>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Profile> list = parseProfile(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Profile> parseProfile(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
  }
}
import 'dart:convert';

import 'package:crudwindowsfinal/Crud/modelo/api/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = "https://apihugo.azurewebsites.net";
  Client client = Client();

  Future<List<Profile>> getProfile() async {
    final response = await http.get("$baseUrl/api/carro");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      "$baseUrl/api/carro",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      "$baseUrl/api/carro/${data.id}",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      "$baseUrl/api/carro/?id=$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  static List<Profile> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
  }
}

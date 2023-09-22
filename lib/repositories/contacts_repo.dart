import 'dart:convert';

import 'package:http/http.dart';

import '../models/contact_model.dart';

class ContactsRepository {
  String userUrl = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';

  Future<List<ContactModel>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      // print(result);
      return result.map((e) => ContactModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

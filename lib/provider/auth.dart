import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';




class Auth with ChangeNotifier {
    String? _token ;
    DateTime? _expireTime ;
    String? _userId ;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expireTime != null && _token != null &&
        _expireTime!.isAfter(DateTime.now())) {
      return _token;
    } 
    else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBaUodtLpd5SVFb-k4X3XdC6zK1tTzK_go');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = jsonDecode(response.body);
       
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']); 
      }
       _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expireTime = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
          notifyListeners(); 
     
    } catch (error) {
      throw error;
    }
  }
  

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');

    //print(response.body);
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // final url = Uri.parse(
    //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBaUodtLpd5SVFb-k4X3XdC6zK1tTzK_go');
    //       final response = await http.post(url,
    //       body: jsonEncode(
    //           {'email': email, 'password': password, 'returnSecureToken': true}));
    //           print(response.body);
  }
}

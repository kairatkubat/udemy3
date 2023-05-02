import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expireTime;
  late String _userId;

 Future<void> _authenticate(String email, String password, String urlSegment) async{
 final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBaUodtLpd5SVFb-k4X3XdC6zK1tTzK_go');
    try{
 final response = await http.post(url,
        body: jsonEncode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
            final responseData = jsonDecode(response.body);
            if(responseData['error'] != null){
              throw HttpException( responseData['error']['message']);
            }
    }
    catch(error){
       throw error;
    }
   
           

 }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
   
    //print(response.body);
  }

  Future<void> signin(String email, String password) async {
  return  _authenticate(email, password, 'signInWithPassword');
  // final url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBaUodtLpd5SVFb-k4X3XdC6zK1tTzK_go');
  //       final response = await http.post(url,
  //       body: jsonEncode(
  //           {'email': email, 'password': password, 'returnSecureToken': true}));
  //           print(response.body);
  }
}

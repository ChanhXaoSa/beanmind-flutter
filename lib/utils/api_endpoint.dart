import 'dart:convert';

String baseApiUrl = 'http://bmapitest.somee.com/api/v1';
// String newBaseApiUrl = 'https://vinhtc3-001-site1.ftempurl.com/api/v1';
String newBaseApiUrl = 'https://congvinh2024-001-site1.dtempurl.com/api/v1';



Map<String, String> getHeaders() {
  const String username = '11190907';
  const String password = '60-dayfreetrial';
  final String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  return {
    'Content-Type': 'application/json; charset=utf-8',
    'ngrok-skip-browser-warning': 'true',
  };
}
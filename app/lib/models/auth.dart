import 'dart:convert';


class Credentials {
  String username;
  String password;
  Credentials(this.username, this.password);

  @override
  String toString() {
    return json.encode({
      'username': username,
      'password': password 
    });
  }

  static Credentials? fromString(String str) {
    Map<String, dynamic> credentials = json.decode(str);
    if (!(credentials.containsKey('username') && credentials.containsKey('password'))) {
      return null; //throw CredentialsException('username or password keys not found');
    }
    return Credentials(credentials['username']!, credentials['password']!);
  }

}

class Authenticator {

  

}
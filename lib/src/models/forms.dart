


class LoginFormData {
  String email = '';
  String password = '';

  Map<String, dynamic> toJSON() =>
    {
      'email': email,
      'password': password
    };
}

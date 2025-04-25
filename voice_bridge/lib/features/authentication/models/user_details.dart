class UserDetails {
  String? displayName;
  String? email;
  String? photoUrl;

  UserDetails({
    this.displayName,
    this.email,
    this.photoUrl,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String ,dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;

    return data;
  }
}
class ProfileDomain {
  ProfileDomain({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory ProfileDomain.fromJson(Map<String, dynamic> json) {
    return ProfileDomain(
      id: json['profile_id'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
    );
  }

  final String id;
  final String firstname;
  final String lastname;
  final String email;

  ProfileDomain copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
  }) {
    return ProfileDomain(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() => {
    'profile_id': id,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };

  List<Object?> get props => [id, firstname, lastname, email];
}

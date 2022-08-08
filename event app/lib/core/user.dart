import 'dart:convert';

class EventUser {
  String email;
  EventUser({
    required this.email,
  });

  EventUser copyWith({
    String? email,
  }) {
    return EventUser(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory EventUser.fromMap(Map<String, dynamic> map) {
    return EventUser(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventUser.fromJson(String source) =>
      EventUser.fromMap(json.decode(source));

  @override
  String toString() => 'EventUser(email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventUser && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

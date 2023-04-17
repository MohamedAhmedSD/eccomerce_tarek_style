import 'dart:convert';

// modwl to save data to firestore
class UserData {
  final String uid;
  final String email;

  UserData({required this.uid, required this.email});

  // json serilization => fromMap && toMap
  Map<String, dynamic> toMap() {
    // reult is map
    final result = <String, dynamic>{};
    // adding to our map
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      email: map['email'] ?? '',
    );
  }
}

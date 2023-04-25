//! model to save User data => to firestore
//* its id && email
class UserData {
  final String uid;
  final String email;

  UserData({required this.uid, required this.email});

  //* we do it through Json
  //? json serilization => fromMap && toMap

  //* [1] to map => funtion back Map <S,D>
  //? A. for few data
  Map<String, dynamic> toMap() {
    //? reult is Map
    //! empty Map
    final result = <String, dynamic>{};
    //! adding to empty Map => User data as Key && Value

    //* ## we use addAll ##
    //?Adds all key/value pairs of [other] to this map.
    //* If a key of [other] is already in this map, its value is overwritten.

    result.addAll({'uid': uid});
    result.addAll({'email': email});

    //! we return our final Map
    return result;
  }

  //* [2] fromMap => named factory constrcutor
  //? pass Map && [String ==  by it reach to data == id ] as parameters
  //! to return our consrtuctor with its parameter values
  //* we need access to data values

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      email: map['email'] ?? '',

      //? as int, == ?.toInt() ?? 0,
      //* as String, == ?? '',
    );
  }
}

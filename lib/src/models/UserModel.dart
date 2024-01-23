/// id : 4
/// first_name : "Terrance"
/// middle_name : ""
/// last_name : "Manyange"
/// id_number : "63-2398450F75"
/// dob : "1996-09-10"
/// gender : "Female"
/// marital_status : "Single"
/// phone : "+263783916321"
/// address : "123 Dama Street , Forozi, Harare"
/// created_at : "2024-01-22T15:18:29.000000Z"
/// updated_at : "2024-01-22T15:18:29.000000Z"
/// password : "$2y$10$pZhOJJZiU4cCDDqdEDyrl.0VoXN.fGvdkvj/ccZN82Mu5Pv0fiJeq"
/// email : "lolo@cast.com"

class UserModel {
  UserModel({
      num? id, 
      String? firstName, 
      String? middleName, 
      String? lastName, 
      String? idNumber, 
      String? dob, 
      String? gender, 
      String? maritalStatus, 
      String? phone, 
      String? address, 
      String? createdAt, 
      String? updatedAt, 
      String? password, 
      String? email,}){
    _id = id;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _idNumber = idNumber;
    _dob = dob;
    _gender = gender;
    _maritalStatus = maritalStatus;
    _phone = phone;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _password = password;
    _email = email;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _middleName = json['middle_name'];
    _lastName = json['last_name'];
    _idNumber = json['id_number'];
    _dob = json['dob'];
    _gender = json['gender'];
    _maritalStatus = json['marital_status'];
    _phone = json['phone'];
    _address = json['address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _password = json['password'];
    _email = json['email'];
  }
  num? _id;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _idNumber;
  String? _dob;
  String? _gender;
  String? _maritalStatus;
  String? _phone;
  String? _address;
  String? _createdAt;
  String? _updatedAt;
  String? _password;
  String? _email;
UserModel copyWith({  num? id,
  String? firstName,
  String? middleName,
  String? lastName,
  String? idNumber,
  String? dob,
  String? gender,
  String? maritalStatus,
  String? phone,
  String? address,
  String? createdAt,
  String? updatedAt,
  String? password,
  String? email,
}) => UserModel(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  middleName: middleName ?? _middleName,
  lastName: lastName ?? _lastName,
  idNumber: idNumber ?? _idNumber,
  dob: dob ?? _dob,
  gender: gender ?? _gender,
  maritalStatus: maritalStatus ?? _maritalStatus,
  phone: phone ?? _phone,
  address: address ?? _address,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  password: password ?? _password,
  email: email ?? _email,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get middleName => _middleName;
  String? get lastName => _lastName;
  String? get idNumber => _idNumber;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get maritalStatus => _maritalStatus;
  String? get phone => _phone;
  String? get address => _address;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get password => _password;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['middle_name'] = _middleName;
    map['last_name'] = _lastName;
    map['id_number'] = _idNumber;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['marital_status'] = _maritalStatus;
    map['phone'] = _phone;
    map['address'] = _address;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['password'] = _password;
    map['email'] = _email;
    return map;
  }

}
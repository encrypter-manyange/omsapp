/// id : 3
/// description : "Subscription February 2024"
/// reference : "65adfee5c92e8"
/// member_id : 1
/// amount : "20"
/// created_at : "2024-01-22T03:36:37.000000Z"
/// updated_at : "2024-01-22T03:43:08.000000Z"
/// status : 1

class ContributionsModel {
  ContributionsModel({
      num? id, 
      String? description, 
      String? reference, 
      num? memberId, 
      String? amount, 
      String? createdAt, 
      String? updatedAt, 
      num? status,}){
    _id = id;
    _description = description;
    _reference = reference;
    _memberId = memberId;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
}

  ContributionsModel.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _reference = json['reference'];
    _memberId = json['member_id'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
  }
  num? _id;
  String? _description;
  String? _reference;
  num? _memberId;
  String? _amount;
  String? _createdAt;
  String? _updatedAt;
  num? _status;
ContributionsModel copyWith({  num? id,
  String? description,
  String? reference,
  num? memberId,
  String? amount,
  String? createdAt,
  String? updatedAt,
  num? status,
}) => ContributionsModel(  id: id ?? _id,
  description: description ?? _description,
  reference: reference ?? _reference,
  memberId: memberId ?? _memberId,
  amount: amount ?? _amount,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  status: status ?? _status,
);
  num? get id => _id;
  String? get description => _description;
  String? get reference => _reference;
  num? get memberId => _memberId;
  String? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['reference'] = _reference;
    map['member_id'] = _memberId;
    map['amount'] = _amount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status'] = _status;
    return map;
  }

}
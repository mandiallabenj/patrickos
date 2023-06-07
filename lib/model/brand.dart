import 'package:flutter/foundation.dart';

class Brand{
  String id;
  String name;
  String created;

  Brand({required this.id,required this.name, required this.created});

  factory Brand.fromJson(Map<String,dynamic> json){
    return Brand(
      id: json['id'].toString(),
      name: json['name'] as String,
      created: json['created'] as String
    );
  }

}
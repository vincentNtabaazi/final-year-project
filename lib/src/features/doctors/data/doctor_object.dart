// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Doctor {
  final String name;
  final String email;
  final String gender;
  final String languages_spoken;
  final double rate;
  final String hospitalName;
  final String pro_title;
  final String med_specialty;
  final String employment_status;
  final List time_slots;

  const Doctor(
      this.name,
      this.email,
      this.gender,
      this.languages_spoken,
      this.rate,
      this.hospitalName,
      this.pro_title,
      this.med_specialty,
      this.employment_status,
      this.time_slots);

  Doctor copyWith({
    String? name,
    String? email,
    String? gender,
    String? languages_spoken,
    double? rate,
    String? hospitalName,
    String? pro_title,
    String? med_specialty,
    String? employment_status,
    List? time_slots,
  }) {
    return Doctor(
      name ?? this.name,
      email ?? this.email,
      gender ?? this.gender,
      languages_spoken ?? this.languages_spoken,
      rate ?? this.rate,
      hospitalName ?? this.hospitalName,
      pro_title ?? this.pro_title,
      med_specialty ?? this.med_specialty,
      employment_status ?? this.employment_status,
      time_slots ?? this.time_slots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'gender': gender,
      'languages_spoken': languages_spoken,
      'rate': rate,
      'hospitalName': hospitalName,
      'pro_title': pro_title,
      'med_specialty': med_specialty,
      'employment_status': employment_status,
      'time_slots': time_slots,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      map['name'] as String,
      map['email'] as String,
      map['gender'] as String,
      map['languages_spoken'] as String,
      map['rate'] as double,
      map['hospitalName'] as String,
      map['pro_title'] as String,
      map['med_specialty'] as String,
      map['employment_status'] as String,
      List.from((map['time_slots'] as List),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(name: $name, email: $email, gender: $gender, languages_spoken: $languages_spoken, rate: $rate, hospitalName: $hospitalName, pro_title: $pro_title, med_specialty: $med_specialty, employment_status: $employment_status, time_slots: $time_slots)';
  }

  @override
  bool operator ==(covariant Doctor other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.gender == gender &&
      other.languages_spoken == languages_spoken &&
      other.rate == rate &&
      other.hospitalName == hospitalName &&
      other.pro_title == pro_title &&
      other.med_specialty == med_specialty &&
      other.employment_status == employment_status &&
      listEquals(other.time_slots, time_slots);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      languages_spoken.hashCode ^
      rate.hashCode ^
      hospitalName.hashCode ^
      pro_title.hashCode ^
      med_specialty.hashCode ^
      employment_status.hashCode ^
      time_slots.hashCode;
  }
}

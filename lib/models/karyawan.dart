import 'package:equatable/equatable.dart';

class Karyawan extends Equatable {
  final int? nik;
  final String? firstName;
  final String? lastName;
  final String? alamat;
  final bool? aktif;

  const Karyawan(
      {this.nik, this.firstName, this.lastName, this.alamat, this.aktif});

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      nik: json['nik'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      alamat: json['alamat'],
      aktif: json['aktif'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'first_name': firstName,
      'last_name': lastName,
      'alamat': alamat,
      'aktif': aktif,
    };
  }

  @override
  List<Object?> get props => [nik, firstName, lastName, alamat, aktif];

  //get first character from first name and last name and uppercase it
  String getInitials() {
    var initial = '';
    if (firstName != null && firstName!.isNotEmpty) {
      if (firstName?.length == 1) {
        initial = '${firstName?.toUpperCase()}';
      } else {
        try {
          initial = '${firstName?.substring(0, 1).toUpperCase()}';
        } catch (e, t) {
          print(e);
          print(t);
          print(firstName);
        }
      }
    }
    if (lastName != null && lastName!.isNotEmpty) {
      if (lastName?.length == 1) {
        initial += '${lastName!.substring(0, 1).toUpperCase()}';
      } else {
        initial += '${lastName!.substring(0, 1).toUpperCase()}';
      }
    }
    return initial;
  }
}

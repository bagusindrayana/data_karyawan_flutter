import 'dart:convert';

import 'package:data_karyawan/models/karyawan.dart';
import 'package:data_karyawan/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class KaryawanRepository {
  Future<List<Karyawan>> getKaryawanList() async {
    final response = await DioClient.instance.get("/api/karyawan/all",
        options: Options(responseType: ResponseType.json));
    final List<Karyawan> karyawanList = [];
    for (var item in response['values']) {
      karyawanList.add(Karyawan.fromJson(item));
    }
    return karyawanList;
  }

  //add karyawan, post to /karyawan/insert
  Future<Karyawan> addKaryawan(Karyawan karyawan) async {
    const url = "/karyawan/insert";
    List<dynamic> karyawanList = [karyawan.toJson()];
    if (kDebugMode) {
      print(jsonEncode(karyawanList));
    }
    final response = await DioClient.instance.post(url,
        data: jsonEncode(karyawanList),
        options: Options(responseType: ResponseType.plain));
    return karyawan;
  }
}

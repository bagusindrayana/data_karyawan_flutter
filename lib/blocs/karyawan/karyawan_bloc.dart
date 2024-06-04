import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_karyawan/models/karyawan.dart';
import 'package:data_karyawan/repositories/karyawan_repository.dart';
import 'package:meta/meta.dart';
part 'karyawan_event.dart';
part 'karyawan_state.dart';

class KaryawanBloc extends Bloc<KaryawanEvent, KaryawanState> {
  final KaryawanRepository karyawanRepository = KaryawanRepository();
  List<Karyawan> currentDatas = <Karyawan>[];

  KaryawanBloc() : super(KaryawanListLoading()) {
    on<KaryawanEvent>((event, emit) {
      if (event is GetKaryawanList) {
        getKaryawanList();
      } else if (event is SearchKaryawan) {
        searchKaryawan(event.query);
      } else if (event is AddKaryawan) {
        addKaryawan(event.karyawan);
      }
    });
  }

  void searchKaryawan(String query) {
    if (query.isEmpty) {
      emit(KaryawanListLoaded(currentDatas));
    } else {
      final List<Karyawan> searchResult = currentDatas
          .where((element) =>
              (element.firstName != null &&
                  element.firstName!
                      .toLowerCase()
                      .contains(query.toLowerCase())) ||
              (element.lastName != null &&
                  element.lastName!
                      .toLowerCase()
                      .contains(query.toLowerCase())) ||
              element.nik
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      emit(KaryawanListLoaded(searchResult));
    }
  }

  void getKaryawanList() async {
    emit(KaryawanListLoading());
    try {
      final karyawanList = await karyawanRepository.getKaryawanList();
      currentDatas = karyawanList;
      emit(KaryawanListLoaded(karyawanList));
    } catch (e) {
      emit(KaryawanListError(e.toString()));
    }
  }

  void addKaryawan(Karyawan karyawan) async {
    print("ADD EVENT");
    emit(KaryawanLoading());
    try {
      final newKaryawan = await karyawanRepository.addKaryawan(karyawan);
      emit(KaryawanLoaded(newKaryawan));
    }
    // on DioException catch (e, t) {
    //   print(e.response?.data.toString());
    //   emit(KaryawanError(e.message.toString()));
    // }
    catch (e, t) {
      var message = e.toString();
      //max 100 character
      if (message.length > 50) {
        message = message.substring(0, 100) + "...";
      }
      emit(KaryawanError(message));
    }
  }
}

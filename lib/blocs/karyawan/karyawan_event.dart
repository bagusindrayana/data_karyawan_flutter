part of 'karyawan_bloc.dart';

@immutable
sealed class KaryawanEvent {}

final class GetKaryawan extends KaryawanEvent {}

final class GetKaryawanList extends KaryawanEvent {}

final class SearchKaryawan extends KaryawanEvent {
  final String query;

  SearchKaryawan(this.query);
}

final class AddKaryawan extends KaryawanEvent {
  final Karyawan karyawan;

  AddKaryawan(this.karyawan);
}

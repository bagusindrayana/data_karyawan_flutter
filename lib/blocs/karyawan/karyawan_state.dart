part of 'karyawan_bloc.dart';

@immutable
sealed class KaryawanState {}

final class KaryawanInitial extends KaryawanState {}

final class KaryawanLoading extends KaryawanState {}

final class KaryawanLoaded extends KaryawanState {
  final Karyawan karyawan;

  KaryawanLoaded(this.karyawan);
}

final class KaryawanError extends KaryawanState {
  final String message;

  KaryawanError(this.message);
}

//list karyawan
final class KaryawanListLoading extends KaryawanState {}

final class KaryawanListLoaded extends KaryawanState {
  final List<Karyawan> karyawanList;

  KaryawanListLoaded(this.karyawanList);
}

final class KaryawanListError extends KaryawanState {
  final String message;

  KaryawanListError(this.message);
}

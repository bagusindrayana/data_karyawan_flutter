import 'package:data_karyawan/pages/add_page.dart';
import 'package:flutter/material.dart';
import 'package:data_karyawan/models/karyawan.dart';
import 'package:data_karyawan/blocs/karyawan/karyawan_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  KaryawanBloc karyawanBloc = KaryawanBloc();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //listview with bloc and refresh indicator
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        centerTitle: true,
        title: Column(
          children: [
            const Text('Data Karyawan'),
            SizedBox(
              height: 8,
            ),
            //search bar
            TextField(
              controller: searchController,
              autofocus: false,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                karyawanBloc.add(SearchKaryawan(value));
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  hintText: 'Cari data karyawan...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.search)),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => karyawanBloc..add(GetKaryawanList()),
        child: BlocBuilder<KaryawanBloc, KaryawanState>(
          builder: (context, state) {
            if (state is KaryawanListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is KaryawanListLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  karyawanBloc.add(GetKaryawanList());
                },
                child: ListView.builder(
                  itemCount: state.karyawanList.length,
                  itemBuilder: (context, index) {
                    final Karyawan karyawan = state.karyawanList[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            child: Text("${karyawan.getInitials()}"),
                          ),
                          title: Text(
                            "${karyawan.firstName} ${karyawan.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NIK : ${karyawan.nik}"),
                              Text("Alamat : ${karyawan.alamat}")
                            ],
                          ),
                          trailing: karyawan.aktif == true
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                        ),
                        Divider()
                      ],
                    );
                  },
                ),
              );
            } else if (state is KaryawanListError) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      karyawanBloc.add(GetKaryawanList());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ));
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          //open AddPage
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => AddPage(),
          ))
              .then((value) {
            if (value == true) {
              searchController.text = '';
              karyawanBloc.add(GetKaryawanList());
            }
          });
        },
      ),
    );
  }
}

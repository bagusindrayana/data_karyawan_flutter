import 'package:flutter/material.dart';
import 'package:data_karyawan/models/karyawan.dart';
import 'package:data_karyawan/blocs/karyawan/karyawan_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  KaryawanBloc karyawanBloc = KaryawanBloc();
  TextEditingController nikController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  bool aktif = false;

  final formKey = GlobalKey<FormState>();

  void addKaryawan() {
    final karyawan = Karyawan(
      nik: int.parse(nikController.text),
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      alamat: alamatController.text,
      aktif: aktif,
    );
    karyawanBloc.add(AddKaryawan(karyawan));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //form and input with validatoin nik min 16, required firstname, lastname and alamat
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Karyawan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocProvider(
            create: (context) => karyawanBloc,
            child: BlocListener<KaryawanBloc, KaryawanState>(
              listener: (context, state) {
                if (state is KaryawanError) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Container(
                        height: 225,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Lottie.asset('assets/lottie/error.json',
                                repeat: false, width: 150, height: 150),
                            Expanded(
                                child: Column(
                              children: [
                                Wrap(children: [
                                  Text(
                                    state.message,
                                  ),
                                ])
                              ],
                            ))
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is KaryawanLoaded) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Container(
                        height: 225,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Lottie.asset('assets/lottie/success.json',
                                repeat: false, width: 75, height: 75),
                            Text('Data berhasil di tambah'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();

                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: BlocBuilder<KaryawanBloc, KaryawanState>(
                  builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: state is! KaryawanLoading,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        controller: nikController,
                        decoration: InputDecoration(
                          labelText: 'NIK',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter NIK';
                          }
                          // if (value.length < 16) {
                          //   return 'NIK must be at least 16 characters';
                          // }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: state is! KaryawanLoading,
                        autofocus: false,
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Depan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: state is! KaryawanLoading,
                        autofocus: false,
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Belakang',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: state is! KaryawanLoading,
                        autofocus: false,
                        controller: alamatController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Alamat';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SwitchListTile(
                        title: Text("Karyawan Aktif?"),
                        // This bool value toggles the switch.
                        value: aktif,
                        activeColor: Colors.blue,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            aktif = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(16)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.blue,
                                  )),
                              onPressed: () {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate() &&
                                    state is! KaryawanLoading) {
                                  print("Add Karyawan");
                                  addKaryawan();
                                }
                              },
                              child: (state is KaryawanLoading)
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'Simpan',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

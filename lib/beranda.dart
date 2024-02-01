import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registrasi_klaim_app/widgets/formulir_card.dart';
import 'package:registrasi_klaim_app/widgets/formulir_klaim.dart';

import 'models/dropdown_provinsi.dart';
import 'models/formulir.dart';
import 'pages/formulir_details/formulir_details.dart';
import 'utils/md_app_colors.dart';
import 'package:http/http.dart' as http;

class Beranda extends StatefulWidget {
  final String title;
  final List<Formulir> formulir;
  final List<String> enabledProvince;
  final String initialSelection;

  const Beranda({
    super.key,
    required this.title,
    required this.formulir,
    required this.enabledProvince,
    required this.initialSelection,
  });

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String dropdownValue = "Pilih Provinsi";
  String dropdownValueKota = "Pilih Kota";
  String dropdownValueKecamatan = "Pilih Kecamatan";
  String dropdownValueKelurahan = "Pilih Kelurahan";
  late PageController _pageController;
  double _page = 0;

  late DropdownProvinsi selectedItem;
  List<DropdownProvinsi> itemList = [];

  Future<List<DropdownProvinsi>> getPostProvince() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
      //"https://raw.githubusercontent.com/nobelleon/Json/main/provinsi.json?token=GHSAT0AAAAAACNSPO667AU7R6EQQWWDCKWUZNZ747A"));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownProvinsi(
              userId: map["userId"], id: map['id'], title: map["id"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  // Future<List<DropdownProvinsi>> _fetchProvinsiData() async {
  //   var list =
  //       await DefaultAssetBundle.of(context).loadString('nJson/provinsi.json');
  //   List<dynamic> jsonList = json.decode(list);

  //   List<DropdownProvinsi> provinsi =
  //       List<DropdownProvinsi>.generate(jsonList.length, (index) {
  //     Map<dynamic, String> elem = Map<dynamic, String>.from(jsonList[index]);

  //     if (widget.enabledProvince.isEmpty) {
  //       return DropdownProvinsi(userId: "userId", id: "id", title: 'title');
  //     } else if (widget.enabledProvince.contains(elem['title']) ||
  //         widget.enabledProvince.contains(elem['title'])) {
  //       return DropdownProvinsi(userId: "userId", id: "id", title: 'title');
  //     } else {
  //       return DropdownProvinsi(userId: "", id: "", title: "");
  //     }
  //   });

  //   return provinsi;
  // }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .75);
    _pageController.addListener(onScroll);

    // _fetchProvinsiData().then((list) {
    //   DropdownProvinsi preSelectedItem;

    //   if (widget.initialSelection != null) {
    //     preSelectedItem = list.firstWhere(
    //         (e) =>
    //             (e.id.toUpperCase() == widget.initialSelection.toUpperCase()) ||
    //             (e.title == widget.initialSelection.toString()),
    //         orElse: () => list[0]);
    //   } else {
    //     preSelectedItem = list[0];
    //   }

    //   setState(() {
    //     itemList = list;
    //     selectedItem = preSelectedItem;
    //   });
    // });
  }

  void onScroll() {
    setState(() {
      _page = _pageController.page!;
    });
  }

  void openDetails(Formulir formulir) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, animation, animation2) {
          return FadeTransition(
            opacity: animation,
            child: FormulirDetails(
              title: widget.title,
              formulir: formulir,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Registrasi Klaim',
          style: TextStyle(color: Colors.blue),
        ),
        leading: const BackButton(
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormulirKlaim(title: "", formulir: nFormulir),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.3), //Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.article,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Registrasi Klaim: B 1234 EFG',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              height: 340,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 208, 208)
                    .withOpacity(.3), //Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'No. Polisi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'B 1234 EFG',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'Nama Tertanggung',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Fajar Pribadi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'No. Polis',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'VCL2007001',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'Periode',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '1/07/20 - 30/06/2021',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'Nilai Pertanggungan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Rp.120.000.000,-',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'Buatan/Merk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Jepang / Honda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'Tahun Pembuatan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '2019',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'No. Mesin',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'NHX120000',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            'No.Rangka',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'MCM24000',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //------------------------------------------------------------------------------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 420,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 208, 208)
                    .withOpacity(.3), //Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Column(
                    children: const <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Pengemudi',
                          labelText: 'Nama Pengemudi',
                          labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 69.0),
                        child: Column(
                          children: [
                            //-----------
                            // Provinsi
                            //-----------
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Pilih Provinsi',
                                  child: Text(
                                    "Pilih Provinsi",
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Nanggroe Aceh Darussalam',
                                  child: Text(
                                    "Nanggroe Aceh Darussalam",
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Bengkulu',
                                  child: Text(
                                    "Bengkulu",
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Sumatera Utara',
                                  child: Text(
                                    "Sumatera Utara",
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Sumatera Selatan',
                                  child: Text(
                                    "Sumatera Selatan",
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Riau',
                                  child: Text(
                                    "Riau",
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                            //-------
                            // Kota
                            //-------
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 1.0, right: 100),
                              child: DropdownButton<String>(
                                value: dropdownValueKota,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Pilih Kota',
                                    child: Text(
                                      "Pilih Kota",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Banda Aceh',
                                    child: Text(
                                      "Banda Aceh",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Bengkulu',
                                    child: Text(
                                      "Bengkulu",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Medan',
                                    child: Text(
                                      "Medan",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Palembang',
                                    child: Text(
                                      "Palembang",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Pekanbaru',
                                    child: Text(
                                      "Pekanbaru",
                                    ),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueKota = newValue!;
                                  });
                                },
                              ),
                            ),
                            //----------
                            // Kecamatan
                            //-----------
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 1.0, right: 70),
                              child: DropdownButton<String>(
                                value: dropdownValueKecamatan,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Pilih Kecamatan',
                                    child: Text(
                                      "Pilih Kecamatan",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Ciputat',
                                    child: Text(
                                      "Ciputat",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Pamulang',
                                    child: Text(
                                      "Pamulang",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Pondok Aren',
                                    child: Text(
                                      "Pondok Aren",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Setu',
                                    child: Text(
                                      "Setu",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Serpong',
                                    child: Text(
                                      "Serpong",
                                    ),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueKecamatan = newValue!;
                                  });
                                },
                              ),
                            ),
                            //----------
                            // Kelurahan
                            //-----------
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 1.0, right: 70),
                              child: DropdownButton<String>(
                                value: dropdownValueKelurahan,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Pilih Kelurahan',
                                    child: Text(
                                      "Pilih Kelurahan",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Palmerah',
                                    child: Text(
                                      "Palmerah",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Meruya Selatan',
                                    child: Text(
                                      "Meruya Selatan",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Slipi',
                                    child: Text(
                                      "Slipi",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Kebon Jeruk',
                                    child: Text(
                                      "Kebun Jeruk",
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Kedoya Selatan',
                                    child: Text(
                                      "Kedoya Selatan",
                                    ),
                                  ),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueKelurahan = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 258.0),
                    child: Column(
                      children: const <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Silahkan isi hubungan tertanggung',
                            labelText: 'Silahkan isi hubungan tertanggung',
                            labelStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 318.0),
                    child: Column(
                      children: const <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Silahkan isi penyebab',
                            labelText: 'Silahkan isi penyebab',
                            labelStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     FutureBuilder<List<DropdownProvinsi>>(
                  //       future: getPostProvince(),
                  //       builder: (context, snapshot) {
                  //         if (snapshot.hasData) {
                  //           return DropdownButton(
                  //             isExpanded: true,
                  //             hint: const Text("Pilih Provinsi"),
                  //             items: snapshot.data!.map((e) {
                  //               return DropdownMenuItem(
                  //                   value: e.id.toString(),
                  //                   child: Text(e.id.toString()));
                  //             }).toList(),
                  //             onChanged: (value) {},
                  //           );
                  //         } else if (snapshot.hasError) {
                  //           // add this block for error handling
                  //           return Text("Error:${snapshot.error} ");
                  //         } else {
                  //           return const CircularProgressIndicator();
                  //         }
                  //       },
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

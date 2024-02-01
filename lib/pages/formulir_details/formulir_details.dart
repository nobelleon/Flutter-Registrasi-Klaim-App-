import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registrasi_klaim_app/models/formulir.dart';

bool toggle = true;
bool toggleKTPTertanggung = true;
bool toggleTambahFoto = true;

class FormulirDetails extends StatefulWidget {
  final String title;
  final Formulir formulir;

  const FormulirDetails(
      {super.key, required this.title, required this.formulir});

  @override
  State<FormulirDetails> createState() => _FormulirDetailsState();
}

class _FormulirDetailsState extends State<FormulirDetails>
    with TickerProviderStateMixin {
  late AnimationController _controller, _controller1, _controller2;
  late Animation _animation, _animation1, _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        reverseDuration: Duration(milliseconds: 275));

    _controller1 = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        reverseDuration: Duration(milliseconds: 275));

    _controller2 = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        reverseDuration: Duration(milliseconds: 275));

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _animation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller1.addListener(() {
      setState(() {});
    });

    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Alignment alignment1 = const Alignment(0.0, 0.0);
  Alignment alignment2 = const Alignment(0.0, 0.0);

  double size1 = 50.0;
  double size2 = 50.0;

  File? image;
  File? imageKTPTertanggung;
  File? imageTambahanFoto;
  File? imageKamera;

  // Take Image STNK from gallery
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Gagal mengambil image: $e');
    }
  }

  // Take Image KTP from gallery
  Future pickImageKTP(ImageSource source) async {
    try {
      final imageKTPTertanggung = await ImagePicker().pickImage(source: source);

      if (imageKTPTertanggung == null) return;

      final imageTemporary1 = File(imageKTPTertanggung.path);
      setState(() => this.imageKTPTertanggung = imageTemporary1);
    } on PlatformException catch (e) {
      print('Gagal mengambil image: $e');
    }
  }

  // Take Image Tambahan from gallery
  Future pickImageTambahanFoto() async {
    try {
      final imageTambahanFoto =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageTambahanFoto == null) return;

      final imageTemporary2 = File(imageTambahanFoto.path);
      setState(() => this.imageTambahanFoto = imageTemporary2);
    } on PlatformException catch (e) {
      print('Gagal mengambil image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const tweeDuration = Duration(milliseconds: 900);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            _appBar(tweeDuration, size),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                duration: tweeDuration,
                tween: Tween(begin: 1, end: 0),
                curve: Curves.easeOut,
                builder: (context, value, _) {
                  return Transform.translate(
                    offset: Offset(0, 500 * value),
                    child: Container(
                      height: size.height * .6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 18.0),
                          child: Stack(
                            children: [
                              const Flexible(
                                child: Text(
                                  'Foto SIM',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 18.0, top: 25.0),
                                child: Container(
                                  child: Image.asset("assets/images/SIM A.png"),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 241.0),
                                child: Flexible(
                                  child: Text(
                                    '* Data Pada SIM harus terlihat jelas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              //------------
                              // FOTO STNK
                              //------------
                              const Padding(
                                padding: EdgeInsets.only(top: 298.0),
                                child: Flexible(
                                  child: Text(
                                    'Foto STNK',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              //------------------
                              // UPLOAD FOTO STNK
                              //------------------
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 318.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0.0,
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 20,
                                  ),
                                  height: 240,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //------------------
                                  // UPLOAD FOTO STNK
                                  //------------------
                                  child: Stack(
                                    children: [
                                      //------
                                      // Foto
                                      //------
                                      AnimatedAlign(
                                        duration: toggle
                                            ? const Duration(microseconds: 275)
                                            : const Duration(milliseconds: 875),
                                        alignment: alignment1,
                                        curve: toggle
                                            ? Curves.easeIn
                                            : Curves.elasticOut,
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 275,
                                          ),
                                          curve: toggle
                                              ? Curves.easeIn
                                              : Curves.easeOut,
                                          height: size1,
                                          width: size1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.image,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              pickImage(ImageSource.gallery);
                                            },
                                          ),
                                        ),
                                      ),
                                      //---------
                                      // Kamera
                                      //---------
                                      AnimatedAlign(
                                        duration: toggle
                                            ? const Duration(microseconds: 275)
                                            : const Duration(milliseconds: 875),
                                        alignment: alignment2,
                                        curve: toggle
                                            ? Curves.easeIn
                                            : Curves.elasticOut,
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 275,
                                          ),
                                          curve: toggle
                                              ? Curves.easeIn
                                              : Curves.easeOut,
                                          height: size2,
                                          width: size2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              pickImage(ImageSource.camera);
                                            },
                                          ),
                                        ),
                                      ),
                                      //-------------------------------------------------------------
                                      image != null
                                          ? Image.file(
                                              image!,
                                              width: 330,
                                              height: 330,
                                              fit: BoxFit.cover,
                                            )
                                          : UploadFotoSTNK(),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 578.0),
                                child: Flexible(
                                  child: Text(
                                    '* Data Pada STNK harus terlihat jelas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              //----------------------
                              // FOTO KTP Tertanggung
                              //----------------------
                              const Padding(
                                padding: EdgeInsets.only(top: 638.0),
                                child: Flexible(
                                  child: Text(
                                    'Foto KTP Tertanggung',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 658.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  height: 240,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //-----------------------------
                                  // UPLOAD FOTO KTP Tertanggung
                                  //-----------------------------
                                  child: Stack(
                                    children: [
                                      //-------
                                      // Foto
                                      //-------
                                      AnimatedAlign(
                                        duration: toggleKTPTertanggung
                                            ? const Duration(microseconds: 275)
                                            : const Duration(milliseconds: 875),
                                        alignment: alignment1,
                                        curve: toggleKTPTertanggung
                                            ? Curves.easeIn
                                            : Curves.elasticOut,
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 275,
                                          ),
                                          curve: toggleKTPTertanggung
                                              ? Curves.easeIn
                                              : Curves.easeOut,
                                          height: size1,
                                          width: size1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.image,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              pickImageKTP(ImageSource.gallery);
                                            },
                                          ),
                                        ),
                                      ),
                                      //--------
                                      // Kamera
                                      //--------
                                      AnimatedAlign(
                                        duration: toggleKTPTertanggung
                                            ? const Duration(microseconds: 275)
                                            : const Duration(milliseconds: 875),
                                        alignment: alignment2,
                                        curve: toggleKTPTertanggung
                                            ? Curves.easeIn
                                            : Curves.elasticOut,
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 275,
                                          ),
                                          curve: toggleKTPTertanggung
                                              ? Curves.easeIn
                                              : Curves.easeOut,
                                          height: size2,
                                          width: size2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              40.0,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              pickImageKTP(ImageSource.camera);
                                            },
                                          ),
                                        ),
                                      ),
                                      imageKTPTertanggung != null
                                          ? Image.file(
                                              imageKTPTertanggung!,
                                              width: 330,
                                              height: 330,
                                              fit: BoxFit.cover,
                                            )
                                          : UploadFotoKTP(),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 918.0),
                                child: Flexible(
                                  child: Text(
                                    '* Data Pada KTP Tertanggung harus terlihat jelas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              //------------------
                              // FOTO KERUSAKAN 1
                              //------------------
                              Padding(
                                padding: const EdgeInsets.only(top: 977.0),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.car_crash,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Foto Kerusakan 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 998.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //------------------
                                  // FOTO Kerusakan 1
                                  //------------------
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 55.0, left: 0.0, top: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 88.0, left: 10.0),
                                              child: Container(
                                                child: Image.asset(
                                                    "assets/images/Kerusakan 1.png"),
                                                width: 150,
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.blue,
                                                    size: 78,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //---------------------
                              // Deskripsi Kerusakan
                              //---------------------
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1168.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: const <Widget>[
                                      TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          hintText: "Deskripsi Kerusakan",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //------------------
                              // FOTO KERUSAKAN 2
                              //------------------
                              Padding(
                                padding: const EdgeInsets.only(top: 1377.0),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.car_crash,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Foto Kerusakan 2',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1398.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //------------------
                                  // FOTO Kerusakan 1
                                  //------------------
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 55.0, left: 0.0, top: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 88.0, left: 10.0),
                                              child: Container(
                                                child: Image.asset(
                                                    "assets/images/Kerusakan 2.png"),
                                                width: 150,
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.blue,
                                                    size: 78,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //---------------------
                              // Deskripsi Kerusakan
                              //---------------------
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1569.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  height: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: const <Widget>[
                                      TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          hintText: "Deskripsi Kerusakan",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //-------------
                              // Tambah Foto
                              //-------------
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1741.0, right: 15.0),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 1),
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    //-------------
                                    // TAMBAH FOTO
                                    //-------------
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 90.0,
                                                left: 60.0,
                                                top: 0.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                      splashColor: Colors.blue,
                                                      splashRadius: 31.0,
                                                      icon: const Icon(
                                                        Icons.add_circle,
                                                        color: Colors.blue,
                                                        size: 48,
                                                      ),
                                                      onPressed: () {
                                                        pickImageTambahanFoto();
                                                      },
                                                    ),
                                                  ),
                                                  const Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15.0),
                                                      child: Text(
                                                        'Tambah Foto',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1831.0, right: 15.0),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //--------
                                  // SIMPAN
                                  //--------
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 70.0,
                                          left: 70.0,
                                          top: 0.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20.0),
                                                child: Text(
                                                  'Simpan',
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              bottom: size.height * .61,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
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
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 0.0, top: 18.0),
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
                      padding: const EdgeInsets.only(
                          right: 0.0, left: 1.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Flexible(
                            child: Text(
                              'No.Polis',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column UploadFotoKTP() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 45.0, left: 35.0, top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: _animation1.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggleKTPTertanggung ? 130.0 : 120.0,
                  width: toggleKTPTertanggung ? 130.0 : 120.0,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: Colors.blue,
                      splashRadius: 31.0,
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                        size: 78,
                      ),
                      onPressed: () {
                        setState(() {
                          if (toggleKTPTertanggung) {
                            toggleKTPTertanggung = !toggleKTPTertanggung;
                            _controller1.forward();
                            Future.delayed(const Duration(milliseconds: 10),
                                () {
                              alignment1 = const Alignment(-0.7, -0.4);
                            });
                            Future.delayed(const Duration(milliseconds: 10),
                                () {
                              alignment2 = const Alignment(0.7, -0.4);
                            });
                          } else {
                            toggleKTPTertanggung = !toggleKTPTertanggung;
                            _controller1.reverse();
                            alignment1 = const Alignment(
                              0.0,
                              0.0,
                            );
                            alignment2 = const Alignment(
                              0.0,
                              0.0,
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 0.0,
            left: 55.0,
            top: 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Flexible(
                child: Text(
                  'Upload Foto KTP Tertanggung',
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
    );
  }

  Column UploadFotoSTNK() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            right: 45.0,
            left: 35.0,
            top: 25.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggle ? 130.0 : 120.0,
                  width: toggle ? 130.0 : 120.0,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                        splashColor: Colors.blue,
                        splashRadius: 31.0,
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 78,
                        ),
                        onPressed: () {
                          setState(() {
                            if (toggle) {
                              toggle = !toggle;
                              _controller.forward();
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                alignment1 = const Alignment(-0.7, -0.4);
                              });
                              size1 = 50.0;
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                alignment2 = const Alignment(0.7, -0.4);
                              });
                              size2 = 50.0;
                            } else {
                              toggle = !toggle;
                              _controller.reverse();
                              alignment1 = const Alignment(
                                0.0,
                                0.0,
                              );
                              alignment2 = const Alignment(
                                0.0,
                                0.0,
                              );
                              size1 = size2 = 20.0;
                            }
                          });
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0.0, left: 95.0, top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Flexible(
                child: Text(
                  'Upload Foto STNK',
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
    );
  }

  TweenAnimationBuilder<double> _appBar(Duration tweeDuration, Size size) {
    return TweenAnimationBuilder<double>(
      duration: tweeDuration,
      tween: Tween(begin: 1, end: 0),
      curve: Curves.easeOut,
      builder: (context, double value, _) {
        return Transform.translate(
          offset: Offset(0, -500 * value),
          child: Container(
            height: size.height * .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.blueGrey.withOpacity(.3),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.chevron_left)),
                        Text(widget.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert_outlined)),
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.threesixty_rounded),
              ],
            ),
          ),
        );
      },
    );
  }
}

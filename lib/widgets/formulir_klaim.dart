import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/formulir.dart';
import '../pages/formulir_details/formulir_details.dart';
import 'formulir_card.dart';

class FormulirKlaim extends StatefulWidget {
  final String title;
  final List<Formulir> formulir;

  FormulirKlaim({
    super.key,
    required this.title,
    required this.formulir,
  });

  @override
  State<FormulirKlaim> createState() => _FormulirKlaimState();
}

class _FormulirKlaimState extends State<FormulirKlaim> {
  late PageController _pageController;
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .75);
    _pageController.addListener(onScroll);
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: FormulirCard.height,
      child: PageView(
        controller: _pageController,
        children: List.generate(
          widget.formulir.length,
          (index) => Transform.scale(
            scale: lerpDouble(1, .9, (_page - index).abs()),
            child: FormulirCard(
              formulir: widget.formulir[index],
              onTap: () => openDetails(widget.formulir[index]),
            ),
          ),
        ),
      ),
    );
  }
}

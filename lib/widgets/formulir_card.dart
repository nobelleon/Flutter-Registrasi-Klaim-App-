import 'package:flutter/material.dart';
import 'package:registrasi_klaim_app/models/formulir.dart';

class FormulirCard extends StatefulWidget {
  static const double height = 200;

  final Formulir formulir;
  final VoidCallback? onTap;

  const FormulirCard({super.key, required this.formulir, this.onTap});

  @override
  State<FormulirCard> createState() => _FormulirCardState();
}

class _FormulirCardState extends State<FormulirCard> {
  final animationDuration = const Duration(milliseconds: 1500);
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          animate = !animate;
          if (animate) {
            Future.delayed(animationDuration, () {
              setState(() {
                animate = false;
              });
            });
          }
        });
        Future.delayed(
          const Duration(milliseconds: 600),
          widget.onTap?.call,
        );
      },
      child: SizedBox(
        height: FormulirCard.height,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 16.0,
              bottom: 16.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.cyan[200], //const Color(0xFF192129),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: '${widget.formulir.formulir} \n',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: Hero(
                tag: widget.formulir.formulir,
                child: TweenAnimationBuilder<double>(
                  key: Key(animate.toString()),
                  duration: animationDuration,
                  tween: Tween(begin: animate ? 0 : 1, end: 1),
                  builder: (context, double value, _) {
                    return Transform.scale(
                      scale: (2 - const ElasticOutCurve(.5).transform(value))
                          .clamp(.8, 1),
                      child: Image.asset(
                        widget.formulir.image,
                        height: FormulirCard.height - 70,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

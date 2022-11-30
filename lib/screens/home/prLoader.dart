import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tirtham/constants.dart';

class PrLoader extends StatefulWidget {
  const PrLoader({super.key});

  @override
  State<PrLoader> createState() => _PrLoaderState();
}

class _PrLoaderState extends State<PrLoader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width*0.7,
              child: TextLiquidFill(
                text: 'tirtham',
                waveColor: kPrimaryColor,
                boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                textStyle: TextStyle(
                  fontSize: 56.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 300.0,
              ),
            ),
            CircularProgressIndicator(
              color: kPrimaryColor,
              strokeWidth: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}

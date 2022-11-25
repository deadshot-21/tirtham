import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tirtham/constants.dart';

class WaterQuality extends StatefulWidget {
  const WaterQuality({super.key, required this.lat, required this.long});
  final double lat;
  final double long;
  @override
  State<WaterQuality> createState() => _WaterQualityState();
}

class _WaterQualityState extends State<WaterQuality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Water quality')), body: Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Text('latitude: ${widget.lat.toString()}\nlongitude: ${widget.long.toString()}'),
    ));
}
}
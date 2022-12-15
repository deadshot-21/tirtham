import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tirtham/constants.dart';

class WaterQuality extends StatefulWidget {
  const WaterQuality(
      {super.key, required this.lat, required this.long, required this.res});
  final double lat;
  final double long;
  final Map res;
  @override
  State<WaterQuality> createState() => _WaterQualityState();
}

class _WaterQualityState extends State<WaterQuality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tirtham results')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Geo location',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'latitude: ${widget.lat.toString()}\nlongitude: ${widget.long.toString()}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Predictions',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Chlorophyll: ${widget.res['predicted_chl']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Calculations',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Total absorption coefficient (443): ${widget.res['calculated_vars']['a443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Total backscattering coefficient (443): ${widget.res['calculated_vars']['b443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Wavelength: ${widget.res['calculated_vars']['w']} nm',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (443): ${widget.res['calculated_vars']['R443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Below surface reflectance (443): ${widget.res['calculated_vars']['r443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Seawater absorption coefficient (443): ${widget.res['calculated_vars']['aw443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Seawater backscattering coefficient (443): ${widget.res['calculated_vars']['bw443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Satellite data',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (412): ${widget.res['satellite_data']['R412']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (443): ${widget.res['satellite_data']['R443']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (488): ${widget.res['satellite_data']['R488']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (550): ${widget.res['satellite_data']['R550']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Above surface reflectance (667): ${widget.res['satellite_data']['R667']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Date: ${widget.res['satellite_data']['date']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}

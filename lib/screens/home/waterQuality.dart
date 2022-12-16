import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tirtham/constants.dart';
import 'package:tirtham/utils/addressToDict.dart';

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
  String tsi = "";
  String tclass = "";
  String phos = "";
  String sd = "";
  String tdesc = "";
  Map<dynamic, dynamic> addressMap = {
    'city': '',
    'state': '',
    'country': '',
  };

  Future<void> estimate() async {
    double c = double.parse(widget.res['predicted_chl']);

    if (c < 2.6) {
      tsi = "< 30—40";
      tclass = "Oligotrophic or hipotrophic";
      phos = "0—12";
      sd = "> 8—4";
      tdesc =
          "Low in nutrients and not productive in terms of aquatic animal and plant life. It is usually accompanied by an abundance of dissolved oxygen";
    } else if (c < 7.3) {
      tsi = "40—50";
      tclass = "Mesotrophic";
      phos = "12—24";
      sd = "4—2";
      tdesc =
          "Intermediate levels of nutrients, fairly productive in terms of aquatic animal and plant life and showing emerging signs of water quality problems.";
    } else if (c < 56) {
      tsi = "50—70";
      tclass = "Eutrophic";
      phos = "24—96";
      sd = "2—0.5";
      tdesc =
          "Rich in nutrients, very productive in terms of aquatic animal and plant life and showing increasing signs of water quality problems.";
    } else {
      tsi = "50—70";
      tclass = "Eutrophic";
      phos = "24—96";
      sd = "2—0.5";
      tdesc =
          "Very high nutrient concentrations where plant growth is determined by physical factors. Water quality problems are serious and almost continuous.";
    }
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.lat, widget.long);
    addressMap = addressToDict(placemarks);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estimate();
  }

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
                SizedBox(height: 30),
                Text(
                  'City: ${addressMap['city'] == "" ? 'Ocean/Sea' : addressMap['city']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'State: ${addressMap['state']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Country: ${addressMap['country']}',
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
                  'Chlorophyll (μg/L): ${widget.res['predicted_chl']}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'The estimated values are as follows:',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Trophic State Index: ${tsi}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Trophic Class: ${tclass}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Phosphorus (μg/L): ${phos}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Secchi depth (m): ${sd}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'What is ${tclass} water?',
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${tdesc}',
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
                // SizedBox(height: 5),
                // Text(
                //   'Above surface reflectance (412): ${widget.res['satellite_data']['R412']}',
                //   style: TextStyle(
                //     fontSize: 16.0,
                //   ),
                // ),
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

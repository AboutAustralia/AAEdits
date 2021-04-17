import 'package:flutter/material.dart';

class TopPlaceBox extends StatelessWidget {
  final String image;

  final double lat;
  final double long;
  final String locationName;
  final gotoLocation;
  TopPlaceBox(
      {this.lat, this.image, this.long, this.locationName, this.gotoLocation});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(16.0),
              shadowColor: Color(0x802196F3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(image),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(locationName)
                ],
              )),
        ),
      ),
    );
  }
}

Widget myDetailsContainer1(String restaurantName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
            child: Text(
          restaurantName,
          style: TextStyle(
              color: Color(0xff6200ee),
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
        )),
      ),
      SizedBox(height: 5.0),
      Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Text(
            "4.1",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          )),
          Container(
            child: Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
          Container(
            child: Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
          Container(
            child: Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
          Container(
            child: Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
          Container(
            child: Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 15.0,
            ),
          ),
          Container(
              child: Text(
            "(946)",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
            ),
          )),
        ],
      )),
      SizedBox(height: 5.0),
      Container(
          child: Text(
        "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
      )),
      SizedBox(height: 5.0),
      Container(
          child: Text(
        "Closed \u00B7 Opens 17:00 Thu",
        style: TextStyle(
            color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.bold),
      )),
    ],
  );
}

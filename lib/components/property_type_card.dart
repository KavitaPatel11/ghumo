import 'package:flutter/material.dart';

class PropertyTypeCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onpress;
  const PropertyTypeCard({super.key, required this.image, required this.title, required this.subtitle, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          color: Colors.white70,
          elevation: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.28,
                    maxHeight: MediaQuery.of(context).size.width * 0.28,
                  ),
                  child: Image.asset('$image',
                      fit: BoxFit.fill),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        '$title',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,color: Color(0Xff000000),
                          fontStyle: FontStyle.normal
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                      child: Text(
                        '$subtitle',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,color: Color(0Xff9A9A9A),
                          fontStyle: FontStyle.normal
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                child: TextButton(
                    onPressed: onpress,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                      size: 28.0,
                    )),
              ),
              SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:genderize/features/genderize/domain/entities/genderize.dart';

class GenderizeDisplay extends StatelessWidget {
  final Genderize genderize;

  const GenderizeDisplay({Key? key, required this.genderize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          Text(
            genderize.name,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: Center(
            child: SingleChildScrollView(
              child: Text(
                genderize.gender,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ],
      ),
    );
  }
}

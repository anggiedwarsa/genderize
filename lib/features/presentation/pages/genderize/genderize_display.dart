import 'package:flutter/material.dart';
import 'package:genderize/features/domain/entities/genderize/genderize.dart';

class GenderizeDisplay extends StatelessWidget {
  final Genderize genderize;

  const GenderizeDisplay({Key? key, required this.genderize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        children: [
          Text(
            genderize.name ?? '-',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: Center(
            child: SingleChildScrollView(
              child: Text(
                genderize.gender ?? '-',
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:genderize/core/util/country_name.dart';
import 'package:genderize/features/domain/entities/nationalize/nationalize.dart';

class NationalizeDisplay extends StatelessWidget {
  final Nationalize nationalize;

  const NationalizeDisplay({Key? key, required this.nationalize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            nationalize.name,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nationalize.countries?.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Negara : ${CountrName.countyNames['${nationalize.countries?[index].countryId}']}',
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Kemungkinan: ${(nationalize.countries![index].probability * 100).toStringAsFixed(1)}%',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

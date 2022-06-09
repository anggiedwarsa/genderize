import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';

class NationalizeControls extends StatefulWidget {
  const NationalizeControls({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NationalizeControlsState();
}

class _NationalizeControlsState extends State<NationalizeControls> {
  final controller = TextEditingController();
  late String strName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan nama',
          ),
          onChanged: (value) {
            strName = value;
          },
          onSubmitted: (_) {
            getPrediction();
          },
        )
      ],
    );
  }

  void getPrediction() {
    controller.clear();
    context.read<NationalizeBloc>().add(PredictCountryByName(name: strName));
  }
}

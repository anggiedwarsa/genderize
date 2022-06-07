import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/features/genderize/presentation/bloc/genderize_bloc.dart';

class GenderizeControls extends StatefulWidget {
  const GenderizeControls({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenderizeControlsState();
}

class _GenderizeControlsState extends State<GenderizeControls> {
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
    context.read<GenderizeBloc>().add(GetPredictionGender(strName));
  }
}

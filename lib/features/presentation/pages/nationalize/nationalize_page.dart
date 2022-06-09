import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/features/presentation/bloc/nationalize/nationalize_bloc.dart';
import 'package:genderize/features/presentation/pages/nationalize/nationalize_controls.dart';
import 'package:genderize/features/presentation/pages/nationalize/nationalize_display.dart';
import 'package:genderize/features/presentation/widgets/loading_widget.dart';
import 'package:genderize/features/presentation/widgets/message_display.dart';
import 'package:genderize/injection_container.dart';

class NationalizePage extends StatefulWidget {
  const NationalizePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NationalizePage();
}

class _NationalizePage extends State<NationalizePage>
    with AutomaticKeepAliveClientMixin<NationalizePage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: buildBody(context),
    );
  }

  BlocProvider<NationalizeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NationalizeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 5),
              BlocBuilder<NationalizeBloc, NationalizeState>(
                builder: (context, state) {
                  if (state is NationalizeInitial) {
                    return const MessageDisplay(
                      message: 'Ketikkan nama untuk prediksi asal negara',
                    );
                  } else if (state is NationalizeLoading) {
                    return const LoadingWidget();
                  } else if (state is NationalizeLoaded) {
                    return NationalizeDisplay(
                      nationalize: state.nationalize,
                    );
                  } else if (state is NationalizeError) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Placeholder(),
                  );
                },
              ),
              const SizedBox(height: 10),
              const NationalizeControls(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

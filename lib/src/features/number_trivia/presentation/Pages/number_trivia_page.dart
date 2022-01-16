import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/src/core/utils/input_converter.dart';
import 'package:tdd/src/features/number_trivia/data/repositores/number_trivia_repository_impl.dart';
import 'package:tdd/src/features/number_trivia/domain/repositores/number_trivia_repository.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_concrete_number.dart';
import 'package:tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd/src/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:tdd/src/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:tdd/src/features/number_trivia/presentation/widgets/trivial_control.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Number Trivia"),
        ),
        body: buildBody(context)
    );
  }

  buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) =>serviceLocator<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half

              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  }else if (state is LoadingState) {
                    return LoadingWidget();
                  } else if (state is LoadedState) {
                    return TriviaDisplay(
                      numberTrivia: state.numberTrivial,
                    );
                  }else if (state is ErrorState) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),

              SizedBox(height: 20),
              // Bottom half
              TriviaControls()  ,
            ],
          ),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivial_bloc.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:flutter_clean_architecture_tdd/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => sl<NumberTrivialBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Top Half
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: SingleChildScrollView(
                      child: BlocBuilder<NumberTrivialBloc, NumberTrivialState>(
                        builder: (context, state) {
                          if (state is Empty) {
                            return const MessageDisplay(
                              message: 'Start Searching',
                            );
                          } else if (state is Loading) {
                            return const CircularProgressIndicator();
                          } else if (state is Loaded) {
                            return TrivialDisplay(trivia: state.trivia);
                          } else if (state is Error) {
                            return MessageDisplay(
                              message: state.message,
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Bottom Half
                TrivialControl()
              ],
            ),
          ),
        ),
      ),
    );
  }
}



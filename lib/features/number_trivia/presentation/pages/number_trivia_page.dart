import 'package:flutter/material.dart';
import 'package:tddcleanarchitecturecourse/core/util/input_converter.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart' as redux_states;
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/store.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/widgets/trivia_display.dart';

import '../../../../injection_container.dart';

// TUTORIAL #14

class NumberTriviaPage extends StatelessWidget {

  final Store numberTriviaStore = sl<Store>();
  final GetConcreteNumberTrivia getConcreteNumberTrivia = sl<GetConcreteNumberTrivia>();
  final GetRandomNumberTrivia getRandomNumberTrivia= sl<GetRandomNumberTrivia>();
  final InputConverter inputConverter = sl<InputConverter>();


  @override
  Widget build(BuildContext context) {

    numberTriviaStore.subscribe(buildBody);

    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(),),
    );
  }

  Widget buildBody() {
    print('Page body is build SUCCESSFULLYYYYy');
    return Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _conditionalBuilder(numberTriviaStore.state),
            SizedBox(
              height: 20.0,
            ),
            TriviaControls(
              numberTriviaStore: numberTriviaStore,
            )
          ]),
        ));
  }

  Widget _conditionalBuilder(redux_states.State state) {
    if (state is redux_states.InitialState) {
      return MessageDisplay(
        message: 'Start Searching!',
      );
    } else if (state is redux_states.ErrorState){
      return MessageDisplay(
          message: state.errorMsg);
    } else if (state is redux_states.LoadedState){
      return TriviaDisplay(
          numberTrivia: state.numberTrivia
      );
    } else if (state is redux_states.LoadingState){
      return LoadingWidget();
    }
    return Container();
  }

}



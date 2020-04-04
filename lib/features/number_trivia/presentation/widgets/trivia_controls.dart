import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/bloc/number_trivia_event.dart';

class TriviaControls extends StatelessWidget {

  String inputString;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number'
          ),
          onChanged: (value) {
            inputString = value;
          },
          onSubmitted: (_){
            dispatchConcrete(context);
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed:  () => dispatchConcrete(context),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Get random trivia'),
                onPressed: (){
                  dispatchRandom(context);
                },
              ),),
          ],
        ),
      ],
    );
  }

  void dispatchConcrete(BuildContext context){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputString));
  }
  void dispatchRandom(BuildContext context){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumber());
  }
}
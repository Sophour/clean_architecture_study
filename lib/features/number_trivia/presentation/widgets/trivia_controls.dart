import 'package:flutter/material.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/store.dart';
import 'package:pedantic/pedantic.dart';

class TriviaControls extends StatelessWidget {

  TriviaControls({this.numberTriviaStore});

  String inputString;
  final controller = TextEditingController();
  final Store numberTriviaStore;


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
            dispatchConcrete(numberTriviaStore);
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
                onPressed:  () => dispatchConcrete(numberTriviaStore),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Get random trivia'),
                onPressed: (){
                  dispatchRandom(numberTriviaStore);
                },
              ),),
          ],
        ),
      ],
    );
  }

  Future<void> dispatchConcrete(Store numberTriviaStore) async {
    controller.clear();

    int inputAsInt = await numberTriviaStore.middleware
        .checkCorrectnessOfInput(inputString, numberTriviaStore);

   await numberTriviaStore.middleware
    .requestForConcreteNumberTrivia(inputAsInt, numberTriviaStore);
  }

  Future<void> dispatchRandom(Store numberTriviaStore) async {
    controller.clear();
    await numberTriviaStore.middleware
    .requestForRandomNumberTrivia(numberTriviaStore);
  }
}
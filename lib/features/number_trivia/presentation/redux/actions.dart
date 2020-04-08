import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
class Action extends Equatable{
  Action([List props = const <dynamic>[]]) : super(props);
}

class RequestConcreteNumberTriviaAction extends Action{

  RequestConcreteNumberTriviaAction({ @required this.number}):super([number]);

  final int number;

}
class RequestRandomNumberTriviaAction extends Action{}

class LoadingIsFinishedAction extends Action{
  LoadingIsFinishedAction({ @required this.numberTrivia}):super([numberTrivia]);

  final NumberTriviaModel numberTrivia;
}

class CaughtErrorAction extends Action{

  CaughtErrorAction({ @required  this.errorMessage }) : super([errorMessage]);

  final String errorMessage;

}

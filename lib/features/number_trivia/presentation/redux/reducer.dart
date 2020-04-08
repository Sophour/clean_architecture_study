import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/actions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart';

class NumberTriviaReducer{

  Future<State> call(State currentState, Action action) async{

      if(action is RequestConcreteNumberTriviaAction) {
         return LoadingState();
      }
      else if(action is RequestRandomNumberTriviaAction){
        return LoadingState();
      }
      else if(action is LoadingIsFinishedAction){

        return LoadedState(numberTrivia: action.numberTrivia);
      }
      else if(action is CaughtErrorAction){
        return ErrorState(errorMsg: action.errorMessage);
      }
      else{
        return InitialState();
      }

  }
}
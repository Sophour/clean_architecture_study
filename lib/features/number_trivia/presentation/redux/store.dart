import 'package:tddcleanarchitecturecourse/core/util/input_converter.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/actions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/middleware.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/reducer.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart';
import 'package:meta/meta.dart';

class Store{

  Store( {@required this.middleware} )
      : initialState = InitialState(),
        _state = InitialState(),
          listeners = <Function>[]{
                  print('Store is FUCKING created');
                }

  final State initialState;
  final NumberTriviaReducer reducer = NumberTriviaReducer();
  final Middleware middleware;
  State _state;
  List<Function> listeners;

  State get state => _state;

  Future<void> dispatch(Action action) async {
     _state = await reducer(state, action);
     print('FUUUUUUUUKC kurrent state is $_state');
     listeners.forEach((func)=>func());

  }

  bool subscribe(Function listener)  {
    if (listeners.contains(listener) != true) {
      listeners.add( listener );
      return true;
    }
    return false;
  }

  bool unsubscribe(Function listener)  {
    return listeners.remove(listener);
  }


}
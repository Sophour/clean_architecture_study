import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/actions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/reducer.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/store.dart';

class MockListener extends Mock{
void tListener();
}

void main(){
  Store store;
  NumberTriviaReducer reducer;

  setUp((){
    reducer = NumberTriviaReducer();
    store = Store(
      initialState: InitialState(),
      reducer: reducer,
    );

  });

  group('Testing Store, the order of actions dispatched', (){
    test('should change state to [LoadingState] on [RequestRandomNumberTriviaAction]', () async {
      // act
      await store.dispatch(RequestRandomNumberTriviaAction());
      // assert
      expect(store.state, equals(LoadingState()));
    });

    test('should change state to [LoadedState] on [LoadingIsFinishedAction]', () async {
      // act
      await store.dispatch(LoadingIsFinishedAction());
      // assert
      expect(store.state, equals(LoadedState(numberTrivia: NumberTrivia(number: 666, text: 'foo'))));
    });


    test('should change state to [LoadingState] on [RequestRandomNumberTriviaAction]', () async {
      // act
      await store.dispatch(RequestRandomNumberTriviaAction());
      // assert
      expect(store.state, equals(LoadingState()));
    });


    test('should change state to [ErrorState] on [CaughtErrorAction]', () async {
      // act
      await store.dispatch(CaughtErrorAction(errorMessage: 'Error'));
      // assert
      expect(store.state, equals(ErrorState( errorMsg: 'foobar error')));
    });
  });

  group('Store subscribtion', (){
    final MockListener mockListener = MockListener();
    final Function tListener = mockListener.tListener;

    test('should update listeners list of the Store when a new subscribtion registered', () async {
      // arrange
      store.listeners.clear();
      // act
      await store.subscribe(tListener);
      // assert
      expect(store.listeners, equals([tListener]));
    });

    test('should update listeners list of the Store when a listener has unsubscribed', () async {
      // arrange
      store.listeners.clear();
      store.listeners.add(tListener);
      // act
      await store.unsubscribe(tListener);
      // assert
      expect(store.listeners, equals([]));
    });
  });

  group('Running methods of the listeners on State change', (){

    final MockListener mockListener = MockListener();
    
    test('should call MockListener`s method when the State has changed', () async {
      // arrange
      await store.subscribe(mockListener.tListener);
      // act
      await store.dispatch(RequestRandomNumberTriviaAction());
      // assert
      verify(mockListener.tListener()).called(1);

    });
  });
  
  group('Testing arguments passed in actions', (){
    final int tNumber = 1;
    final NumberTriviaModel tNumberTrivia
      = NumberTriviaModel(number: 1, text: 'Test text');

    test('should contain the right [NumberTrivia] in the [LoadedState] when loading is finished', () async {
        // act
      await store.dispatch(RequestConcreteNumberTriviaAction(number: tNumber));
      await store.dispatch(LoadingIsFinishedAction(numberTrivia: tNumberTrivia));
        // assert
      expect((store.state as LoadedState).numberTrivia, equals(tNumberTrivia));

    });

    test('should contain an error message in the [ErrorState] when error was cought', () async {
      // arrange
      final String tErrorMsg = 'Something went dramaically wrong';
        // act
      await store.dispatch(CaughtErrorAction(errorMessage: tErrorMsg));
      // assert
      expect((store.state as ErrorState).errorMsg, equals(tErrorMsg));

    });
  });
}
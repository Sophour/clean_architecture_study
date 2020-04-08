//import 'package:mockito/mockito.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
//import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/actions.dart';
//import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/reducer.dart';
//import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart';
//import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/store.dart';
//
////class MockStore extends Mock implements Store{}
//class MockReducer extends Mock implements NumberTriviaReducer{}
//
//void main(){
//  //MockStore mockStore;
//  Store store;
//  MockReducer mockReducer;
//  setUp((){
//    //mockStore = MockStore();
//    mockReducer = MockReducer();
//    store = Store(
//      initialState: InitialState(),
//      reducer: mockReducer,
//    );
//  });
//
//  test(
//      'initial state should be [InitialState]', () {
//    //assert
//    expect(store.state, equals(InitialState()));
//  });
//
//  group('reducer', (){
//    int tNumber = 1;
//    NumberTrivia tNumberTrivia = NumberTrivia(number: 1, text: 'Test text');
//
//    test('should call reducer function when store dispatches an action', () async {
//      Action action = Action();
//      // arrange
//      when(store.dispatch(action))
//          .thenAnswer((_) async => mockReducer(store.state, action));
//      // act
//      await store.dispatch(action);
//      // assert
//      verify(store.dispatch(action));
//      verifyNoMoreInteractions(mockReducer);
//    });
//
//    test('should set [LoadingState] when action [RequestConcreteNumberTriviaAction] is dispatched', () async {
//      //arrange
//
//    });
//  });
//
//}
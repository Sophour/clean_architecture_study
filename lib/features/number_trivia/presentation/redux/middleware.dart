import 'package:dartz/dartz.dart';
import 'package:tddcleanarchitecturecourse/core/error/failures.dart';
import 'package:tddcleanarchitecturecourse/core/usecases/usecase.dart';
import 'package:tddcleanarchitecturecourse/core/util/input_converter.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:meta/meta.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/actions.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/states.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/redux/store.dart';
import 'package:pedantic/pedantic.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';


class Middleware{

  Middleware({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  Future<int> checkCorrectnessOfInput(String inputString, Store store) async {

    int result;
    final inputEither =
    inputConverter.stringToUnsignedInteger(inputString);
    inputEither.fold(
            (failure) {
              store.dispatch(CaughtErrorAction(errorMessage: INVALID_INPUT_FAILURE_MESSAGE ));
        },
            (integer) {
          result = integer;
        });
    return result;
  }

  Future<void> requestForConcreteNumberTrivia(int number, Store store) async {
    if(!(store.state is ErrorState)){
      unawaited (store.dispatch(
          RequestConcreteNumberTriviaAction(number: number)));
      final failureOrTrivia = await getConcreteNumberTrivia(Params(number: number));
      unawaited (_eitherLoadedOrErrorState(failureOrTrivia, store));
    }
  }

  Future<void> requestForRandomNumberTrivia(Store store) async {
    if(!(store.state is ErrorState)){
      await store.dispatch(RequestRandomNumberTriviaAction());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      unawaited (_eitherLoadedOrErrorState(failureOrTrivia, store));
    }
  }

  Future<void> _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia, Store store) async{
    unawaited(
        failureOrTrivia.fold(
            (failure) => store.dispatch(CaughtErrorAction(errorMessage: _mapFailureToMessage(failure) )),

            (trivia) => store.dispatch(LoadingIsFinishedAction(numberTrivia: trivia))));
  }

  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
 }


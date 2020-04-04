import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tddcleanarchitecturecourse/core/network/network_info.dart';
import 'package:tddcleanarchitecturecourse/core/util/input_converter.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tddcleanarchitecturecourse/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';


// TUTORIAL #13

// Service locators (sl) are used to create dependency injections,
// to be precise - save us some boilerplate code.
// Before implementing dependency injections we had decoupled modules
// that we had to stitch together
final sl = GetIt.instance;

Future<void> init() async {
  // The method needs to be structured.
  // There it is structured along the call propagation from UI to data layer:


  // Features - Number Trivia
  //// Bloc
  // classes requiring cleanup should never be registered as singletones
  // because app will have many pages, navigation, running streams, i.e. mess we want to dispose()
  sl.registerFactory(() => NumberTriviaBloc(
      concrete: sl.call(), // This call makes serviceLocator
      // search for other registered instances with the type GetConcreteNumberTrivia
      // which we register below
      inputConverter:  sl.call(),
      random:  sl.call()));

  //// Use case
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl.call()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //// Repository
  // PAY ATTENTION. Generic in <> is an interface, but returned type is implementation
  // SO THAT WE CODE NOT TO THE IMPLEMENTATION
  // BUT WE CODE TO THE INTERFACE
  sl.registerLazySingleton<NumberTriviaRepository>(()=> NumberTriviaRepositoryImplementation(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  //// Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
          () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
          () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  // Core stuff
  sl.registerLazySingleton(()=>InputConverter());
  // SAME STUFF WITH THE CODING TO INTERFACES
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(sl()));

  // External (for imported libs)
  final sharedPreferences = await SharedPreferences.getInstance(); // This complication is due to the necessity
  // to instantiate shared preferences by calling getInstance() which is, moreover, asyncronous
  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton(()=> http.Client());
  sl.registerLazySingleton(()=>DataConnectionChecker());
}

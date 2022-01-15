import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositores/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositores/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //! Features - Number Trivia
  //Bloc
  serviceLocator.registerFactory(
    () => NumberTriviaBloc(
      concrete: serviceLocator(),
      random: serviceLocator(),
      inputConverter: serviceLocator(),
    ),
  );

  //useCases
  serviceLocator
      .registerLazySingleton<GetConCreteNumberTrivia>(() => GetConCreteNumberTrivia(serviceLocator()));

  serviceLocator
      .registerLazySingleton<GetRandomNumberTrivia>(() => GetRandomNumberTrivia(serviceLocator()));

  //repositories
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImp(
          remoteDataSource: serviceLocator(),
          localDataSource: serviceLocator(),
          networkInfo: serviceLocator()));

  // //DataSources
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImp(client: serviceLocator()));
  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImp(sharedPreferences: serviceLocator()));

  //! Core
  serviceLocator.registerLazySingleton(() => InputConverter());

  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator
      .registerLazySingleton(() => DataConnectionChecker());
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(serviceLocator()));

  serviceLocator.registerLazySingleton(() => sharedPreferences);
 //! External
}

import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mamyapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mamyapp/features/auth/domain/usecase/log_in.dart';
import 'package:mamyapp/features/auth/domain/usecase/sign_up.dart';
import 'package:mamyapp/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../services/firebase_service.dart';
import '../../features/auth/data/repositories_impl/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart'; 

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // ! Core Services
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService(
    authInstance: sl(),     
    firestoreInstance: sl(), 
  ));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => SignUpUseCase(sl())); 
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerFactory(() => AuthBloc(
    signUpUseCase: sl(),
    loginUseCase: sl(),
  ));
}
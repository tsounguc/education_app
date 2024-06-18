part of 'injection_container.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initMaterial();
  await _initExam();
}

Future<void> _initExam() async {
  serviceLocator
    ..registerFactory(() => ExamCubit(
          getExamQuestions: serviceLocator(),
          getExams: serviceLocator(),
          submitExam: serviceLocator(),
          updateExam: serviceLocator(),
          uploadExam: serviceLocator(),
          getUserCourseExams: serviceLocator(),
          getUserExams: serviceLocator(),
        ))
    ..registerLazySingleton(() => GetExamQuestions(serviceLocator()))
    ..registerLazySingleton(() => GetExams(serviceLocator()))
    ..registerLazySingleton(() => SubmitExam(serviceLocator()))
    ..registerLazySingleton(() => UpdateExam(serviceLocator()))
    ..registerLazySingleton(() => UploadExam(serviceLocator()))
    ..registerLazySingleton(() => GetUserCourseExams(serviceLocator()))
    ..registerLazySingleton(() => GetUserExams(serviceLocator()))
    ..registerLazySingleton<ExamRepo>(() => ExamRepoImpl(serviceLocator()))
    ..registerLazySingleton<ExamRemoteDataSrc>(
      () => ExamRemoteDataSrcImpl(firestore: serviceLocator(), auth: serviceLocator()),
    );
}

Future<void> _initMaterial() async {
  serviceLocator
    ..registerFactory(() => MaterialCubit(addMaterial: serviceLocator(), getMaterials: serviceLocator()))
    ..registerLazySingleton(() => AddMaterial(serviceLocator()))
    ..registerLazySingleton(() => GetMaterials(serviceLocator()))
    ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(serviceLocator()))
    ..registerLazySingleton<MaterialRemoteDataSrc>(
      () => MaterialRemoteDataSrcImpl(
          firestore: serviceLocator(), auth: serviceLocator(), storage: serviceLocator()),
    );
}

Future<void> _initVideo() async {
  serviceLocator
    ..registerFactory(() => VideoCubit(addVideo: serviceLocator(), getVideos: serviceLocator()))
    ..registerLazySingleton(() => AddVideo(serviceLocator()))
    ..registerLazySingleton(() => GetVideos(serviceLocator()))
    ..registerLazySingleton<VideosRepository>(() => VideosRepositoryImpl(serviceLocator()))
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: serviceLocator(), auth: serviceLocator(), storage: serviceLocator()),
    );
}

Future<void> _initCourse() async {
  serviceLocator
    ..registerFactory(
      () => CourseCubit(
        addCourse: serviceLocator(),
        getCourses: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(serviceLocator()))
    ..registerLazySingleton(() => GetCourses(serviceLocator()))
    ..registerLazySingleton<CourseRepository>(
      () => CourseRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: serviceLocator(),
        isUserFirstTimer: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(serviceLocator()))
    ..registerLazySingleton(() => IsUserFirstTimer(serviceLocator()))
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  serviceLocator
    ..registerFactory(
      () => AuthBloc(
        signIn: serviceLocator(),
        signUp: serviceLocator(),
        forgotPassword: serviceLocator(),
        updateUser: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => SignIn(serviceLocator()))
    ..registerLazySingleton(() => SignUp(serviceLocator()))
    ..registerLazySingleton(() => ForgotPassword(serviceLocator()))
    ..registerLazySingleton(() => UpdateUser(serviceLocator()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: serviceLocator(),
        cloudStoreClient: serviceLocator(),
        dbClient: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

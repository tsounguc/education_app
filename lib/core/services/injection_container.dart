import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:education_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';
import 'package:education_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:education_app/features/auth/domain/usecases/sign_in.dart';
import 'package:education_app/features/auth/domain/usecases/sign_up.dart';
import 'package:education_app/features/auth/domain/usecases/update_user.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:education_app/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/features/course/data/repositories_impl/course_repository_impl.dart';
import 'package:education_app/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/features/course/domain/usescases/add_course.dart';
import 'package:education_app/features/course/domain/usescases/get_courses.dart';
import 'package:education_app/features/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:education_app/features/course/features/exams/data/repos/exam_repo_impl.dart';
import 'package:education_app/features/course/features/exams/domain/repos/exam_repo.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/get_exam_questions.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/get_exams.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/get_user_course_exams.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/get_user_exams.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/submit_exam.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/update_exam.dart';
import 'package:education_app/features/course/features/exams/domain/usecases/upload_exam.dart';
import 'package:education_app/features/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/features/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:education_app/features/course/features/materials/data/repos/material_repo_impl.dart';
import 'package:education_app/features/course/features/materials/domain/repos/material_repo.dart';
import 'package:education_app/features/course/features/materials/domain/usecases/add_material.dart';
import 'package:education_app/features/course/features/materials/domain/usecases/get_materials.dart';
import 'package:education_app/features/course/features/materials/presentation/cubit/material_cubit.dart';
import 'package:education_app/features/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:education_app/features/course/features/videos/data/repos/video_repo_impl.dart';
import 'package:education_app/features/course/features/videos/domain/repositories/videos_repository.dart';
import 'package:education_app/features/course/features/videos/domain/usecases/add_video.dart';
import 'package:education_app/features/course/features/videos/domain/usecases/get_videos.dart';
import 'package:education_app/features/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education_app/features/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/features/notifications/data/datasources/notification_remote_data_src.dart';
import 'package:education_app/features/notifications/data/repos/notification_repo_impl.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:education_app/features/notifications/domain/usecases/clear.dart';
import 'package:education_app/features/notifications/domain/usecases/clear_all.dart';
import 'package:education_app/features/notifications/domain/usecases/get_notifications.dart';
import 'package:education_app/features/notifications/domain/usecases/mark_as_read.dart';
import 'package:education_app/features/notifications/domain/usecases/send_notification.dart';
import 'package:education_app/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:education_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/features/on_boarding/domain/usecases/is_user_first_timer.dart';
import 'package:education_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';

import 'package:education_app/core/common/screens/page_under_construction.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:education_app/features/auth/presentation/views/sign_in_screen.dart';
import 'package:education_app/features/auth/presentation/views/sign_up_screen.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/presentation/screens/course_details_screens.dart';
import 'package:education_app/features/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'package:education_app/core/services/router.main.dart';

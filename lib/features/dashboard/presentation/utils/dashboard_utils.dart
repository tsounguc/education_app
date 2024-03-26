import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => serviceLocator<FirebaseFirestore>()
      .collection('users')
      .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map(
        (event) => LocalUserModel.fromMap(event.data()!),
      );
}

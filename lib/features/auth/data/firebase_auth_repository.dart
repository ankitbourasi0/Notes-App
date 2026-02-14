import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_sync/features/auth/domain/models/app_user.dart';
import 'package:notes_app_sync/features/auth/domain/repository/auth_repository.dart';

/*
  Firebase is our backend here, or you can choose any backend here 
  i.e Clean Architecture is scalable and loosly coupled , Auth repository methods can beimplemented byb any backend.
*/

class FirebaseAuthRepository implements AuthRepository {
  //Firebase Access

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser> loginWithEmailPassword(String email, String password) async {
    try {
      //Attempt to sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      //create user
      AppUser user = AppUser(
          uid: userCredential.user!.uid, email: userCredential.user!.email!);
   
    //return user
    return user;
    } catch (e) {
      print(e);
      throw Exception("Login Failed! : $e");
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
     try {
      //Attempt to sign in
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //create user
      AppUser user = AppUser(
          uid: userCredential.user!.uid, email: userCredential.user!.email!);
   
    //return user
    return user;
    } catch (e) {
      print(e);
      throw Exception("Login Failed! : $e");
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      //no logged in user
      if (user == null) {
        throw Exception('No logged in user!');
      }

      //if logged user exist
      await user.delete();
      await logout();
    } catch (e) {
      print("Unable to delete account: $e");
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      //Get User From Firebase
      final user = firebaseAuth.currentUser;

      //no logged in user
      if (user == null) {
        return null;
      }

      //logged in user
      return AppUser(uid: user.uid, email: user.email!);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent successfully! Check your inbox.";
    } catch (e) {
      print(e);
      return "Something went wrong!, Please try again later.";
    }
  }
}

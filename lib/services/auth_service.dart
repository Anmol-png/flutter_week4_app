import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {'success': true, 'message': 'Signed in'};
    } on FirebaseAuthException catch (e) {
      print('Auth signIn error: code=${e.code}, message=${e.message}');
      return {
        'success': false,
        'message': e.message ?? 'Sign in failed',
        'code': e.code,
      };
    } catch (e) {
      print('Auth signIn unexpected error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user?.uid;
      if (uid != null) {
        try {
          await _db.collection('users').doc(uid).set({
            'name': name,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });
        } catch (e) {
          print('Firestore write error for uid=$uid: $e');
          // If Firestore write fails, sign out the created user to avoid partial state
          await _auth.currentUser?.delete().catchError((_) {});
          return {
            'success': false,
            'message': 'Failed to save user profile: $e',
            'code': 'firestore-write-failed',
          };
        }
      }

      return {'success': true, 'message': 'Account created'};
    } on FirebaseAuthException catch (e) {
      print('Auth signUp error: code=${e.code}, message=${e.message}');
      return {
        'success': false,
        'message': e.message ?? 'Sign up failed',
        'code': e.code,
      };
    } catch (e) {
      print('Auth signUp unexpected error: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}

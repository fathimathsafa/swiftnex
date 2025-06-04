import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user with email and password
  // This STORES the email and password in Firebase Authentication
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      // This line creates a new user account in Firebase and stores the credentials
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      
      if (user != null) {
        print("✅ User successfully stored in Firebase!");
        print("📧 Email: ${user.email}");
        print("🆔 User ID: ${user.uid}");
        print("📅 Created: ${user.metadata.creationTime}");
        
        Fluttertoast.showToast(
          msg: "Account created and stored in Firebase!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
      
      return user;
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak (minimum 6 characters).';
          break;
        case 'email-already-in-use':
          message = 'This email is already registered. Try logging in instead.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'Registration failed: ${e.message}';
      }
      
      print("❌ Registration Error: ${e.code} - $message");
      
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      
      return null;
    }
  }

  // Sign in user with email and password
  // This CHECKS the stored credentials in Firebase Authentication
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // This line checks if the email and password match what's stored in Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      
      if (user != null) {
        print("✅ Login successful! User found in Firebase!");
        print("📧 Email: ${user.email}");
        print("🆔 User ID: ${user.uid}");
        print("🕒 Last Sign In: ${user.metadata.lastSignInTime}");
        
        Fluttertoast.showToast(
          msg: "Welcome back! Login successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
      
      return user;
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email. Please register first.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many failed attempts. Please try again later.';
          break;
        default:
          message = 'Login failed: ${e.message}';
      }
      
      print("❌ Login Error: ${e.code} - $message");
      
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      
      return null;
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get all registered users count (for demonstration)
  // Note: This only works for the current user, not all users
  Future<void> checkUserExists(String email) async {
    try {
      List<String> methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        print("✅ Email '$email' is registered in Firebase");
        print("🔑 Available sign-in methods: $methods");
      } else {
        print("❌ Email '$email' is not registered in Firebase");
      }
    } catch (e) {
      print("Error checking user: $e");
    }
  }
}


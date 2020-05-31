import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

enum PhoneAuthState {
  Initialized,
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut,
}

class FirebasePhoneAuth {

  static var phone, actualCode, status, _authCredential;
  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState = StreamController.broadcast();

  static dispose() {
    statusStream.close();
    phoneAuthState.close();
  }

  static init() {
    statusStream.stream.listen((String status) {
      print("PhoneAuthStatus: $status");
    });
  }

  static startAuth({String phoneNumber}) {
    phone = phoneNumber;

    addStatus('Phone Auth Started');
    addState(PhoneAuthState.Started);

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone.toString(),
      timeout: Duration(seconds: 90),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ).then((value) {
      print("Code Sent");
    }).catchError((err) {
      print(err);
    });
  }

  static final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("Code Sent to $phone");
    addState(PhoneAuthState.CodeSent);
  };

  static final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
    actualCode = verificationId;
    addStatus("Auto retrieval timeout");
    addState(PhoneAuthState.AutoRetrievalTimeOut);
  };

  static final PhoneVerificationFailed verificationFailed = (AuthException authException) {
    addStatus('Error: ${authException.message}');
    addState(PhoneAuthState.Error);
    if (authException.message.contains('not authorized'))
      addStatus("App not authorized");
    else if (authException.message.contains('Network'))
      addStatus("Check Network Connection");
    else
      addStatus(authException.message);
  };

  static final PhoneVerificationCompleted verificationCompleted = (AuthCredential auth) {
    addStatus("Auto retrieving verification code");
    FirebaseAuth.instance.signInWithCredential(auth).then((AuthResult result) {
      if (result.user != null) {
        addState(PhoneAuthState.Verified);
        addStatus("Authentication Success");
        onAuthSuccess();
      } else {
        addState(PhoneAuthState.Failed);
        addStatus("Invalid Code");
      }
    }).catchError((err) {
      addState(PhoneAuthState.Error);
      addStatus("Something went wrong $err");
    });
  };

  static void signInWithPhoneNumber({String smsCode}) async {
    _authCredential = PhoneAuthProvider.getCredential(verificationId: actualCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(_authCredential).then((AuthResult result) {
      addState(PhoneAuthState.Verified);
      addStatus("Authentication Successful");
      onAuthSuccess();
    }).catchError((err) {
      addState(PhoneAuthState.Error);
      addStatus("Something went wrong");
    });
  }

  static onAuthSuccess() {
    print("Authentication Success");
  }

  static addState(PhoneAuthState state) {
    phoneAuthState.sink.add(state);
    print(state);
  }

  static addStatus(String s) {
    statusStream.sink.add(s);
    print(s);
  }
}

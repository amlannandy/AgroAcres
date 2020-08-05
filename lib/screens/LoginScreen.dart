import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/FirebasePhoneAuth.dart';
import '../widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  void handlePhoneNumberSubmit() {
    String phoneNumber = _phoneController.text;
    if (phoneNumber.length == 10) {
      phoneNumber = "+91$phoneNumber";
      FirebasePhoneAuth.startAuth(phoneNumber: phoneNumber);
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Phone Number",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  void handleOTPSubmit() {
    String code = _otpController.text;
    print("OTP Submitted $code");
    Fluttertoast.showToast(msg: "Verifying OTP");
    FirebasePhoneAuth.signInWithPhoneNumber(smsCode: code);
  }

  @override
  void initState() {
    FirebasePhoneAuth.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
                stream: FirebasePhoneAuth.phoneAuthState.stream,
                initialData: PhoneAuthState.Initialized,
                builder: (context, snapshot) {
                  if (snapshot.data == PhoneAuthState.Started)
                    return waitingBanner();
                  if (snapshot.data == PhoneAuthState.CodeSent)
                    return otpField();
                  if (snapshot.data == PhoneAuthState.Verified) {
                    new Future.delayed(Duration(milliseconds: 300), () {
                      Navigator.of(context).pushReplacementNamed('/init');
                    });
                    return successBanner();
                  }
                  if (snapshot.data == PhoneAuthState.Error)
                    Fluttertoast.showToast(
                        msg: "Error during validation",
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                  if (snapshot.data == PhoneAuthState.Failed)
                    Fluttertoast.showToast(
                        msg: "Validation failed",
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                  return phoneNumberField();
                }),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                top: 5,
                right: 30,
              ),
              height: 60,
              child: StreamBuilder(
                  stream: FirebasePhoneAuth.phoneAuthState.stream,
                  initialData: PhoneAuthState.Initialized,
                  builder: (ctx, snapshot) {
                    switch (snapshot.data) {
                      case PhoneAuthState.Initialized:
                      case PhoneAuthState.Error:
                      case PhoneAuthState.Failed:
                      case PhoneAuthState.AutoRetrievalTimeOut:
                        return submitButton(context, handlePhoneNumberSubmit);
                      case PhoneAuthState.CodeSent:
                        return submitButton(context, handleOTPSubmit);
                      default:
                        return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
            bottom: 5,
          ),
          child: Text(
            "Sign in",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
            bottom: 5,
          ),
          child: Text(
            "Using your phone number",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        CustomTextField(
          controller: _phoneController,
          icon: Icons.phone,
          labelText: "Your Phone Number",
          numeric: true,
        ),
      ],
    );
  }

  Widget otpField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
            bottom: 5,
          ),
          child: Text(
            "OTP Sent",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
            bottom: 5,
          ),
          child: Text(
            "Waiting for confirmation",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        CustomTextField(
          controller: _otpController,
          icon: Icons.phone_locked,
          labelText: "Enter OTP",
          numeric: true,
        ),
      ],
    );
  }

  Widget waitingBanner() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.green[800]),
      ),
    );
  }

  Widget successBanner() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        FontAwesomeIcons.check,
        size: 100,
        color: Colors.green[800],
      ),
    );
  }

  Widget submitButton(BuildContext ctx, Function callback) {
    return InkWell(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.green[800],
              Colors.green[700],
            ]),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.green[800].withOpacity(0.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: callback,
            child: Center(
              child: Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

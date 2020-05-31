import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/CustomDarkButton.dart';
import '../widgets/CustomTextField.dart';
import '../services/UserInfoProvider.dart';

class UserInfoScreen extends StatelessWidget {

  static const routeName = '/userinfo';

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _aadharController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              pictureContainer(),
              CustomTextField(
                icon: LineIcons.user,
                labelText: "Your Name",
                controller: _nameController,
              ),
              CustomTextField(
                icon: LineIcons.sort_numeric_asc,
                labelText: "Your Age",
                controller: _ageController,
                numeric: true,
              ),
              CustomTextField(
                icon: LineIcons.home,
                labelText: "Your Location",
                controller: _locationController,
              ),
              CustomTextField(
                icon: LineIcons.credit_card,
                labelText: "Your Aadhar Number",
                controller: _aadharController,
                numeric: true,
              ),
              SizedBox(height: 10),
              customDarkButton(
                text: "Submit",
                icon: LineIcons.check_circle,
                onPress: () => UserInfoProvider.uploadUserInfo(
                  context: context,
                  name: _nameController.text,
                  age: _ageController.text,
                  aadharNumber: _aadharController.text,
                  location: _locationController.text,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget pictureContainer() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: UserInfoProvider.currentImageUrl.isEmpty ? Icon(
              LineIcons.user, 
              size: 70,
              color: Colors.green[800],
            ) : Image.network(UserInfoProvider.currentImageUrl),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(
                top: 15,
                bottom: 10,
              ),
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "Add Picture",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
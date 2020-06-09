import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/CustomDarkButton.dart';
import '../widgets/CustomTextField.dart';
import '../services/UserInfoProvider.dart';
import '../widgets/LightIconButton.dart';

class UserInfoScreen extends StatefulWidget {

  static const routeName = '/userinfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _aadharController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            children: <Widget>[
              pictureContainer(context),
              SizedBox(height: 40),
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
              SizedBox(height: 30),
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

  showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        titlePadding: const EdgeInsets.all(20),
        title: Text(
          "Upload Picture",
          style: TextStyle(
            fontFamily: 'Lato', 
            fontSize: 22,
            color: Colors.green[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.camera_alt,
              text: "Camera",
              function: () {
                UserInfoProvider.takePicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.filter,
              text: "Gallery",
              function: () {
                UserInfoProvider.uploadPicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      )
    );
  }

  Widget pictureContainer(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 70,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: UserInfoProvider.currentImageUrl.isEmpty ? Icon(
              LineIcons.user, 
              size: 70,
              color: Colors.green[800],
            ) : Container(),
            backgroundImage: UserInfoProvider.currentImageUrl.isEmpty ? null : NetworkImage(UserInfoProvider.currentImageUrl),
          ),
          InkWell(
            onTap: () {
              showUploadDialog(context);
            },
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
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Colors.green[800],
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
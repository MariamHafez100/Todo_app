import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/alert_dialog.dart';
import 'package:todo/authurization/formFieldWidget.dart';
import 'package:todo/authurization/login.dart';
import 'package:todo/dataClass/my_user.dart';
import 'package:todo/firebase_details.dart';
import 'package:todo/homee/home.dart';
import 'package:todo/providers/auth_provider.dart';

class Register extends StatefulWidget {
  static const String routeName = 'RegisterPage';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameCont = TextEditingController(text: 'Mariom');
  var emailCont = TextEditingController(text: 'Mariom@gmail.com');
  var passwordCont = TextEditingController(text: '123456789');
  var confPasswordCont = TextEditingController(text: '123456789');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset("assets/image/auth.png",
              width: double.infinity, fit: BoxFit.fill),
          Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 220,
                      ),
                      Center(
                          child: Text(
                        "SIGN UP",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                      TextFormShape(
                        text: 'USER NAME',
                        controllertext: nameCont,
                        validation: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter your Name';
                          }
                          return null;
                        },
                      ),
                      TextFormShape(
                        text: 'EMAIL',
                        keyboard: TextInputType.emailAddress,
                        controllertext: emailCont,
                        validation: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter your Email';
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'this email is not valid';
                          }
                          return null;
                        },
                      ),
                      TextFormShape(
                          text: 'PASSWORD',
                          controllertext: passwordCont,
                          keyboard: TextInputType.number,
                          validation: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter your Password';
                            }
                            if (text.length < 8) {
                              return 'password should be at least 8 characters';
                            }
                            return null;
                          },
                          secure: TextFormShape.ofsecure,
                          icon: IconButton(
                              onPressed: () {
                                TextFormShape.ofsecure =
                                    !TextFormShape.ofsecure;
                                setState(() {});
                              },
                              icon: Icon(Icons.remove_red_eye))),
                      TextFormShape(
                        text: 'Confirmation Password',
                        controllertext: confPasswordCont,
                        keyboard: TextInputType.number,
                        secure: TextFormShape.ofsecure,
                        validation: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter your password confirmation';
                          }
                          if (text != passwordCont.text) {
                            return 'This password does not match';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Login.routeName);
                          },
                          child: Text(
                            'Already have an account ➜',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      AlertDetails.showLoading(context, 'Please Wait ...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCont.text,
          password: passwordCont.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameCont.text,
            email: emailCont.text);
        await FireBase.addUserToFireStore(myUser);
        var authprovider = Provider.of<AuthProvider>(context, listen: false);
        authprovider.updateUser(myUser);

        AlertDetails.hideLoading(context);
        AlertDetails.showMessage(context, 'Successfully Registered',
            ButtonNameAction: 'OK', actionOfAlert: () {
          Navigator.pushReplacementNamed(context, homescreen.routeName);
        }, mytitle: 'Welcome❤');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AlertDetails.hideLoading(context);
          AlertDetails.showMessage(
              context, 'The password provided is too weak.',
              mytitle: 'Wrong!', ButtonNameAction: 'OK');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AlertDetails.hideLoading(context);
          AlertDetails.showMessage(
              context, 'The account already exists for that email.',
              mytitle: 'Wrong!', ButtonNameAction: 'OK');
          print('The account already exists for that email.');
        }
      } catch (e) {
        AlertDetails.hideLoading(context);
        AlertDetails.showMessage(context, '${e.toString()}',
            mytitle: 'Wrong!', ButtonNameAction: 'OK');
        print(e);
      }
    }
  }
}

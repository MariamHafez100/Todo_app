import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/alert_dialog.dart';
import 'package:todo/authurization/register.dart';
import 'package:todo/firebase_details.dart';
import 'package:todo/homee/home.dart';

import '../providers/auth_provider.dart';
import 'formFieldWidget.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Log_IN';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailCont = TextEditingController(text: 'Mariom@gmail.com');

  var passwordCont = TextEditingController(text: '123456789');

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
                        "LOG IN",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            "LOG IN",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don`t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Register.routeName);
                              },
                              child: Text('Sign Up'))
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      AlertDetails.showLoading(context, 'Please Wait...');
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCont.text,
          password: passwordCont.text,
        );
        var user =
            await FireBase.readUserFromFireStore(credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        var authprovider = Provider.of<AuthProvider>(context, listen: false);
        authprovider.updateUser(user);

        AlertDetails.hideLoading(context);
        AlertDetails.showMessage(
          context,
          'You Logged in Successfully',
          ButtonNameAction: 'OK',
          mytitle: 'Welcome❤',
          actionOfAlert: () {
            Navigator.pushReplacementNamed(context, homescreen.routeName);
          },
        );
        print('log in sucsess');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        //AlertDetails.hideLoading(context);
        //AlertDetails.showMessage(context, 'Wrong',ButtonNameAction: 'OK',mytitle: 'Wrong!');
        if (e.code == 'user-not-found') {
          AlertDetails.hideLoading(context);
          AlertDetails.showMessage(context, 'No user found for that email.',
              ButtonNameAction: 'OK', mytitle: 'Wrong!');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AlertDetails.hideLoading(context);
          AlertDetails.showMessage(
              context, 'Wrong password provided for that user.',
              ButtonNameAction: 'OK', mytitle: 'Wrong!');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        AlertDetails.hideLoading(context);
        AlertDetails.showMessage(context, '${e.toString()}',
            ButtonNameAction: 'OK', mytitle: 'Wrong!');
        print(e.toString());
      }
    }
  }
}

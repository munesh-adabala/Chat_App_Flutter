import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/widget/login_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("Username:${usernameController.text} ");
      print("password:${passwordController.text} ");
      await context.read<AuthService>().loginUser(usernameController.text);
      Navigator.pushReplacementNamed(context, "./chat",
          arguments: usernameController.text);
      print("Logged in success...");
    } else {
      print("Logged in Unsuccessfull");
    }
  }

  @override
  Widget build(BuildContext context) {
    const String uri = "https://android-developers.googleblog.com/";
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Let's sign in!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.fitWidth,
                        image: NetworkImage(
                      'https://picsum.photos/id/1/200/300',
                    )),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LoginTextField(
                          hintText: "Enter your username",
                          formFieldValidator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.length < 5) {
                              return "Username should be morethan 5 characters";
                            } else if (value != null && value.isEmpty) {
                              return "Please type your username";
                            }
                            return null;
                          },
                          textEditingController: usernameController,
                          hideText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LoginTextField(
                            textEditingController: passwordController,
                            hintText: "Password",
                            hideText: true,
                            formFieldValidator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length < 5) {
                                return "Password should be morethan 5 characters";
                              } else if (value != null && value.isEmpty) {
                                return "Please type your Password";
                              }
                              return null;
                            }),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () async {
                      await loginUser(context);
                    },
                    child: const Text("Login")),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Reach us on",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Link clicked");
                        final Uri finalUri = Uri(
                            scheme: 'https',
                            path: 'android-developers.googleblog.com');
                        if (!await launchUrl(finalUri)) {
                          throw Exception('Could not launch $uri');
                        }
                      },
                      child: const Text(
                          "https://android-developers.googleblog.com/"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

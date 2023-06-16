import 'package:demo/const/space_helper.dart';
import 'package:demo/const/widgets/custom_button.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/widgets/text_filed_widgets.dart';
import '../widget/auth_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AuthController>(builder: (context, controller, widget) {
          return Column(children: [
            AuthContainerWidget(size: size, title: "Sign up"),
            Container(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      vSpaceXl,
                      TextFromFieldWidget(
                          hint: "Email",
                          prefixIcon: Icons.email,
                          controller: controller.emailController),
                      vSpaceRegular,
                      TextFromFieldWidget(
                          hint: "Password",
                          prefixIcon: Icons.key,
                          controller: controller.passwordController),
                      vSpaceRegular,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton(
                          hint: Text(
                              controller.dropdowmValue ?? " Select From List"),
                          underline: SizedBox(),
                          isExpanded: true,
                          items: controller.dropdwonList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            controller.changeDropDownValue(value);
                          },
                          onTap: () {},
                        ),
                      ),
                      vSpaceXl,
                      vSpaceXl,
                      controller.loader == false
                          ? LoginButtonWidget(
                              title: "SIGNUP",
                              onTap: () {
                                controller.signup();
                              },
                            )
                          : CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {}, child: Text("Register"))
                          ],
                        ),
                      ),
                    ])))
          ]);
        }),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 80); // Start from the bottom-left corner
    path.quadraticBezierTo(
        0, size.height, 80, size.height); // Curve control point and endpoint
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

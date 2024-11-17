import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget generateTextFormField({
      required String title,
      required TextEditingController controller,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: inter.copyWith(
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      );
    }

    Widget form() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Masuk",
              style: inter.copyWith(
                fontWeight: semiBold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            generateTextFormField(
              title: "Email",
              controller: emailTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            generateTextFormField(
              title: "Password",
              controller: passwordTextField,
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Masuk",
                      style: inter.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: disableColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "atau",
                    style: inter.copyWith(
                      color: disableColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: disableColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Text(
                  "Tidak punya akun?",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                Text(
                  " Register disini",
                  style: inter.copyWith(
                    fontWeight: medium,
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 76,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: disableColor,
                            ))),
                    onPressed: () {},
                    child: Text(
                      "Masuk dengan ID Karyawan",
                      style: inter.copyWith(
                        fontWeight: medium,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 83,
                vertical: 40,
              ),
              child: Image.asset(
                'assets/app logo.png',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            form(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

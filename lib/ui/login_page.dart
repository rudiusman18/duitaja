import 'package:duidku/cubit/auth_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextField = TextEditingController(text: "");
  TextEditingController passwordTextField = TextEditingController(text: "");

  @override
  void initState() {
    context.read<AuthCubit>().autoLogin();
    super.initState();
  }

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
            obscureText: title.toLowerCase() == "password" ? true : false,
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
                    onPressed: () {
                      context.read<AuthCubit>().login(
                            email: emailTextField.text,
                            password: passwordTextField.text,
                          );
                    },
                    child: context.read<AuthCubit>().state is AuthLoading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
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
            Row(
              children: [
                Text(
                  "Tidak punya akun?",
                  style: inter.copyWith(
                    fontWeight: medium,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: Text(
                    " Daftar disini",
                    style: inter.copyWith(
                      fontWeight: medium,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
          ],
        ),
      );
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, loginState) {
        if (loginState is LoginSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, "/main-page");
        } else if (loginState is AuthFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loginState.error,
                style: inter,
              ),
              backgroundColor: Colors.red,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      builder: (context, loginState) {
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
      },
    );
  }
}

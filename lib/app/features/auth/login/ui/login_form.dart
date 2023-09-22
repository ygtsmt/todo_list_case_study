import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo_list_case_study/app/features/auth/login/bloc/phone_auth_bloc.dart';
import 'package:todo_list_case_study/app/features/auth/register/ui/register_screen.dart';
import 'package:todo_list_case_study/app/ui/home_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }

  final String verificationId = "";

  @override
  Widget build(final BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthVerified) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }

        if (state is PhoneAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) {
          return SafeArea(
            minimum: const EdgeInsets.all(8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(),
                    Column(
                      children: [
                        Text(
                          'Giriş Yap',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Telefonuna gönderilen SMS kodu ile giriş yap.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        if (state is! PhoneAuthCodeSentSuccess)
                        TextFormField(
                          controller: _phoneNumberController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Telefon Numarası',
                            prefixIcon: const Icon(
                              Icons.phone_android_outlined,
                            ),
                            suffixIcon: TextButton(
                              onPressed: () {
                                context.read<PhoneAuthBloc>().add(
                                      SendOtpToPhoneEvent(
                                        phoneNumber: _phoneNumberController.text,
                                      ),
                                    );
                              },
                              child: const Text("Kod Gonder"),
                            ),
                          ),
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'error'),
                            ],
                          ),
                        )
                         else
                        Column(
                          children: [
                            TextFormField(
                              controller: _smsCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Doğrulama Kodu',
                                prefixIcon: Icon(Icons.onetwothree_outlined),
                              ),
                              keyboardType: TextInputType.number,
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.done,
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: 'error'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                               context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
        otpCode: _smsCodeController.text, verificationId: state.verificationId));
                                },
                                child: const Text(
                                  'GİRİŞ YAP',
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Henüz hesabınız yok mu?  ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Hemen Oluştur!',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

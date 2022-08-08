import 'package:email_validator/email_validator.dart';
import 'package:events/core/login.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/logic/bloc/signin_bloc.dart';
import 'package:events/logic/bloc/singin_repository.dart';
import 'package:events/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:events/core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninBloc>(
      create: (context) =>
          SigninBloc(signinRepository: context.read<SigninRepository>()),
      child: SigninForm(),
    );
  }
}

class SigninForm extends StatefulWidget {
  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> profile_items = ['Personal', 'Business'];
  final formkey = GlobalKey<FormState>();
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: BlocListener<SigninBloc, SigninState>(
        listener: (
          context,
          state,
        ) {
          var current = state.formSubmissionStatus;
          if (state.formSubmissionStatus is SubmissionSuccess) {
            print("go");

            Navigator.pushNamed(context, '/main');
          } else if (current is SubmissionSuccessFacebook) {
            print("WWw");
            context.read<SettingsBloc>().add(SettingsEventAdd(
                email: current.credential.user!.email!,
                profile: "Personal",
                accountProvider: current.credential.credential!.providerId));
            Navigator.pushNamed(context, '/main');
          } else if (current is SubmissionSuccessGoogle) {
            print("WWwwww");
            Navigator.pushNamed(context, '/main');

            context.read<SettingsBloc>().add(SettingsEventAdd(
                email: current.credential.user!.email!,
                profile: "Personal",
                accountProvider: current.credential.credential!.providerId));
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: context.watch<SigninBloc>().state.formSubmissionStatus
                        is FormSubmitting ||
                    context.watch<SigninBloc>().state.formSubmissionStatus
                        is SubmissionSuccess
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Center(
                              child: Image.asset(
                                Theme.of(context).logo,
                                width: 41.0.w,
                              ),
                            ),
                            SizedBox(
                              height: 4.5.h,
                            ),
                            Container(
                                width: 49.0.w,
                                child: Text(
                                  "Sign In",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.raleway(fontSize: 30.0.sp),
                                )),
                            SizedBox(
                              height: 3.5.h,
                            ),
                            BlocBuilder<SigninBloc, SigninState>(
                              builder: (context, state) {
                                String res = '';
                                var current = state.formSubmissionStatus;
                                if (current is SubmissionFailed) {
                                  res = current.exception;
                                }
                                return Container(
                                  margin: EdgeInsets.only(left: 2.0.w),
                                  child: Text(
                                    res,
                                    style:
                                        GoogleFonts.raleway(color: Colors.red),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 1.8.h,
                            ),
                            Container(
                              height: 5.5.h,
                              child: ToggleSwitch(
                                minWidth: 40.0.w,
                                cornerRadius: 100.0,
                                fontSize: 16.0,
                                initialLabelIndex: context
                                            .read<SigninBloc>()
                                            .state
                                            .profile_type ==
                                        "Personal"
                                    ? 0
                                    : 1,
                                radiusStyle: true,
                                activeBgColor: [Theme.of(context).activeColor],
                                activeFgColor: Theme.of(context).switchColor,
                                inactiveBgColor: Theme.of(context).toggleColor,
                                inactiveFgColor:
                                    Theme.of(context).textPrimaryColor,
                                totalSwitches: 2,
                                labels: profile_items,
                                onToggle: (index) {
                                  print('switched to: $index');
                                  currIndex = index!;
                                  context.read<SigninBloc>().add(
                                      SigninProfileChange(
                                          profile_type: profile_items[index]));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 3.6.h,
                            ),
                            TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  filled: true,
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25)),
                                  hintText: 'Email',
                                ),
                                onChanged: (value) {
                                  context.read<SigninBloc>().add(
                                      SigninUserNameChanged(username: value));
                                },
                                validator: (value) {
                                  if (EmailValidator.validate(value!) ==
                                      false) {
                                    return 'Please enter a valid email';
                                  }
                                }),
                            SizedBox(
                              height: 3.6.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.length < 4) {
                                  return "Enter a valid Password";
                                }
                              },
                              controller: password,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                filled: true,
                                fillColor: Theme.of(context).textFieldColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(25)),
                                hintText: 'Password',
                              ),
                              onChanged: (value) {
                                context.read<SigninBloc>().add(
                                    SigninPasswordChanged(password: value));
                              },
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email.text);
                              },
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.raleway(
                                      color: Theme.of(context)
                                          .textPrimaryColor
                                          .withOpacity(0.5),
                                      fontSize: 14.0.sp,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 4.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () async {
                                    if (!formkey.currentState!.validate()) {
                                    } else {
                                      context
                                          .read<SigninBloc>()
                                          .add(SigninSubmitted());
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 8.0.h,
                                    width: 80.8.w,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          135, 207, 217, 1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Sign In",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .textSecondaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "or",
                                  style: GoogleFonts.raleway(
                                      color: Theme.of(context)
                                          .textPrimaryColor
                                          .withOpacity(0.5)),
                                )),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () async {
                                    // final data = await Login.signInWithFacebook();
                                    // print("Ww");
                                    // print(data.user);
                                    context
                                        .read<SigninBloc>()
                                        .add(SigninSubmittedFacebook());
                                  },
                                  child: Container(
                                    width: 15.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).iconColor,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.facebookF,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () async {
                                    print(FirebaseAuth.instance.currentUser);

                                    await Login.FacebookSignOut();
                                  },
                                  child: Container(
                                    width: 15.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).iconColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.apple,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LinkedInUserWidget(
                                            destroySession: false,
                                            redirectUrl:
                                                "https://www.marjtechnologies.com/",
                                            clientId: Secrets.id,
                                            clientSecret: Secrets.secrtet,
                                            projection: [
                                              ProjectionParameters.id,
                                              ProjectionParameters
                                                  .localizedFirstName,
                                              ProjectionParameters.lastName,
                                              ProjectionParameters.firstName,
                                              ProjectionParameters.lastName,
                                              ProjectionParameters
                                                  .profilePicture
                                            ],
                                            onError: (UserFailedAction
                                                userFailedAction) {
                                              Navigator.pop(context);
                                            },
                                            onGetUserProfile:
                                                (UserSucceededAction
                                                    linkedinUser) {
                                              final name = linkedinUser.user;
                                              print("check" + name.toString());
                                              context.read<SigninBloc>().add(
                                                  SigninSubmittedLinkedin());

                                              Navigator.pop(context);
                                            },
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    width: 15.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).iconColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.linkedinIn,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () async {
                                    context
                                        .read<SigninBloc>()
                                        .add(SigninSubmittedGoogle());
                                    // final data = await Login.signInWithGoogle();
                                    // print(data.user);
                                  },
                                  child: Container(
                                    width: 15.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).iconColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(FontAwesomeIcons.google),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0.h,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Don\'t have an account?',
                                        style: GoogleFonts.raleway(
                                          color: Theme.of(context)
                                              .textPrimaryColor,
                                          fontSize: 14.0.sp,
                                        ),
                                        children: <TextSpan>[
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushReplacementNamed(
                                                  context, '/signup');
                                            },
                                          text: ' Sign up',
                                          style: GoogleFonts.raleway(
                                            color: Theme.of(context)
                                                .textPrimaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0.sp,
                                          ))
                                    ])))
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

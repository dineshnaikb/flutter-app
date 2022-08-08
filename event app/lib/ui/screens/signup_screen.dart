import 'dart:async';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/logic/bloc/signup_bloc.dart';
import 'package:events/logic/bloc/signup_bloc.dart';
import 'package:events/logic/bloc/singin_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:events/core/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../secrets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: BlocProvider(
        create: (context) =>
            SignupBloc(signinRepository: context.read<SigninRepository>()),
        child: SignUpChild(),
      ),
    );
  }
}

class SignUpChild extends StatefulWidget {
  const SignUpChild({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpChild> createState() => _SignUpChildState();
}

class _SignUpChildState extends State<SignUpChild> {
  TextEditingController pass = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController confirm_pass = TextEditingController();

  final formkey = GlobalKey<FormState>();

  void show(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return BlocProvider.value(
            value: BlocProvider.of<SignupBloc>(ctx),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).sheetColor,
                    borderRadius: BorderRadius.circular(50)),
                height: 35.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.0.h,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);

                        ctx.read<SignupBloc>().add(SignupSubmitted());
                        ctx
                            .read<SignupBloc>()
                            .add(SignupProfileChange(profile_type: 'Personal'));
                      },
                      child: Container(
                        width: 80.8.w,
                        height: 8.0.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Personal",
                          style: GoogleFonts.raleway(
                              fontSize: 18.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        ctx.read<SignupBloc>().add(SignupSubmitted());
                        ctx
                            .read<SignupBloc>()
                            .add(SignupProfileChange(profile_type: 'Business'));
                      },
                      child: Container(
                        width: 80.8.w,
                        height: 8.0.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Business",
                          style: GoogleFonts.raleway(
                              fontSize: 18.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool _isUserEmailVerified = false;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState

    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        var user = await FirebaseAuth.instance.currentUser;

        if (user != null && user.emailVerified) {
          context
              .read<SignupBloc>()
              .add(SignupVerificationChange(verfied: user.emailVerified));
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignUpState>(
      listener: (
        context,
        state,
      ) {
        var status = state.formSubmissionStatus;
        if (status is SubmissionSuccess) {
          String profile = context.read<SignupBloc>().state.profile_type;
          context
              .read<SettingsBloc>()
              .add(SettingsEventAdd(email: email.text, profile: profile));

          bool is_verified = context.read<SignupBloc>().state.verified;
          print(is_verified);
          if (is_verified) {
            Navigator.pushNamed(context, '/main');
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: context.watch<SignupBloc>().state.formSubmissionStatus
                      is FormSubmitting ||
                  context.watch<SignupBloc>().state.formSubmissionStatus
                      is SubmissionSuccess
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Text(
                        "We have to sent you an email, Please verify to proceed ..... "),
                  ],
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
                                "Sign Up",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.raleway(fontSize: 30.0.sp),
                              )),
                          SizedBox(
                            height: 3.6.h,
                          ),
                          BlocBuilder<SignupBloc, SignUpState>(
                            builder: (context, state) {
                              String res = '';
                              var current = state.formSubmissionStatus;
                              if (current is SubmissionFailed) {
                                res = current.exception;
                              }
                              return Container(
                                margin: EdgeInsets.only(left: 2.0.w),
                                child: Text(
                                  res.split(']').last,
                                  style: GoogleFonts.raleway(color: Colors.red),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 1.8.h,
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: (value) {
                              context
                                  .read<SignupBloc>()
                                  .add(SignupUserNameChanged(username: value));
                            },
                            validator: (value) {
                              print(EmailValidator.validate(value!));
                              if (EmailValidator.validate(value) == false) {
                                return 'Please enter a valid email';
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: Theme.of(context).textFieldColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25)),
                              hintText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 3.6.h,
                          ),
                          TextFormField(
                            controller: pass,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Password should be greater than 6 characters';
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: Theme.of(context).textFieldColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25)),
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 3.8.h,
                          ),
                          TextFormField(
                            controller: confirm_pass,
                            onChanged: (value) {
                              context
                                  .read<SignupBloc>()
                                  .add(SignupPasswordChanged(password: value));
                            },
                            validator: (value) {
                              print(pass.text);
                              if (value != pass.text) {
                                return 'Please enter the same password';
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: Theme.of(context).textFieldColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25)),
                              hintText: 'Repeat Password',
                            ),
                          ),
                          SizedBox(
                            height: 6.6.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () async {
                                  bool validate =
                                      formkey.currentState!.validate();
                                  if (validate) {
                                    show(context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 8.0.h,
                                  width: 80.8.w,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(135, 207, 217, 1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Sign Up",
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
                            height: 3.5.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     InkWell(
                          //       onTap: () async {
                          //         final data = await Login.signInWithFacebook();
                          //         print("Ww");
                          //         print(data.user);
                          //       },
                          //       child: Container(
                          //         width: 15.0.w,
                          //         height: 7.0.h,
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).iconColor,
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: Icon(
                          //           FontAwesomeIcons.facebookF,
                          //         ),
                          //       ),
                          //     ),
                          //     InkWell(
                          //       onTap: () async {
                          //         print(FirebaseAuth.instance.currentUser);

                          //         await Login.GoogleSignOut();
                          //       },
                          //       child: Container(
                          //         width: 15.0.w,
                          //         height: 7.0.h,
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).iconColor,
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: Icon(
                          //           FontAwesomeIcons.apple,
                          //         ),
                          //       ),
                          //     ),
                          //     InkWell(
                          //       borderRadius: BorderRadius.circular(50),
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) => LinkedInUserWidget(
                          //                 destroySession: true,
                          //                 redirectUrl: "https://www.marjtechnologies.com/",
                          //                 clientId: Secrets.id,
                          //                 clientSecret: Secrets.secrtet,
                          //                 projection: [
                          //                   ProjectionParameters.id,
                          //                   ProjectionParameters.localizedFirstName,
                          //                   ProjectionParameters.lastName,
                          //                   ProjectionParameters.firstName,
                          //                   ProjectionParameters.lastName,
                          //                   ProjectionParameters.profilePicture
                          //                 ],
                          //                 onGetUserProfile:
                          //                     (UserSucceededAction linkedinUser) {
                          //                   final name = linkedinUser
                          //                       .user.firstName?.localized?.label
                          //                       .toString();
                          //                   print("check" + name.toString());
                          //                   Navigator.pop(context);
                          //                 },
                          //               ),
                          //             ));
                          //       },
                          //       child: Container(
                          //         width: 15.0.w,
                          //         height: 7.0.h,
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).iconColor,
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: Icon(
                          //           FontAwesomeIcons.linkedinIn,
                          //         ),
                          //       ),
                          //     ),
                          //     InkWell(
                          //       onTap: () async {
                          //         final data = await Login.signInWithGoogle();
                          //         print("Ww");
                          //         print(data.user);
                          //       },
                          //       child: Container(
                          //         width: 15.0.w,
                          //         height: 7.0.h,
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).iconColor,
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: Icon(FontAwesomeIcons.google),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 3.0.h,
                          // ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signin');
                            },
                            child: Container(
                                alignment: Alignment.center,
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Already have an account?',
                                        style: GoogleFonts.raleway(
                                            color: Theme.of(context)
                                                .textPrimaryColor,
                                            fontSize: 12.sp),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: ' Sign in',
                                          style: GoogleFonts.raleway(
                                              color: Theme.of(context)
                                                  .textPrimaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp))
                                    ]))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

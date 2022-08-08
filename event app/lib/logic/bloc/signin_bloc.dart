import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:events/core/login.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/singin_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SigninRepository signinRepository;
  SigninBloc({required this.signinRepository}) : super(SigninState());

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is SigninUserNameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is SigninPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SigninSubmitted) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      var res = await signinRepository.login(
          state.username, state.password, state.profile_type);
      print(res);
      if (res == "success")
        yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
      else {
        yield state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: res));
      }
    } else if (event is SigninProfileChange) {
      yield state.copyWith(profile_type: event.profile_type);
    } else if (event is SigninSubmittedGoogle) {
      // yield state.copyWith(formSubmissionStatus: FormSubmitting());

      UserCredential userCredential = await Login.signInWithGoogle();
      print(userCredential.credential!.providerId);
      yield state.copyWith(
          formSubmissionStatus:
              SubmissionSuccessFacebook(credential: userCredential));
    } else if (event is SigninSubmittedFacebook) {
      // yield state.copyWith(formSubmissionStatus: FormSubmitting());

      UserCredential userCredential = await Login.signInWithFacebook();
      print(userCredential.credential!.providerId);
      yield state.copyWith(
          formSubmissionStatus:
              SubmissionSuccessFacebook(credential: userCredential));
    }

    // else if (event is SigninSubmittedLinkedin) {
    //   yield state.copyWith(profile_type: event.profile_type);
    // }
    else if (event is SigninFailed) {
      yield state.copyWith(formSubmissionStatus: FormSubmitNow());
    }
  }
}

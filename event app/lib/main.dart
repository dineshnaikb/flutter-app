import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';
import 'package:events/logic/bloc/event_display_repository.dart';
import 'package:events/logic/bloc/eventuser_bloc.dart';
import 'package:events/logic/bloc/settings_repository.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/logic/bloc/singin_repository.dart';
import 'package:events/logic/cubit/announcements_cubit.dart';
import 'package:events/logic/cubit/bottombar_cubit.dart';
import 'package:events/logic/cubit/event_requests_cubit.dart';
import 'package:events/logic/cubit/friends_cubit.dart';
import 'package:events/logic/cubit/message_cubit.dart';
import 'package:events/logic/cubit/notifications_cubit.dart';
import 'package:events/logic/cubit/theme_cubit.dart';
import 'package:events/logic/cubit/transactions_cubit.dart';
import 'package:events/ui/screens/about_screen.dart';
import 'package:events/ui/screens/blocked_accounts.dart';
import 'package:events/ui/screens/chat_screen.dart';
import 'package:events/ui/screens/create_event_screen.dart';
import 'package:events/ui/screens/credit_card_details_screen.dart';
import 'package:events/ui/screens/event_announcements_screen.dart';
import 'package:events/ui/screens/event_details_screen.dart';
import 'package:events/ui/screens/event_details_without_payment.dart';
import 'package:events/ui/screens/event_info_screen.dart';
import 'package:events/ui/screens/inbox_screen.dart';
import 'package:events/ui/screens/invited_friends.dart';
import 'package:events/ui/screens/main_app_screen.dart';
import 'package:events/ui/screens/main_screen.dart';
import 'package:events/ui/screens/manage_event_screen.dart';
import 'package:events/ui/screens/manage_events_screen.dart';
import 'package:events/ui/screens/message_screen.dart';
import 'package:events/ui/screens/modify_event_screen.dart';
import 'package:events/ui/screens/myevents_screen.dart';
import 'package:events/ui/screens/notification_screen.dart';
import 'package:events/ui/screens/privacy_policy.dart';
import 'package:events/ui/screens/privacy_screen.dart';
import 'package:events/ui/screens/private_chat_screen.dart';
import 'package:events/ui/screens/promote_screen.dart';
import 'package:events/ui/screens/request_screen.dart';
import 'package:events/ui/screens/security_Screen.dart';
import 'package:events/ui/screens/select_coshare_users_screens.dart';
import 'package:events/ui/screens/signin_screen.dart';
import 'package:events/ui/screens/signup_screen.dart';
import 'package:events/ui/screens/splash_screen.dart';
import 'package:events/ui/screens/settings_screen.dart';
import 'package:events/ui/screens/transaction_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'logic/bloc/messages_repository.dart';
import 'logic/debug/app_observer.dart';
import 'ui/screens/edit_event_screen.dart';
import 'ui/screens/select_invited_users_screen.dart';
import 'ui/screens/write_comment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SigninRepository>(
          create: (context) => SigninRepository(),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(),
        ),
        RepositoryProvider<EventDisplayRepository>(
          create: (context) => EventDisplayRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
            lazy: false,
          ),
          BlocProvider<MessageCubit>(
            create: (context) => MessageCubit(
              repository: AnnouncementsRepository(
                Dio(),
              ),
            ),
            lazy: false,
          ),
          BlocProvider<AnnouncementsCubit>(
            create: (context) => AnnouncementsCubit([]),
            lazy: false,
          ),
          BlocProvider<FriendsCubit>(
            create: (context) => FriendsCubit([]),
            lazy: false,
          ),
          BlocProvider<EventRequestsCubit>(
            create: (context) => EventRequestsCubit([]),
            lazy: false,
          ),
          BlocProvider<TransactionsCubit>(
            create: (context) => TransactionsCubit([]),
            lazy: false,
          ),
          BlocProvider<NotificationsCubit>(
            create: (context) => NotificationsCubit([]),
            lazy: false,
          ),
          BlocProvider<EventDisplayBloc>(
            create: (context) => EventDisplayBloc(
                eventDisplayRepository: context.read<EventDisplayRepository>()),
            lazy: false,
          ),
          BlocProvider<BottombarCubit>(create: (context) => BottombarCubit()),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
                settingsRepository: context.read<SettingsRepository>()),
            lazy: false,
          ),
          BlocProvider<EventuserBloc>(create: (context) => EventuserBloc()),
          BlocProvider<EventBloc>(
            create: (context) => EventBloc(),
            lazy: false,
          ),
        ],
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  bool check = true;
  checkLogin() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    check = _prefs.getString("user_id") == null;
    setState(() {
      print(check);
    });
  }

  @override
  void initState() {
    context.read<SettingsBloc>().add(SettingsInitial());
    context.read<EventDisplayBloc>().add(EventDiplayGetAllEvents());
    WidgetsBinding.instance!.addObserver(this);
    checkLogin();
    print(FirebaseAuth.instance.currentUser);
    // if (FirebaseAuth.instance.currentUser != null) {
    //   check = true;
    // }
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          OrientationBuilder(builder: (context, orientation) {
        return Sizer(builder: (context, constraints, orientation) {
          return MaterialApp(
            routes: {
              '/': (context) => SplashScreen(),
              '/signin': (context) => SigninScreen(),
              '/signup': (context) => SignUpScreen(),
              '/main': (context) => MainScreen(),
              '/notifications': (context) => NotificationScreen(),
              '/select_co_share_users': (context) => SelectCoShareUsersScreen(),
              '/select_invited_users': (context) => SelectInvitedUsersScreen(),
              '/event_info': (context) => EventInfoScreen(),
              '/write_a_comment': (context) => WriteCommentScreen(),
              '/event_details_without_payments': (context) =>
                  EventDetailsWithoutPayment(),
              '/invited_friends': (context) => InvitedFriends(),
              '/create_event': (context) => CreateEventScreen(),
              '/credit_screen': (context) => CreditDetailsScreen(),
              '/request_screen': (context) => RequestScreen(),
              '/settings_screen': (context) => SettingsScreen(),
              '/inbox_screen': (context) => InboxScreen(),
              '/my_events_screen': (context) => MyEventScreen(),
              '/security_screen': (context) => SecurityScreen(),
              '/privacy_policy': (context) => PrivacyPolicyScreen(),
              '/about_screen': (context) => AboutScreen(),
              '/privacy_screen': (context) => PrivacyScreen(),
              '/event_details': (context) => EventDetailsScreen(),
              // '/event_announcements': (context) => EventAnnouncementsScreen(),
              '/manage_event': (context) => ManageEventScreen(),
              '/edit_event': (context) => EditEventScreen(),
              '/promote_screen': (context) => PromoteScreen(),
              '/main_screen': (context) => MainAppScreen(),
              '/manage_events_screen': (context) => ManageEventsScreen(),
              '/chat_screen': (context) => ChatScreen(),
              '/transaction_history': (context) => TransactionHistory(),
              '/message_screen': (context) => MessageScreen(),
              '/private_chat': (context) => PrivateChat(),
              '/modify_event': (context) => ModifyEventScreen(),
              '/blocked_accounts': (context) => BlockedAccounts()
            },
            initialRoute: check ? '/' : '/main',
            // initialRoute: '/',
            theme: ThemeData(
              textTheme: GoogleFonts.ralewayTextTheme(
                Theme.of(context).textTheme,
              ),
              // fontFamily: 'raleway',
              brightness: Brightness.light,
              primaryColor: Color.fromRGBO(0, 0, 0, 1),
              backgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            // theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        });
      }),
    );
  }
}

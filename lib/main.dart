import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sync/features/auth/data/firebase_auth_repository.dart';
import 'package:notes_app_sync/features/auth/presentation/components/loading_screen.dart';
import 'package:notes_app_sync/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:notes_app_sync/features/auth/presentation/cubits/auth_state.dart';
import 'package:notes_app_sync/features/auth/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app_sync/features/home/presentation/pages/home_screen.dart';
import 'package:notes_app_sync/themes/dark_mode.dart';
import 'package:notes_app_sync/themes/light_mode.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyWidget());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: "/",
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: "/details",
          builder: (context, state) {
            return const AuthPage();
          },
        )
      ]),
  // GoRoute(path: "/login", builder: (context, state) {
  //   return const LoginScreen();
  // }),
  // GoRoute(path: "/register", builder: (context, state) {
  //   return const RegisterScreen();
  // },)
]);

class MyWidget extends StatelessWidget {
  /// Constructs a [MyApp]
  MyWidget({super.key});

  final firebaseAuthRepo = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //provide cubits to app
      providers: [
        //auth cubit
        BlocProvider(
            create: (context) =>
                AuthCubit(authRepo: firebaseAuthRepo)..checkAuthentication())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,

        /*
        BLoc Consumer - Auth
        */
        home: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          print(state);
          //unauthenticated -> auth page(login/register)
          if (state is Unauthenticated) {
            return const AuthPage();
          }
          //authenticated -> home page
          if (state is Authenticated) {
            return const HomeScreen();
          }
          //loading...

          else {
            return const LoadingScreen();
          }
        },
            //listen for state changes
            listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sync/features/auth/presentation/cubits/auth_cubits.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //logout button
          IconButton(
              onPressed: () {
                final authCubit = context.read<AuthCubit>();
                authCubit.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}

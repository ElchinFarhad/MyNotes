import 'dart:developer';

import 'package:first_app/constants/routes.dart';
import 'package:first_app/main.dart';
import 'package:first_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../enum/menu_list.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: const Text("Notes Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (_) => false,
                  );
                }
                log(shouldLogout.toString());
                break;
            }
            log(value.toString());
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('logout'),
              ),
            ];
          })
        ],
      ),
      body: const Text("Hello World"),
    );
  }
}

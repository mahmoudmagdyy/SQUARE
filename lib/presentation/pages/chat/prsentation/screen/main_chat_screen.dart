import 'package:aqarat/presentation/pages/chat/prsentation/screen/users_chats_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/fcm_service.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/app_prefs.dart';
import 'chat_screen.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  @override
  void initState() {
    if (!sl<AppPreferences>().isItUser) {
      print('setupFCM');
      setupFCM();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sl<AppPreferences>().isItUser
        ? const ChatScreen(
            userId: '-1',
            username: 'الادمن',
          )
        : const UsersChatsScreen();
  }
}

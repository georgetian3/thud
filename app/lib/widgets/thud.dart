import 'package:flutter/material.dart';

import 'package:thud/models/thudstate.dart';
import 'package:thud/langs/localizations.dart';
import 'package:thud/widgets/login.dart';
import 'package:thud/widgets/post/post_summary.dart';
import 'package:thud/widgets/chat/chat.dart';
import 'package:thud/widgets/notifications/notifications.dart';
import 'package:thud/widgets/user.dart';
import 'package:thud/widgets/settings.dart';

class ThudScaffold extends StatefulWidget {
  const ThudScaffold({super.key});
  @override createState() => _ThudScaffold();
}

class _ThudScaffold extends State<ThudScaffold> {

  int _selectedIndex = 0;
  final List<List<dynamic>> screens = [
    [const PostSummaryListScreen()  , Icons.newspaper_outlined, 'posts'],
    [const ChatListScreen()         , Icons.message_outlined  , 'chats'],
    [const NotificationsScreen()    , Icons.notifications     , 'notifications'],
    [const MeScreen()               , Icons.person            , 'me'],
    [const SettingsScreen()         , Icons.settings          , 'settings']
  ];

  @override build(BuildContext context) {

    final jumpToNotifications = context.select<ThudState, bool>((thudState) => thudState.jumpToNotifications);
    if (jumpToNotifications) {
      setState(() => _selectedIndex = 2);
      context.read<ThudState>().jumpedToNotifications();
    }
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: [
          for (List screen in screens)
            NavigationDestination(icon: Icon(screen[1]), label: tr(context, screen[2]))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [for (final screen in screens) screen[0]],
      ),
    );
  }

}


class ThudApp extends StatelessWidget {
  const ThudApp({super.key});




  @override build(BuildContext context) {

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'THUD',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.deepPurple
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple
        ),
      ),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }

}


class Thud {

  final String apiUrl;
  Thud({this.apiUrl = 'https://thudapi.georgetian.com:8443'});

  void run() {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThudState(apiUrl: apiUrl),
        child: const ThudApp(),
      ),
    );
  }
}
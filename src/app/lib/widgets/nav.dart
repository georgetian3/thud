// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:thud/models/posts.dart';
// import 'package:thud/widgets/login.dart';
// import 'package:thud/widgets/thud.dart';
// import 'package:thud/widgets/user.dart';
// import 'package:thud/widgets/settings.dart';
// import 'package:thud/widgets/messaging/messaging.dart';
// import 'package:thud/widgets/posts/post_summary.dart';
// import 'package:thud/widgets/posts/post_details.dart';
// import 'package:thud/widgets/posts/create_post.dart';

// import 'package:thud/utils/langs.dart';



// class DrawerEntry {
//   final String title;
//   final IconData icon;
//   final String path;
//   DrawerEntry(this.title, this.icon, this.path);
// }

// class THUDDrawer extends StatelessWidget {
//   //THUDDrawer({super.key});

//   THUDDrawer._privateConstructor();

//   static final THUDDrawer _instance = THUDDrawer._privateConstructor();
//   factory THUDDrawer() {
//     return _instance;
//   }

//   static int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {

//     final entries = [
//       DrawerEntry(tr(context, 'posts'), Icons.newspaper, '/posts'),
//       DrawerEntry(tr(context, 'messages'), Icons.message, '/messages'),
//       DrawerEntry(tr(context, 'profile'), Icons.account_circle, '/profile'),
//       DrawerEntry(tr(context, 'settings'), Icons.settings, '/settings'),
//     ];

//     return NavigationDrawer(
//       onDestinationSelected: (int index) {
//         _selectedIndex = index;
//         context.go(entries[index].path);
//       },
//       selectedIndex: _selectedIndex,
//       children: [
//         for (final entry in entries)
//           NavigationDrawerDestination(
//             icon: Icon(entry.icon),
//             label: Text(entry.title),
//           ),
//       ],
//     );
//   }
// }

// class BottomNavScaffold extends StatefulWidget {
//   const BottomNavScaffold({super.key});
//   @override
//   State<BottomNavScaffold> createState() => _BottomNavScaffold();
// }

// class _BottomNavScaffold extends State<BottomNavScaffold> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         destinations: [
//           NavigationDestination(icon: Icon(Icons.newspaper_outlined), label: tr(context, 'posts')),
//           NavigationDestination(icon: Icon(Icons.message_outlined), label: tr(context, 'messages')),
//           NavigationDestination(icon: Icon(Icons.notifications), label: tr(context, 'notifications')),
//           NavigationDestination(icon: Icon(Icons.person), label: tr(context, 'profile')),
//           NavigationDestination(icon: Icon(Icons.settings), label: tr(context, 'settings')),
//         ],
//       )
//     );

//   }
// }




// GoRouter router(PostOrder postList) => GoRouter(
//   initialLocation: '/posts',
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return ThudScaffold();
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'login',
//           builder: (BuildContext context, GoRouterState state) {
//             return LoginScreen();
//           },
//         ),
//         GoRoute(
//           path: 'posts',
//           builder: (BuildContext context, GoRouterState state) {
//             return PostSummaryListScreen(postList: postList);
//           },
//           routes: [
//             GoRoute(
//               path: 'create',
//               builder: (BuildContext context, GoRouterState state) {
//                 return CreatePostScreen();
//               },
//             ),
//             GoRoute(
//               path: ':id',
//               builder: (BuildContext context, GoRouterState state) {
//                 var id;
//                 try {
//                   id = int.parse(state.params['id']!);
//                 } catch (Exception) {
//                   return PostSummaryListScreen(postList: postList);

//                 }
//                 Post? post = postList.getPostById(id);
//                 if (post == null) {
//                   return PostSummaryListScreen(postList: postList);

//                 }
//                 return PostDetailScreen(post: post);
//               },
//             ),
//           ]
//         ),
//         GoRoute(
//           path: 'messages',
//           builder: (BuildContext context, GoRouterState state) {
//             return const ChatListScreen();
//           },
//         ),
//         GoRoute(
//           path: 'message-example',
//           builder: (BuildContext context, GoRouterState state) {
//             return const MessageListScreen();
//           },
//         ),
//         GoRoute(
//           path: 'profile',
//           builder: (BuildContext context, GoRouterState state) {
//             return const UserScreen();
//           },
//         ),
//         GoRoute(
//           path: 'settings',
//           builder: (BuildContext context, GoRouterState state) {
//             return const SettingsScreen();
//           },
//         ),
//       ],
//     ),
//   ],
// );
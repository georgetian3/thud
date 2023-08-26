import 'package:flutter/material.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/langs/localizations.dart';
import 'package:thud/widgets/login.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:ota_update/ota_update.dart';



Future<void> changePasswordDialog(BuildContext context) async {
  String _oldPassword = '';
  String _newPassword = '';
  String _message = '';
  Color _messageColor = Colors.transparent;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(tr(context, 'changePassword')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                onChanged: (value) => setState(() => _oldPassword = value),
                decoration: InputDecoration(labelText: tr(context, 'oldPassword'),),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) => setState(() => _newPassword = value),
                decoration: InputDecoration(labelText: tr(context, 'newPassword')),
              ),
              const SizedBox(height: 16),
              Text(_message, style: TextStyle(color: _messageColor)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() => _message = '');
                var success = await context.read<ThudState>().changePassword(_oldPassword, _newPassword);
                setState(() {
                  if (success) {
                    _message = tr(context, 'pwChangeSuccess');
                    _messageColor = Theme.of(context).colorScheme.primary;
                  } else {
                    _message = tr(context, 'pwChangeFailed');
                    _messageColor = Theme.of(context).colorScheme.error;
                  }
                });
              },
              child: Text(tr(context, 'done')),
            )
          ],
        ),
      );
    },
  );

}


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {



  @override
  Widget build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'settings'))),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SettingsList(
          lightTheme: SettingsThemeData(settingsListBackground: Theme.of(context).colorScheme.background),
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile.navigation(
                  onPressed: (context) async => await changePasswordDialog(context),
                  leading: const Icon(Icons.password),
                  title: Text(tr(context, 'changePassword')),
                ),
                SettingsTile.navigation(
                  onPressed: (context) async {
                    await thudState.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(autoLogin: false)));
                  },
                  leading: const Icon(Icons.logout),
                  title: Text(tr(context, 'logout')),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.update),
                  title: Text(tr(context, 'updateApp')),
                  onPressed: (context) {
                    try {
                      OtaUpdate().execute(
                        'https://thud.georgetian.com:8443/thud.apk',
                      ).listen(
                        (OtaEvent event) {
                          setState(() {});
                        },
                      );
                    } catch (e) {
                      print('Failed to make OTA update. Details: $e');
                    }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
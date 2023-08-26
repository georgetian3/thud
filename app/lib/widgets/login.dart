import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:thud/langs/localizations.dart';
import 'package:thud/models/auth.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/widgets/thud.dart';
import 'package:thud/widgets/utils.dart';

class LoginScreen extends StatefulWidget {
  final bool autoLogin;
  const LoginScreen({this.autoLogin = true, super.key});
  @override createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _errorMessage = '';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _saveLogin = false;

  late ThudState thudState;


  Future<void> loginClicked(BuildContext context) async {
    setState(() => _errorMessage = '');
    if (_usernameController.text == '' || _passwordController.text == '') {
      setState(() => _errorMessage = tr(context, 'loginEmpty'));
      return;
    } 
    await login(credentials: Credentials(_usernameController.text, _passwordController.text));
  }

  Future<void> login({Credentials? credentials}) async {
    bool success = await showLoading(
      context,
      thudState.login(credentials: credentials, save: _saveLogin),
      text: tr(context, 'loggingIn'),
    );
    
    if (!success) {
      setState(() => _errorMessage = tr(context, 'badLogin'));
      return;
    }
    
    setState(() => _errorMessage = '');

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ThudScaffold()));
  }

  Future<void> registerClicked(context) async {
    setState(() => _errorMessage = '');
    if (_usernameController.text == '' || _passwordController.text == '') {
      setState(() => _errorMessage = tr(context, 'loginEmpty'));
      return;
    } 
    
    bool success = await showLoading(
      context,
      thudState.register(_usernameController.text, _passwordController.text),
      text: tr(context, 'registering'),
    );
    
    if (!success) {
      setState(() => _errorMessage = tr(context, 'badRegister'));
      return;
    } 
    
    setState(() => _errorMessage = '');

    loginClicked(context);
  }

  @override initState() {
    super.initState();
    thudState = context.read<ThudState>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      thudState.getSavedCredentials().then((Credentials? savedCredentials) {
        if (savedCredentials != null) {
          setState(() {
            _usernameController.text = savedCredentials.username;
            _passwordController.text = savedCredentials.password;
          });
          if (widget.autoLogin) {
            login();
          }
        }
      });

    });
  }

  @override build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/thud.png', width: 160, height: 160),
            const SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: tr(context, 'username'),),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: tr(context, 'password')),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _saveLogin,
                  onChanged: (value) => {setState(() {_saveLogin = value!;})}
                ),
                Text(tr(context, 'saveLogin')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async => await loginClicked(context),
                    child: Text(tr(context, 'login')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async => await registerClicked(context),
                    child: Text(tr(context, 'register')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
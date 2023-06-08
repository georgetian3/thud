import 'package:flutter/material.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/models/user.dart';
import 'package:thud/widgets/user.dart';



class ProfilePicture extends StatelessWidget {

  final UserProvider user;
  final double size;
  final Function()? onTap;

  const ProfilePicture(this.user, {
    this.onTap,
    this.size = 16,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    var thudState = context.read<ThudState>();
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<UserProvider>.value(
            value: user,
            child: Consumer<UserProvider>(
              builder: (_, user, __) => UserScreen(user),
            ),
          ),
        ));
      },


      child: user.profilePicture == null
      ? CircleAvatar(
          radius: size,
          child: Icon(
            Icons.person,
            size: size,
          ),
        )
      : CircleAvatar(
        foregroundImage: NetworkImage(thudState.mediaIdToUrl(user.profilePicture!)),
        radius: size,
      )
          
    );
  }
}

class Username extends StatelessWidget {
  final UserProvider user;
  final Function()? onTap;
  final TextStyle? textStyle;
  final bool showAt;
  const Username(this.user, {this.onTap, this.textStyle, this.showAt = true, super.key});
  @override build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${showAt ? '@' : ''}${user.username}',
            style: textStyle,
          ),
          if (context.read<ThudState>().follows(user.id)) ...[
            const SizedBox(width: 4),
            const Icon(
              Icons.check_circle,
              size: 16,
            ),
          ]
        ],
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<UserProvider>.value(
            value: user,
            child: Consumer<UserProvider>(
              builder: (_, user, __) => UserScreen(user),
            ),
          ),
        ));
      },
    );
  }
}
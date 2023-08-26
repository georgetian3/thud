// import 'package:thud/models/typedefs.dart';

// class Message {
//   final ID messageId;
//   final String content;
//   final ID senderId;
//   final ID receiverId;
//   final DateTime timestamp;

//   Message(this.messageId, this.content, this.senderId, this.receiverId, this.timestamp);

// }



import 'package:thud/models/thudstate.dart';
import 'package:thud/models/user.dart';

class ChatProvider extends ChangeNotifier {

  final List<Message> messages;
  final UserProvider user;

  ChatProvider(this.messages, this.user);

  bool addMessage(Message message) {
    if (messages.contains(message)) {
      return false;
    }
    messages.add(message);
    notifyListeners();
    return true;
  }

}



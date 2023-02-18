import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/models/message_model.dart';
import 'package:shoemania/models/product_model.dart';
import 'package:shoemania/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<MessageModel>> getMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id') ?? 0;
      var messages = firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          print(message.data());
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();

        result.sort(
          (MessageModel a, MessageModel b) =>
              a.createdAt!.compareTo(b.createdAt!),
        );

        return result;
      });
      return messages as List<MessageModel>;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Stream<List<MessageModel>> getMessageByUserId({
    required int userId,
  }) {
    try {
      return firestore
          .collection('messages')
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          var msg =
              MessageModel.fromJson(message.data() as Map<String, dynamic>);
          print(msg.message);
          return msg;
        }).toList();
        result.sort(
          (a, b) => a.createdAt!.compareTo(b.createdAt!),
        );
        return result;
      });
    } catch (error) {
      throw Exception(error);
      // print(error.toString());
      // return [];
    }
  }

  Future<void> addMessage(
      User user, bool isFromUser, String message, Product product) async {
    try {
      final data = {
        'user_id': user.id,
        'username': user.name,
        'user_image': user.profilePhotoUrl,
        'is_from_user': true,
        'message': message,
        'product': product is UninitializedProduct ? {} : product.toJson(),
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };
      firestore
          .collection('messages')
          .add(data)
          .then((value) => print('Message sent'));
    } catch (error) {
      throw Exception('Message was not sent!');
    }
  }
}

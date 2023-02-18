import 'package:flutter/material.dart';
import 'package:shoemania/models/message_model.dart';
import 'package:shoemania/models/product_model.dart';
import 'package:shoemania/pages/chats/detail_chat_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemChatTile extends StatelessWidget {
  ItemChatTile({Key? key, required this.message}) : super(key: key);
  MessageModel message;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/chat');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatPage(UninitializedProduct()),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: height6),
        padding: EdgeInsets.symmetric(vertical: height6, horizontal: width12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_chat_online.png',
                        width: width32 * 1.5,
                      ),
                      SizedBox(
                        width: width12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ShoeMania Store',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: vietnam500.copyWith(
                                    fontSize: font13, color: secondaryColor)),
                            SizedBox(
                              height: height6,
                            ),
                            Text(
                                message.message! +
                                    ' jfhdjh hghhfh hffghfjh hfjfhfj',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: vietnam400.copyWith(
                                    fontSize: font12, color: gray)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    timeago.format(message.updatedAt!),
                    style: vietnam400.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: font10,
                        color: gray),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height8,
            ),
            Divider(
              thickness: 1.0,
              color: silver,
            ),
          ],
        ),
      ),
    );
  }
}

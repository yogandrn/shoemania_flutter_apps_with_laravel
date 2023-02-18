import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/message_model.dart';
import 'package:shoemania/models/product_model.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/message_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';
import 'package:shoemania/widgets/chat_buble.dart';

class DetailChatPage extends StatefulWidget {
  Product product;
  DetailChatPage(this.product);

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController _chatsControler = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silver,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header(context), content()],
        ),
      ),
      bottomNavigationBar: chatInput(),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      color: white,
      height: height40 * 2,
      padding: EdgeInsets.symmetric(horizontal: width12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
          SizedBox(
            width: width24,
          ),
          Image.asset(
            'assets/images/icon_chat_online.png',
            width: width32 * 1.5,
          ),
          SizedBox(
            width: width20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ShoeMania Store',
                style: vietnam500.copyWith(
                    fontSize: font15, color: secondaryColor),
              ),
              Text(
                'Online',
                style: vietnam400.copyWith(fontSize: font13, color: success),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chatInput() {
    return Container(
      width: screenHeight,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.product is UninitializedProduct
              ? SizedBox()
              : productPreview(),
          Row(children: [
            Expanded(
              child: Container(
                height: height24 * 2,
                padding: EdgeInsets.symmetric(
                    horizontal: width12, vertical: height8),
                decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    // color: silver,
                    borderRadius: BorderRadius.circular(width12)),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _chatsControler,
                    style: vietnam400.copyWith(
                        fontSize: font13, color: blackColor),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type message here...',
                      hintStyle:
                          vietnam400.copyWith(fontSize: font12, color: gray),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width8,
            ),
            GestureDetector(
              onTap: () async {
                if (_chatsControler.text == '' ||
                    _chatsControler.text.isEmpty) {
                  return;
                }
                await MessageService().addMessage(
                    Provider.of<AuthProvider>(context, listen: false).user,
                    true,
                    _chatsControler.text,
                    widget.product);

                setState(() {
                  widget.product = UninitializedProduct();
                  _chatsControler.text = '';
                });
              },
              child: Container(
                height: height24 * 2,
                padding: EdgeInsets.symmetric(horizontal: width16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width12),
                    color: primaryColor),
                child: Icon(Icons.send_rounded, color: white),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget productPreview() {
    return Container(
      width: width32 * 9,
      // height: height20 * 4,
      margin: EdgeInsets.only(
        bottom: width16,
      ),
      padding: EdgeInsets.all(width12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width12),
        border: Border.all(color: gray, width: 1.2),
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width32 * 2,
                height: width32 * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        widget.product.galleries![0].imageUrl),
                  ),
                ),
              ),
              SizedBox(width: width8),
              SizedBox(
                width: width20 * 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: vietnam400.copyWith(
                              fontSize: 14, color: blackColor)),
                      Text(Helpers.convertToIdr(widget.product.price!),
                          maxLines: 1,
                          style: vietnam400.copyWith(
                              fontSize: 14, color: secondaryColor)),
                    ]),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  widget.product = UninitializedProduct();
                });
              },
              child: Icon(Icons.close)),
        ],
      ),
    );
  }

  Widget content() {
    return Expanded(
      //     child: ListView(
      //   padding: EdgeInsets.symmetric(horizontal: width12, vertical: height12),
      //   children: [
      //     ChatBubble(
      //       text: 'Hi, is this item still available? jdgjh sjdg sh sdgh dshgh',
      //       isSender: true,
      //       hasProduct: true,
      //     ),
      //     ChatBubble(
      //       text: 'Yes, this item is still available.',
      //       isSender: false,
      //     )
      //   ],
      // )
      child: StreamBuilder<List<MessageModel>>(
          stream: MessageService().getMessageByUserId(
            userId: Provider.of<AuthProvider>(context, listen: false).user.id,
          ),
          builder: (context, snapshot) {
            var messages = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: messages!.length,
                padding: EdgeInsets.symmetric(
                    horizontal: width12, vertical: height12),
                itemBuilder: (context, index) {
                  return ChatBubble(
                    product: messages[index].product!,
                    isSender: messages[index].isFromUser!,
                    text: messages[index].message!,
                  );
                },
                // children: [
                //   ChatBubble(
                //     text:
                //         'Hi, is this item still available? jdgjh sjdg sh sdgh dshgh',
                //     isSender: true,
                //     hasProduct: true,
                //   ),
                //   ChatBubble(
                //     text: 'Yes, this item is still available.',
                //     isSender: false,
                //   )
                // ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

import 'dart:developer';

import 'package:aqarat/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.userId, required this.username})
      : super(key: key);
  final String userId;
  final String username;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  String userId = sl<AppPreferences>().getuserId;
  bool isSeen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.username,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
        leading: sl<AppPreferences>().isItUser
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admin')
                .doc(sl<AppPreferences>().isItUser ? userId : widget.userId)
                .collection('messages')
                .orderBy('created_at', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      300.verticalSpace,
                      Text(
                        'لا يوجد رسائل',
                        style: TextStyle(color: Colors.black, fontSize: 20.sp),
                      ),
                    ],
                  ),
                );
              }

              if (!sl<AppPreferences>().isItUser) {
                FirebaseFirestore.instance
                    .collection('admin')
                    .doc(sl<AppPreferences>().isItUser ? userId : widget.userId)
                    .collection('messages')
                    .orderBy('created_at', descending: false)
                    .get()
                    .then((value) {
                  for (var element in value.docs) {
                    element.reference.update({'seen': true});
                    print('seen ${element.data()['seen']}');
                  }
                });
              }

              var messagesSnapshot =
                  snapshot.data as QuerySnapshot<Map<String, dynamic>>;

              List<MessageWidget> messageWidgets = [];
              for (var i = 0; i < messagesSnapshot.docs.length; i++) {
                var message = messagesSnapshot.docs[i].data();
                String messageText = message['message'];
                String messageSender = message['sender_id'];
                var messageCreatedAt = message['created_at_string'];
                log('messageText $messageText');
                MessageWidget messageWidget = MessageWidget(
                  messageSender,
                  messageText,
                  messageCreatedAt: messageCreatedAt.toString(),
                );
                messageWidgets.add(messageWidget);
                if (i == messagesSnapshot.docs.length - 1) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeOut,
                    );
                  });
                }
              }

              return Expanded(
                child: ListView(
                  controller: scrollController,
                  children: messageWidgets,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: 'اكتب رسالة',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.w),
                          ),
                        )),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppColors.primary,
                    size: 28.sp,
                  ),
                  onPressed: () async {
                    if (_messageController.text.trim().isEmpty) {
                      return;
                    }

                    print(
                        'userid:sl<AppPreferences>().isItUser?  userId : widget.userId');
                    var messageText = _messageController.text.trim();

                    if (messageText.isNotEmpty) {
                      if (sl<AppPreferences>().isItUser) {
                        await FirebaseFirestore.instance
                            .collection('admin')
                            .doc(userId)
                            .set({
                          'id': userId,
                          'user_name': sl<AppPreferences>().getUserName,
                          'created_at': Timestamp.now(),
                        });
                      }

                      await FirebaseFirestore.instance
                          .collection('admin')
                          .doc(sl<AppPreferences>().isItUser
                              ? userId
                              : widget.userId)
                          .collection('messages')
                          .add({
                        'message': messageText,
                        'sender_id': userId,
                        'created_at': Timestamp.now(),
                        'created_at_string': DateTime.now().toString(),
                        'seen': false,
                      });
                      _messageController.clear();

                      FirebaseFirestore.instance
                          .collection('admin')
                          .doc(sl<AppPreferences>().isItUser
                              ? userId
                              : widget.userId)
                          .update(
                        {'created_at': Timestamp.now()},
                      );
                    }

                    var messageSubscription = FirebaseFirestore.instance
                        .collection('admin')
                        .doc(sl<AppPreferences>().isItUser
                            ? userId
                            : widget.userId)
                        .collection('messages')
                        .orderBy('created_at', descending: true)
                        .limit(1)
                        .snapshots()
                        .listen((QuerySnapshot snapshot) {
                      if (snapshot.docs.isNotEmpty) {
                        setState(() {
                          isSeen = snapshot.docs.first['seen'];
                        });
                      }
                    });
                    Future.delayed(const Duration(seconds: 20), () async {
                      if (!isSeen) {
                        if (sl<AppPreferences>().isItUser) {
                          final Response response = await DioFactory().get(
                            '${ApiConstance.sendNotificationToAdmin}/$userId',
                          );

                          if (response.statusCode ==
                              ApiRequestStatusCode.success) {
                            print('success');
                          } else {
                            print('error');
                          }
                        }
                      }
                      messageSubscription.cancel();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatefulWidget {
  final String senderId;
  final String? text;
  final String messageCreatedAt;

  const MessageWidget(this.senderId, this.text,
      {Key? key, required this.messageCreatedAt})
      : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.messageCreatedAt);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: widget.senderId == sl<AppPreferences>().getuserId
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              //
              padding: EdgeInsetsDirectional.only(
                start: widget.senderId == sl<AppPreferences>().getuserId
                    ? 8.w
                    : 10.w,
                end: widget.senderId == sl<AppPreferences>().getuserId
                    ? 10.w
                    : 8.w,
                top: 5.w,
                bottom: 5.w,
              ),
              decoration: BoxDecoration(
                color: widget.senderId == sl<AppPreferences>().getuserId
                    ? AppColors.primary
                    : AppColors.greenIconLight1,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(22.r),
                  topEnd: Radius.circular(22.r),
                  bottomEnd: widget.senderId == sl<AppPreferences>().getuserId
                      ? Radius.circular(22.r)
                      : Radius.zero,
                  bottomStart: widget.senderId == sl<AppPreferences>().getuserId
                      ? Radius.zero
                      : Radius.circular(22.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.white,
                        size: 10.sp,
                      ),
                      5.horizontalSpace,
                      Text(
                        '${dateTime.hour}:${dateTime.minute}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

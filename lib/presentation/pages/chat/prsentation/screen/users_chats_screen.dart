import 'package:aqarat/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersChatsScreen extends StatefulWidget {
  const UsersChatsScreen({Key? key}) : super(key: key);

  @override
  State<UsersChatsScreen> createState() => _UsersChatsScreenState();
}

class _UsersChatsScreenState extends State<UsersChatsScreen> {
  ScrollController scrollController = ScrollController();
  List<bool> isSeenList = List.filled(20, true);

  @override
  void initState() {
    isSeenList = List.filled(20, true);
    // isSeenList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('admin')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(
              child: Text(
                'لا يوجد محادثات',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }

          var usersSnapshot =
              snapshot.data as QuerySnapshot<Map<String, dynamic>>;

          return ListView.builder(
            controller: scrollController,
            itemCount:
                usersSnapshot.docs.isEmpty ? 0 : usersSnapshot.docs.length,
            itemBuilder: (context, index) {
              var userData = usersSnapshot.docs[index].data();
              String userName = userData['user_name'] ?? 'Unknown User';

              return StreamBuilder(
                stream: usersSnapshot.docs[index].reference
                    .collection('messages')
                    .orderBy('created_at', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, messageSnapshot) {
                  if (!messageSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  bool isSeen = messageSnapshot.data!.docs.first.data()['seen'];

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListTile(
                      title: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isSeen
                              ? AppColors.greyLight
                              : AppColors.primary.withAlpha(30),
                          border: Border.all(
                            color: isSeen ? Colors.grey : AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userName,
                                style: const TextStyle(fontSize: 16)),
                            isSeen
                                ? const SizedBox.shrink()
                                : const Text('غير مقروئة',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primary)),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.chat,
                          arguments: {
                            'user_id': userData['id'],
                            'user_name': userData['user_name'],
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

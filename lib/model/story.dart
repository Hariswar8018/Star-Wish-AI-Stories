import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  StoryModel({
    this.timestamp, // Nullable timestamp
    required this.id,
    required this.category,
    required this.public,
    required this.picture,
    required this.admin,
    required this.char1,
    required this.messages,
    required this.views,
    required this.isconversation,
    required this.Story,
    required this.givenwishlist,
    required this.paid,
    required this.amazon,
    required this.affiliate,
    required this.af2,
    required this.af3,
    required this.af4,
    required this.af5,
    required this.af6,
    required this.pic,
    required this.uid,
    required this.Name,
    required this.re13,
    required this.re345,
    required this.num45,
    required this.UserImage,
    required this.UserName,
    required this.UserBio,
    required this.Amzlink,
    required this.goodreadlink,
    required this.kindlelink,
    required this.googlebooklink,
    required this.notionpresslink,
    required this.link1,
    required this.link2,
    required this.conversation_style,
    required this.description,
  });

  final dynamic timestamp; // Accepts FieldValue or Timestamp
  final String id;
  final String category;
  final bool public;
  final String picture;
  final bool admin;
  final String char1;
  final List<MessageModel> messages;
  final int views;

  // Additional Fields
  final bool isconversation;
  final String Story;
  final List<dynamic> givenwishlist;
  final bool paid;
  final String amazon;
  final String affiliate;
  final String af2;
  final String af3;
  final String af4;
  final String af5;
  final String af6;
  final String pic;
  final String uid;
  final String Name;
  final List<dynamic> re13;
  final List<dynamic> re345;
  final int num45;

  // New fields
  final String UserImage;
  final String UserName;
  final String UserBio;
  final String Amzlink;
  final String goodreadlink;
  final String kindlelink;
  final String googlebooklink;
  final String notionpresslink;
  final String link1;
  final String link2;
  final bool conversation_style;
  final String description;

  // Factory Constructor for JSON Deserialization
  StoryModel.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        id = json['id'] ?? '',
        views = json['views'] ?? 0,
        category = json['category'] ?? '',
        public = json['public'] ?? false,
        picture = json['picture'] ?? '',
        admin = json['admin'] ?? false,
        char1 = json['char1'] ?? '',
        messages = (json['messages'] as List<dynamic>?)
            ?.map((msg) => MessageModel.fromJson(msg))
            .toList() ??
            [],
        isconversation = json['isconversation'] ?? false,
        Story = json['Story'] ?? '',
        givenwishlist = json['givenwishlist'] ?? [],
        paid = json['paid'] ?? false,
        amazon = json['amazon'] ?? '',
        affiliate = json['affiliate'] ?? '',
        af2 = json['af2'] ?? '',
        af3 = json['af3'] ?? '',
        af4 = json['af4'] ?? '',
        af5 = json['af5'] ?? '',
        af6 = json['af6'] ?? '',
        pic = json['pic'] ?? '',
        uid = json['uid'] ?? '',
        Name = json['Name'] ?? '',
        re13 = json['re13'] ?? [],
        re345 = json['re345'] ?? [],
        num45 = json['45'] ?? 0,
        UserImage = json['UserImage'] ?? '',
        UserName = json['UserName'] ?? '',
        UserBio = json['UserBio'] ?? '',
        Amzlink = json['Amzlink'] ?? '',
        goodreadlink = json['goodreadlink'] ?? '',
        kindlelink = json['kindlelink'] ?? '',
        googlebooklink = json['googlebooklink'] ?? '',
        notionpresslink = json['notionpresslink'] ?? '',
        link1 = json['link1'] ?? '',
        link2 = json['link2'] ?? '',
        conversation_style = json['conversation_style'] ?? true,
        description = json['description'] ?? '';

  // Method for JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp, // Can be a Firestore FieldValue or a Timestamp
      "id": id,
      "views": views,
      "category": category,
      "public": public,
      "picture": picture,
      "admin": admin,
      "char1": char1,
      "messages": messages.map((msg) => msg.toJson()).toList(),
      "isconversation": isconversation,
      "Story": Story,
      "givenwishlist": givenwishlist,
      "paid": paid,
      "amazon": amazon,
      "affiliate": affiliate,
      "af2": af2,
      "af3": af3,
      "af4": af4,
      "af5": af5,
      "af6": af6,
      "pic": pic,
      "uid": uid,
      "Name": Name,
      "re13": re13,
      "re345": re345,
      "45": num45,
      "UserImage": UserImage,
      "UserName": UserName,
      "UserBio": UserBio,
      "Amzlink": Amzlink,
      "goodreadlink": goodreadlink,
      "kindlelink": kindlelink,
      "googlebooklink": googlebooklink,
      "notionpresslink": notionpresslink,
      "link1": link1,
      "link2": link2,
      "conversation_style": conversation_style,
      "description": description,
    };
  }

  // Factory Constructor for Firestore Snapshot
  static StoryModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return StoryModel.fromJson(snapshot);
  }
}

class MessageModel {
  MessageModel({
    required this.text,
    required this.isMe,
    required this.time,
  });

  final String text;
  final bool isMe;
  final int time;

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'] ?? '',
        isMe = json['isMe'] ?? false,
        time = json['time'] ?? DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "isMe": isMe,
      "time": time,
    };
  }
}

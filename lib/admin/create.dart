import 'package:flutter/material.dart';
import 'package:story_image_ai/model/story.dart';

class StoryModelForm extends StatelessWidget {
  final TextEditingController timestampController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController publicController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final TextEditingController adminController = TextEditingController();
  final TextEditingController char1Controller = TextEditingController();
  final TextEditingController viewsController = TextEditingController();
  final TextEditingController isConversationController = TextEditingController();
  final TextEditingController storyController = TextEditingController();
  final TextEditingController givenWishlistController = TextEditingController();
  final TextEditingController paidController = TextEditingController();
  final TextEditingController amazonController = TextEditingController();
  final TextEditingController affiliateController = TextEditingController();
  final TextEditingController af2Controller = TextEditingController();
  final TextEditingController af3Controller = TextEditingController();
  final TextEditingController af4Controller = TextEditingController();
  final TextEditingController af5Controller = TextEditingController();
  final TextEditingController af6Controller = TextEditingController();
  final TextEditingController picController = TextEditingController();
  final TextEditingController uidController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController re13Controller = TextEditingController();
  final TextEditingController re345Controller = TextEditingController();
  final TextEditingController num45Controller = TextEditingController();

  StoryModelForm({Key? key}) : super(key: key);

  /// Function to create a `TextFormField` with a controller.
  Widget dc(TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story Model Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            dc(categoryController, "Category", "Enter category"),

            dc(pictureController, "Picture", "Enter picture URL"),


            dc(storyController, "Story", "Enter story"),


            dc(paidController, "Paid", "Enter payment status (true/false)"),

            dc(amazonController, "Amazon", "Enter Amazon link"),

            dc(affiliateController, "Affiliate", "Enter affiliate link"),

            dc(af2Controller, "AF2", "Enter AF2"),

            dc(af3Controller, "AF3", "Enter AF3"),
            dc(af4Controller, "AF4", "Enter AF4"),
            dc(af5Controller, "AF5", "Enter AF5"),
            dc(af6Controller, "AF6", "Enter AF6"),

            dc(uidController, "UID", "Enter UID"),
            dc(nameController, "Name", "Enter name"),
            dc(re13Controller, "Re13", "Enter Re13 list"),
            dc(re345Controller, "Re345", "Enter Re345 list"),
            dc(num45Controller, "Num45", "Enter number 45"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Initialize StoryModel without messages.
                final storyModel = StoryModel(
                  timestamp: timestampController.text,
                  id: idController.text,
                  category: categoryController.text,
                  public: publicController.text.toLowerCase() == 'true',
                  picture: pictureController.text,
                  admin: adminController.text.toLowerCase() == 'true',
                  char1: char1Controller.text,
                  views: int.tryParse(viewsController.text) ?? 0,
                  isconversation: isConversationController.text.toLowerCase() == 'true',
                  Story: storyController.text,
                  givenwishlist: givenWishlistController.text.split(','),
                  paid: paidController.text.toLowerCase() == 'true',
                  amazon: amazonController.text,
                  affiliate: affiliateController.text,
                  af2: af2Controller.text,
                  af3: af3Controller.text,
                  af4: af4Controller.text,
                  af5: af5Controller.text,
                  af6: af6Controller.text,
                  pic: picController.text,
                  uid: uidController.text,
                  Name: nameController.text,
                  re13: re13Controller.text.split(','),
                  re345: re345Controller.text.split(','),
                  num45: int.tryParse(num45Controller.text) ?? 0,
                  messages: [], UserImage: '', UserName: '', UserBio: '', Amzlink: '', goodreadlink: '', kindlelink: '',
                  googlebooklink: '', notionpresslink: '', link1: '', link2: '', conversation_style: true, description: '', // Messages left as empty.
                );

                // Display the created StoryModel in debug console
                debugPrint(storyModel.toJson().toString());
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

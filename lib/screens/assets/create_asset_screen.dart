import 'package:flutter/material.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tool_track/managers/storage_manager.dart';

const double kImageSize = 100.0;

class CreateAssetScreen extends StatefulWidget {
  CreateAssetScreen({super.key});

  static const route = 'create_asset';
  final StorageManager storageManager = StorageManager();

  @override
  State<CreateAssetScreen> createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  imageUrl == ''
                      ? Icon(
                          Icons.image_outlined,
                          color: Colors.black45,
                          size: kImageSize,
                        )
                      : Image.network(
                          imageUrl,
                          width: kImageSize,
                          height: kImageSize,
                          fit: BoxFit.cover,
                        ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'Attach Image',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  CardIconButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      String? uploadUrl =
                          await widget.storageManager.addNewImage(image);

                      if (uploadUrl == null) return;
                      print(uploadUrl);
                      setState(() {
                        imageUrl = uploadUrl;
                      });
                    },
                    icon: Icons.attach_file,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  CardIconButton(
                    onPressed: () {
                      ImagePicker imagePicker = ImagePicker();
                      imagePicker.pickImage(source: ImageSource.camera);
                    },
                    icon: Icons.camera_alt_outlined,
                  ),
                ],
              ),
              SizedBox(
                height: kFormElemetsGap * 2,
              ),
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Write here",
                ),
              ),
              SizedBox(
                height: kFormElemetsGap,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
              ),
              SizedBox(
                height: kFormElemetsGap,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 16.0),
                child: RectButton(
                  text: "CREATE",
                  onPressed: () {},
                  color: kSecondaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CardIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      borderRadius: BorderRadius.circular(6.0),
      child: IconButton(
        onPressed: () {
          this.onPressed();
        },
        iconSize: 30.0,
        icon: Icon(
          this.icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}

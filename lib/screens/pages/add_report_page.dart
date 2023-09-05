import 'package:flutter/material.dart';
import 'package:responder/widgets/button_widget.dart';
import 'package:responder/widgets/textfield_widget.dart';

import '../../widgets/text_widget.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final contactnumberController = TextEditingController();
  final addressController = TextEditingController();
  final captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: 'REPORT ACCIDENT',
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Contact Number',
              controller: contactnumberController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Address',
              controller: addressController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Caption',
              controller: captionController,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              label: 'Continue',
              onPressed: () {
                previewDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  previewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextWidget(
            text: 'Preview:',
            fontSize: 18,
            fontFamily: 'Bold',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Contact Number',
                controller: contactnumberController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Caption',
                controller: captionController,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'Close',
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'Send',
                fontSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
}

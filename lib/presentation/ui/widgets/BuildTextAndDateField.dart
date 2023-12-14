import 'package:flutter/material.dart';

Widget buildTextField(String Title , TextEditingController controller, String label , String kType ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      SizedBox(height: 10,),
      TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: kType=="number" ? TextInputType.number:TextInputType.text,
      ),
    ],
  );
}




class DropdownTextField extends StatelessWidget {
  final String title;
  final List<String> items;
  final TextEditingController controller;

  DropdownTextField({required this.title, required this.items, required this.controller});

  @override
  Widget build(BuildContext context) {
    String? selectedValue = controller.text.isEmpty ? null : controller.text; // Set initially to null if controller is empty
    print("AKSFMASf");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        DropdownButtonFormField<String?>(
          value: selectedValue, // Set initially to null
          items: [
            DropdownMenuItem<String?>(
              value: null, // Value for null
              child: Text("Select an option"),
            ),
            ...items.map((item) {
              return DropdownMenuItem<String?>(
                value: item,
                child: Text(item),
              );
            }),
          ],
          onChanged: (value) {
            // Update the selected value in the controller
            if (value != null) {
              controller.text = value;
            } else {
              controller.text = ""; // Handle null value by clearing the text
            }
          },
          decoration: InputDecoration(
            // labelText: 'Select $title',
          ),
        ),
      ],
    );
  }
}


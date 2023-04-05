import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:local_db/db_helper/my_db_helper.dart';
import 'package:local_db/model/contact.dart';

class NewContact extends StatefulWidget {
//  NewContact({Key? key}) : super(key: key);
  Contact? contact;

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
            child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  label: Text('Name'),
                  hintText: 'Please Enter Name',
                  prefixIcon: Icon(Icons.person)),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  label: Text('Phone'),
                  hintText: 'Please Enter Number',
                  prefixIcon: Icon(Icons.call)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                    if(widget.contact == null){
                       await  MyDbHelper.createContact(Contact(
                    name: _nameController.text,
                    phone: _phoneController.text,
                  ));
                  Navigator.pop(context);
                    }
                },
                child: Text('Save Data')
                ),
          ],
        ),
        ),
      ),
    );
  }
}

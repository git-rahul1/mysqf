import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_db/db_helper/my_db_helper.dart';
import 'package:local_db/model/contact.dart';
import 'package:local_db/widgets/new_contact.dart';

class Demo extends StatefulWidget {
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact List',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: MyDbHelper.readContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Loading ...'),
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('Vai Data Nai '),
                )
              : ListView(
                  children: snapshot.data!.map((e) {
                    print("ppppppppppppppppppppppppppppp, ${e.name}");
                    return Center(
                      child: ListTile(
                          title: Text(
                            e.name,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(e.phone),
                          trailing: IconButton(
                            onPressed: () async {
                              await MyDbHelper.deleteContact(e.id!);
                              setState(() {
                                
                              });
                            },
                            icon: Icon(Icons.delete),
                          )),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewContact()));

          setState(() {
            //if return true, rebuild whole widget
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

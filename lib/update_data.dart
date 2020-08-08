import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateData extends StatefulWidget {
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController _nameController = TextEditingController();

  CollectionReference ref = Firestore.instance.collection('product');
  CollectionReference ref1 = Firestore.instance.collection('product1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data.documents[index].data;
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                    size: 28,
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    _nameController.text = doc['name'];
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Center(
                                    child: Text(
                                  'Enter your Name',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextField(
                                  style: TextStyle(color: Colors.black),
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Name Here',
                                    hintText: 'Enter Name Here',
                                  ),
                                  autofocus: false,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    snapshot.data.documents[index].reference
                                        .updateData({
                                      "name": _nameController.text
                                    }).whenComplete(
                                      () => Navigator.pop(context),
                                    );
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        doc['name'],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

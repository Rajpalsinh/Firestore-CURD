import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MaaEnterprise extends StatefulWidget {
  @override
  _MaaEnterpriseState createState() => _MaaEnterpriseState();
}

class _MaaEnterpriseState extends State<MaaEnterprise> {

  CollectionReference ref = Firestore.instance.collection('data');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maa Enterprise'),
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
//              print(doc);
//              print(doc['boltType']['type']);
//              print(doc['boltType']['ItemsData']);
              print(doc['boltType']['ItemsData']);

//              List list =  doc.map((array) => array['items']).toList();
//              print(list);

              return ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 28,
                  ),
                  color: Colors.redAccent,
                  onPressed: () {
                    snapshot.data.documents[index].reference.delete();
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
                        "doc",
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

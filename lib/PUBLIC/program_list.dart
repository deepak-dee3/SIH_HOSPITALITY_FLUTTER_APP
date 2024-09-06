import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventListPages extends StatefulWidget {
  @override
  _EventListPagesState createState() => _EventListPagesState();
}

class _EventListPagesState extends State<EventListPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events List'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('BEFORE EVENT').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
            return Center(child: Text('No events found.'));
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(event['Program'] ?? 'No Program Name'),
                subtitle: Text(event['Hospital_name'] ?? 'No Hospital Name'),
                contentPadding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blueAccent),
                ),
                tileColor: Colors.blue[50],
                // Removed the onTap function to disable navigation
              );
            },
          );
        },
      ),
    );
  }
}

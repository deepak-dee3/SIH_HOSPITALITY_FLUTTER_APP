/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shimmer/shimmer.dart';


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin_after_list extends StatefulWidget{
  @override
  State<Admin_after_list> createState() => _Admin_after_listState();
}

class _Admin_after_listState extends State<Admin_after_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsListPages extends StatefulWidget {
  @override
  _EventsListPagesState createState() => _EventsListPagesState();
}

class _EventsListPagesState extends State<EventsListPages> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(alignment: Alignment.center,
        child:Column(
        children: [
          SizedBox(height:screenHeight*0.05),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by hospital name, program, or date...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('AFTER EVENT')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                  return Center(child: Text('No events found.'));
                }

                final events = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final hospitalName = data['Hospital_name'].toLowerCase();
                  final program = data['Program'].toLowerCase();
                  final date = data['Date Of Event'].toLowerCase();
                  return hospitalName.contains(_searchQuery) ||
                      program.contains(_searchQuery) ||
                      date.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        height: 100,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blueAccent),
                          ),
                          tileColor: Colors.blue,
                          title: Text(
                            event['Program'].toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Icon(Icons.location_pin, color: Colors.green),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  event['Hospital_name'].toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          trailing: Text(
                            event['Date Of Event'],
                            style: TextStyle(
                              color: Color.fromARGB(255, 148, 26, 17),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'all_details_of_event.dart';
class EventsListPages extends StatefulWidget {
  @override
  _EventsListPagesState createState() => _EventsListPagesState();
}

class _EventsListPagesState extends State<EventsListPages> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return  WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return true;
      },
      child:Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by hospital name, program, or date...',
                  prefixIcon: Icon(Icons.search),
                  fillColor: const Color.fromARGB(255, 5, 170, 10),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('AFTER EVENT')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
                    return Center(child: Text('No events found.'));
                  }

                  final events = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final hospitalName = data['Hospital_name'].toLowerCase();
                    final program = data['Program'].toLowerCase();
                    final date = data['Date Of Event'].toLowerCase();
                    return hospitalName.contains(_searchQuery) ||
                        program.contains(_searchQuery) ||
                        date.contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          height: 100,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.blueAccent),
                            ),
                            tileColor: Colors.blue,
                            title: Text(
                              event['Program'].toUpperCase(),
                              maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin, color: Colors.green),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    event['Hospital_name'].toUpperCase(),
                                    maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Text(
                              event['Date Of Event'],
                              maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                              style: TextStyle(
                                color: Color.fromARGB(255, 148, 26, 17),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailPage(event: event,program: event['Program'],hospital:event['Hospital_name']),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}


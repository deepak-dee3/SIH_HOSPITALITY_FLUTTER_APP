import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih2024/ADMIN/fulldetails_hospital.dart';

class HospitalList extends StatefulWidget {
  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  // Reference to Firestore collection
  final CollectionReference hospitalCollection =
      FirebaseFirestore.instance.collection("HOSPITAL'S");

  String searchQuery = ""; // Variable to store search query

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.07),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Update search query
                });
              },
              decoration: InputDecoration(
                hintText: 'Search hospitals or locations...',
                prefixIcon: Icon(Icons.search,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 5, 170, 10),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: hospitalCollection.snapshots(),
                  builder: (context, snapshot) {
                    // Check if the snapshot has data
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // Convert Firestore documents to a list
                    final hospitals = snapshot.data!.docs;

                    // Filter hospitals based on search query
                   final filteredHospitals = hospitals.where((doc) {
  var hospitalData = doc.data() as Map<String, dynamic>;
  var hospitalName = hospitalData['hospital_name']?.toUpperCase() ?? 'No Name';
  var location = hospitalData['location']?.toUpperCase() ?? 'No Location';
  var query = searchQuery.toUpperCase();
  return hospitalName.contains(query) || location.contains(query);
}).toList();


                    return ListView.builder(
                      itemCount: filteredHospitals.length,
                      itemBuilder: (context, index) {
                        // Extract hospital data
                        var hospitalData = filteredHospitals[index].data() as Map<String, dynamic>;

                        // Display hospital name as title and location as subtitle
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.blue, // Tile color
                              borderRadius: BorderRadius.circular(20), // BorderRadius
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              onTap: () {
                                // Navigate to the details page on tap, passing the hospital data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalDetailsPage(
                                      hospitalData: hospitalData,
                                    ),
                                  ),
                                );
                              },
                              title: Row(
                                children: [
                                  Icon(Icons.local_hospital, color: const Color.fromARGB(255, 40, 235, 47)),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    hospitalData['hospital_name'].toUpperCase() ?? 'No Name',
                                    maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenHeight * 0.01), // Space between title and subtitle
                                  Row(
                                    children: [
                                      //Icon(Icons.location_pin, color: Colors.white70),
                                      SizedBox(width: screenWidth * 0.04),
                                      Text(
                                        hospitalData['location'].toUpperCase() ?? 'No Location',
                                        maxLines: 1, 
                                            overflow: TextOverflow.ellipsis, 
                                        style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

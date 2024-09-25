import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewOwner extends StatelessWidget {
  final String bookingId;
   ReviewOwner({required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ratings')
            .where('bookingId',
                isEqualTo: bookingId) // ดึงเฉพาะการให้คะแนนของ booking นี้
            .orderBy('timestamp', descending: true) // เรียงตามเวลาล่าสุด
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No ratings available.'));
          }

          final ratings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final ratingData = ratings[index].data() as Map<String, dynamic>;
              final rating = ratingData['rating'] as double;
              final timestamp = ratingData['timestamp'] as Timestamp;

              return ListTile(
                leading: RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                  direction: Axis.horizontal,
                ),
                title: Text('Rating: $rating'),
                subtitle: Text(
                    'Date: ${timestamp.toDate().toString()}'), // แปลง timestamp เป็นวันที่
              );
            },
          );
        },
      ),
    );
  }
}
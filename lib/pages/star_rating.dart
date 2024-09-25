import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StarRatingPopup extends StatefulWidget {
  final String bookingId; // Pass the booking ID to identify the booking
  StarRatingPopup({required this.bookingId});

  @override
  _StarRatingPopupState createState() => _StarRatingPopupState();
}

class _StarRatingPopupState extends State<StarRatingPopup> {
  final _firestore = FirebaseFirestore.instance;
  double _rating = 0.0;

  void _submitRating() async {
    // Save the rating to Firestore
    await _firestore.collection('ratings').add({
      'bookingId': widget.bookingId, // Save the booking ID
      'rating': _rating,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // After submitting, navigate to the result page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RatingResultPage(
          bookingId: widget.bookingId,
          rating: _rating,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate This Booking'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            itemSize: 40,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Rating: $_rating',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _submitRating,
          child: Text('Submit'),
        ),
      ],
    );
  }
}

// Create a new screen to display the rating result
class RatingResultPage extends StatelessWidget {
  final String bookingId;
  final double rating;

  RatingResultPage({required this.bookingId, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การรีวิวของคุณ'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Booking ID: $bookingId',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Text(
                'Your Rating: $rating',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),SizedBox(height: 70,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 218, 118, 24), // สีของข้อความบนปุ่ม
                  elevation: 5, // ความสูงเงาของปุ่ม
                  shadowColor: Colors.black, // สีเงาของปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // ปรับขอบปุ่มให้โค้ง
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RatingHistoryPage(
                        bookingId:
                            bookingId, // ส่ง bookingId เพื่อกรองการให้คะแนนของ booking นั้น
                      ),
                    ),
                  );
                },
                child: Text('ดูรีวิวทั้งหมด'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create a new screen to display the rating history
class RatingHistoryPage extends StatelessWidget {
  final String bookingId;

  RatingHistoryPage({required this.bookingId});

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

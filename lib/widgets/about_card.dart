import 'package:flutter/material.dart';

class AboutCard extends StatefulWidget {
  const AboutCard({super.key});

  @override
  State<AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromRGBO(22, 35, 41, 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white, size: 20),
                  onPressed: null,
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
          Text(
            'Add in your your to help others know you better',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.52),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

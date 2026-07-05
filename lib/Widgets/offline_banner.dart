import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "You're offline.",
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Showing what we already have. New things will appear when you're back.",
                  style: GoogleFonts.workSans(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                  ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

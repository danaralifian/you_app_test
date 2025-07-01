import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileInfo extends StatelessWidget {
  final DateTime birthday;
  final String horoscope;
  final String zodiac;
  final int? height;
  final int? weight;

  const ProfileInfo({
    super.key,
    required this.birthday,
    required this.horoscope,
    required this.zodiac,
    this.height,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    final age =
        DateTime.now().year -
        birthday.year -
        (DateTime.now().month < birthday.month ||
                (DateTime.now().month == birthday.month &&
                    DateTime.now().day < birthday.day)
            ? 1
            : 0);
    final formattedBirthday = DateFormat('dd / MM / yyyy').format(birthday);

    Widget infoItem(String label, String value, {bool isDimmed = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$label: ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 15,
      direction: Axis.vertical,
      children: [
        infoItem('Birthday', '$formattedBirthday (Age $age)'),
        infoItem('Horoscope', horoscope),
        infoItem('Zodiac', zodiac),
        infoItem(
          'Height',
          height != null ? '$height cm' : '--',
          isDimmed: height == null,
        ),
        infoItem(
          'Weight',
          weight != null ? '$weight kg' : '--',
          isDimmed: weight == null,
        ),
      ],
    );
  }
}

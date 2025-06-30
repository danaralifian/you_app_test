Map<String, String> getHoroscopeAndZodiac(DateTime birthDate) {
  final horoscopes = [
    {
      "sign": "Capricorn",
      "start": DateTime(0, 12, 22),
      "end": DateTime(0, 1, 19),
    },
    {
      "sign": "Aquarius",
      "start": DateTime(0, 1, 20),
      "end": DateTime(0, 2, 18),
    },
    {"sign": "Pisces", "start": DateTime(0, 2, 19), "end": DateTime(0, 3, 20)},
    {"sign": "Aries", "start": DateTime(0, 3, 21), "end": DateTime(0, 4, 19)},
    {"sign": "Taurus", "start": DateTime(0, 4, 20), "end": DateTime(0, 5, 20)},
    {"sign": "Gemini", "start": DateTime(0, 5, 21), "end": DateTime(0, 6, 20)},
    {"sign": "Cancer", "start": DateTime(0, 6, 21), "end": DateTime(0, 7, 22)},
    {"sign": "Leo", "start": DateTime(0, 7, 23), "end": DateTime(0, 8, 22)},
    {"sign": "Virgo", "start": DateTime(0, 8, 23), "end": DateTime(0, 9, 22)},
    {"sign": "Libra", "start": DateTime(0, 9, 23), "end": DateTime(0, 10, 22)},
    {
      "sign": "Scorpio",
      "start": DateTime(0, 10, 23),
      "end": DateTime(0, 11, 21),
    },
    {
      "sign": "Sagittarius",
      "start": DateTime(0, 11, 22),
      "end": DateTime(0, 12, 21),
    },
  ];

  String horoscope = '';
  for (var h in horoscopes) {
    final start = h['start'] as DateTime;
    final end = h['end'] as DateTime;
    final current = DateTime(0, birthDate.month, birthDate.day);

    if ((start.month == 12 && current.month == 1 && current.day <= end.day) ||
        (current.isAfter(start) && current.isBefore(end)) ||
        (current.month == start.month && current.day >= start.day)) {
      horoscope = h['sign'] as String;
      break;
    }
  }

  const zodiacList = [
    "Rat",
    "Ox",
    "Tiger",
    "Rabbit",
    "Dragon",
    "Snake",
    "Horse",
    "Goat",
    "Monkey",
    "Rooster",
    "Dog",
    "Pig",
  ];
  final zodiac = zodiacList[birthDate.year % 12];

  return {"horoscope": horoscope, "zodiac": zodiac};
}

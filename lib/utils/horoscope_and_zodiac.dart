Map<String, String> getHoroscopeAndZodiac(DateTime birthDate) {
  final List<List<Object>> horoscopes = [
    ["Capricorn", 1222, 119],
    ["Aquarius", 120, 218],
    ["Pisces", 219, 320],
    ["Aries", 321, 419],
    ["Taurus", 420, 520],
    ["Gemini", 521, 621],
    ["Cancer", 622, 722],
    ["Leo", 723, 822],
    ["Virgo", 823, 922],
    ["Libra", 923, 1023],
    ["Scorpio", 1024, 1121],
    ["Sagittarius", 1122, 1221],
  ];

  final mmdd = birthDate.month * 100 + birthDate.day;

  final horoscope =
      horoscopes.firstWhere(
            (h) =>
                (mmdd >= (h[1] as int) && mmdd <= (h[2] as int)) ||
                ((h[1] as int) > (h[2] as int) &&
                    (mmdd >= (h[1] as int) || mmdd <= (h[2] as int))),
            orElse: () => ["Capricorn", 1222, 119],
          )[0]
          as String;

  const chineseZodiacs = [
    "Monkey",
    "Rooster",
    "Dog",
    "Pig",
    "Rat",
    "Ox",
    "Tiger",
    "Rabbit",
    "Dragon",
    "Snake",
    "Horse",
    "Goat",
  ];

  final zodiacIndex = (birthDate.year - 2016) % 12;
  final zodiac =
      chineseZodiacs[zodiacIndex < 0 ? zodiacIndex + 12 : zodiacIndex];

  return {"horoscope": horoscope, "zodiac": zodiac};
}

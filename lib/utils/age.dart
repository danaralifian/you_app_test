int? calculateAge(DateTime? birthday) {
  if (birthday == null) return null;

  final today = DateTime.now();
  int age = today.year - birthday.year;

  if (today.month < birthday.month ||
      (today.month == birthday.month && today.day < birthday.day)) {
    age--;
  }

  return age;
}

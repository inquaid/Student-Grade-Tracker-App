class Subject {
  final String name;
  final double _mark;

  Subject(this.name, this._mark);

  double get mark => _mark;

  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }
}

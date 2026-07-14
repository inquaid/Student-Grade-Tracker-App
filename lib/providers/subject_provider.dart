import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    // Map list of subjects to their marks, sum them, and divide by count
    final totalMarks = _subjects.map((s) => s.mark).reduce((a, b) => a + b);
    return totalMarks / _subjects.length;
  }

  String get overallGrade {
    final avg = averageMark;
    if (_subjects.isEmpty) return 'N/A';
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  int get passingSubjectsCount {
    // Filter subjects where mark is passing (>= 50)
    return _subjects.where((s) => s.mark >= 50).length;
  }

  int get failingSubjectsCount {
    return _subjects.where((s) => s.mark < 50).length;
  }

  double get passingPercentage {
    if (_subjects.isEmpty) return 0.0;
    return (passingSubjectsCount / totalSubjects) * 100;
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void insertSubject(int index, Subject subject) {
    if (index >= 0 && index <= _subjects.length) {
      _subjects.insert(index, subject);
      notifyListeners();
    }
  }

  void removeSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }
}

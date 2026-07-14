import 'package:flutter/material.dart';

/// A custom [ThemeExtension] to provide themed grade colors
/// directly from [Theme.of(context)] without hardcoding them in UI.
class GradeColors extends ThemeExtension<GradeColors> {
  final Color gradeA;
  final Color gradeB;
  final Color gradeC;
  final Color gradeF;

  const GradeColors({
    required this.gradeA,
    required this.gradeB,
    required this.gradeC,
    required this.gradeF,
  });

  Color getColorForGrade(String grade) {
    switch (grade) {
      case 'A':
        return gradeA;
      case 'B':
        return gradeB;
      case 'C':
        return gradeC;
      case 'F':
      default:
        return gradeF;
    }
  }

  @override
  ThemeExtension<GradeColors> copyWith({
    Color? gradeA,
    Color? gradeB,
    Color? gradeC,
    Color? gradeF,
  }) {
    return GradeColors(
      gradeA: gradeA ?? this.gradeA,
      gradeB: gradeB ?? this.gradeB,
      gradeC: gradeC ?? this.gradeC,
      gradeF: gradeF ?? this.gradeF,
    );
  }

  @override
  ThemeExtension<GradeColors> lerp(
    ThemeExtension<GradeColors>? other,
    double t,
  ) {
    if (other is! GradeColors) return this;
    return GradeColors(
      gradeA: Color.lerp(gradeA, other.gradeA, t)!,
      gradeB: Color.lerp(gradeB, other.gradeB, t)!,
      gradeC: Color.lerp(gradeC, other.gradeC, t)!,
      gradeF: Color.lerp(gradeF, other.gradeF, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  // Light Theme definitions
  static ThemeData get lightTheme {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5), // Indigo
      brightness: Brightness.light,
      primary: const Color(0xFF4F46E5),
      secondary: const Color(0xFF0D9488), // Teal
      surface: const Color(0xFFFFFFFF),
      error: const Color(0xFFE11D48), // Rose
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: baseColorScheme,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Off-white/slate-50

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
        iconTheme: IconThemeData(color: Color(0xFF1E293B)),
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFFFFFFFF),
        elevation: 2,
        shadowColor: const Color(0x0F000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F5F9), // Slate 100
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE11D48), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE11D48), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF64748B)),
        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: const Color(0xFFFFFFFF),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Color(0xFF4F46E5),
        unselectedItemColor: Color(0xFF94A3B8),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E293B),
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF334155)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF475569)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
      ),

      extensions: const <ThemeExtension<dynamic>>[
        GradeColors(
          gradeA: Color(0xFF10B981), // Emerald
          gradeB: Color(0xFF3B82F6), // Blue
          gradeC: Color(0xFFF59E0B), // Amber
          gradeF: Color(0xFFEF4444), // Red
        ),
      ],
    );
  }

  // Dark Theme definitions
  static ThemeData get darkTheme {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF8B5CF6), // Violet
      brightness: Brightness.dark,
      primary: const Color(0xFF8B5CF6),
      secondary: const Color(0xFF14B8A6), // Light Teal
      surface: const Color(0xFF1E293B), // Slate 800
      error: const Color(0xFFF43F5E), // Rose-dark
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: baseColorScheme,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF8FAFC),
        ),
        iconTheme: IconThemeData(color: Color(0xFFF8FAFC)),
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B), // Slate 800
        elevation: 4,
        shadowColor: const Color(0x3F000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A), // Slate 900
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF43F5E), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF43F5E), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6),
          foregroundColor: const Color(0xFFFFFFFF),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E293B),
        selectedItemColor: Color(0xFF8B5CF6),
        unselectedItemColor: Color(0xFF64748B),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF8FAFC),
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFFF8FAFC),
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFE2E8F0)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFCBD5E1)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
      ),

      extensions: const <ThemeExtension<dynamic>>[
        GradeColors(
          gradeA: Color(0xFF34D399), // Soft Emerald
          gradeB: Color(0xFF60A5FA), // Soft Blue
          gradeC: Color(0xFFFBBF24), // Soft Amber
          gradeF: Color(0xFFF87171), // Soft Red
        ),
      ],
    );
  }
}

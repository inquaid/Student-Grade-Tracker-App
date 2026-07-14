# Student Grade Tracker App

A premium, state-of-the-art Flutter application built for tracking student subjects, marks, grades, and overall performance. The application is designed with modern aesthetics (glassmorphism accents, vibrant gradients, and customized typography) and implements clean architecture best practices.

---

## Key Features

1. **Add Subject Screen**:
   - Validation-secured form for adding subjects and marks.
   - Restricts mark values to a valid range of `0–100`.
   - Clears inputs upon successful addition and automatically redirects to the list view for high-end UX.

2. **Subject List Screen**:
   - Lists all subjects showing name, mark, grade, and passing/failing status.
   - Smooth **Swipe-to-Delete** using `Dismissible`.
   - Supports **Undo Actions** via a custom confirmation SnackBar.

3. **Result Summary Screen**:
   - Live-updating dashboard computing metrics on-the-fly.
   - Displays:
     - **Total Subjects** enrolled.
     - **Average Mark** across all subjects.
     - **Overall Grade** calculated from the average.
     - **Passing Rate** illustrated using a custom circular progress indicator.
     - **Performance Breakdown** counts for passing vs. failing subjects.

4. **Dynamic Custom Theming**:
   - Supports Light Mode (clean Indigo theme) and Dark Mode (obsidian Slate theme).
   - Custom AppBar toggle.
   - **Zero Hardcoded Colors**: Colors are derived entirely from `Theme.of(context)` using custom `ColorScheme` palettes and a dedicated `GradeColors` custom `ThemeExtension`.

---

## Technical Highlights

- **State Management**: Built entirely with `provider` to manage app state globally.
- **Zero `setState`**: Absolutely zero `setState` calls are used anywhere in the app (even bottom navigation and form resets are fully reactive).
- **Functional Programming**: Leverages Dart's collections manipulation (`.map()` to extract scores for average calculation, and `.where()` to filter passing and failing subjects).
- **Clean Architecture**:
  ```
  lib/
  ├── main.dart             # App initialization and MultiProvider setup
  ├── models/
  │   └── subject.dart      # Subject model and letter grade mapping logic
  ├── providers/
  │   ├── navigation.dart   # Page navigation state
  │   ├── subject.dart      # Subject collection and live-calculated analytics
  │   └── theme.dart        # Active theme state (light/dark mode toggle)
  ├── theme/
  │   └── app_theme.dart    # ThemeData configurations and GradeColors extensions
  └── screens/
      ├── home_screen.dart          # Navigational shell with BottomNavigationBar
      ├── add_subject_screen.dart   # Validation form
      ├── subject_list_screen.dart  # Dismissible lists
      └── summary_screen.dart       # Interactive live statistics dashboard
  ```

---

## Getting Started

### Prerequisites
- Flutter SDK (`>= 3.0.0`)
- Dart SDK (`>= 3.0.0`)

### Installation & Execution

1. Clone this repository (if not already done).
2. Navigate to the `assignment4` directory:
   ```bash
   cd assignment4
   ```
3. Fetch package dependencies:
   ```bash
   flutter pub get
   ```
4. Run static analysis to verify a warning-free build:
   ```bash
   flutter analyze
   ```
5. Launch the application:
   ```bash
   flutter run
   ```

---

## Requirements Checklist Status
- [x] Subject class has private `_mark` field and grade getter.
- [x] `.map()` and `.where()` used in data processing.
- [x] Form validates empty names and marks out of range (0-100).
- [x] Dismissible swipe-to-delete deletes subjects.
- [x] Custom light/dark ThemeData configurations (zero default themes or hardcoded colors).
- [x] Zero `setState` calls in the entire app.
- [x] Public repo with 3+ commits and README.

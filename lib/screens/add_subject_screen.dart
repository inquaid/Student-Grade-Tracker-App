import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subject.dart';
import '../providers/subject_provider.dart';
import '../providers/navigation_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _markController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _markController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final mark = double.parse(_markController.text.trim());

      // Use read instead of watch to avoid unnecessary rebuilds of this widget during click
      context.read<SubjectProvider>().addSubject(Subject(name, mark));

      // Clear the form fields
      _nameController.clear();
      _markController.clear();

      // Show a premium design snackbar confirming success
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                'Added "$name" successfully!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to the list screen (index 1) to show the new subject
      context.read<NavigationProvider>().setIndex(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acquire the current theme data for typography and colors
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          key: const ValueKey('add_subject_container'),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text('Add New Subject', style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(
                  'Enter the subject name and marks to calculate the grade.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),

                // Subject Name field
                Text(
                  'Subject Name',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Mathematics, Physics',
                    prefixIcon: Icon(Icons.book_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Marks field
                Text(
                  'Marks Obtains',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _markController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g., 85.5 or 90',
                    prefixIcon: Icon(Icons.percent_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the marks';
                    }
                    final parsed = double.tryParse(value.trim());
                    if (parsed == null) {
                      return 'Please enter a valid numeric value';
                    }
                    if (parsed < 0 || parsed > 100) {
                      return 'Marks must be between 0 and 100';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('Add Subject'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

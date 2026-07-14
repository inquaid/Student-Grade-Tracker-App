import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_theme.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final theme = Theme.of(context);
    final gradeColors = theme.extension<GradeColors>()!;
    final subjects = subjectProvider.subjects;

    if (subjects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Subjects Added Yet',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add subjects with their marks to see them listed here along with their grades.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.read<NavigationProvider>().setIndex(0);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 48),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Go to Add Subject'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final gradeColor = gradeColors.getColorForGrade(subject.grade);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Dismissible(
              key: ValueKey(subject),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                final removedSubject = subject;
                final originalIndex = index;

                // Perform deletion in Provider
                subjectProvider.removeSubject(index);

                // Show undo SnackBar
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Deleted "${removedSubject.name}"',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: theme.colorScheme.secondary,
                      onPressed: () {
                        context.read<SubjectProvider>().insertSubject(
                          originalIndex,
                          removedSubject,
                        );
                      },
                    ),
                  ),
                );
              },
              background: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              child: Card(
                margin: EdgeInsets
                    .zero, // Use zero margin since we pad the list items
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: gradeColor.withAlpha(30),
                    child: Text(
                      subject.grade,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: gradeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    subject.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface.withAlpha(20),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Mark: ${subject.mark.toStringAsFixed(1)} / 100',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          subject.mark >= 50
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 16,
                          color: subject.mark >= 50
                              ? gradeColors.gradeA
                              : gradeColors.gradeF,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          subject.mark >= 50 ? 'Passing' : 'Failed',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: subject.mark >= 50
                                ? gradeColors.gradeA
                                : gradeColors.gradeF,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Icon(
                    Icons.swipe_left_outlined,
                    color: theme.colorScheme.onSurface.withAlpha(80),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

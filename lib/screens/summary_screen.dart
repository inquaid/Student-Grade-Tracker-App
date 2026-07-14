import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_theme.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final theme = Theme.of(context);
    final gradeColors = theme.extension<GradeColors>()!;

    final total = subjectProvider.totalSubjects;
    final average = subjectProvider.averageMark;
    final overallGrade = subjectProvider.overallGrade;
    final passCount = subjectProvider.passingSubjectsCount;
    final failCount = subjectProvider.failingSubjectsCount;
    final passPercent = subjectProvider.passingPercentage;

    if (total == 0) {
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
                  Icons.analytics_outlined,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Data Available',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please add subjects first to generate your grades and performance summary.',
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

    final overallGradeColor = gradeColors.getColorForGrade(overallGrade);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Main Grid for Core Metrics
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildMetricCard(
                    context,
                    title: 'Total Subjects',
                    value: '$total',
                    icon: Icons.book_outlined,
                    iconColor: theme.colorScheme.primary,
                  ),
                  _buildMetricCard(
                    context,
                    title: 'Average Mark',
                    value: average.toStringAsFixed(1),
                    icon: Icons.percent_outlined,
                    iconColor: theme.colorScheme.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Overall Grade Card
              Card(
                margin: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: theme.brightness == Brightness.light
                          ? [
                              overallGradeColor.withAlpha(20),
                              overallGradeColor.withAlpha(5),
                            ]
                          : [
                              overallGradeColor.withAlpha(40),
                              overallGradeColor.withAlpha(10),
                            ],
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: overallGradeColor,
                        child: Text(
                          overallGrade,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Overall Grade',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Based on your accumulated average score of ${average.toStringAsFixed(1)}%.',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Detailed Performance Breakdown
              Text(
                'Performance Details',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Circular Passing Rate indicator
                          Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      value: passPercent / 100,
                                      strokeWidth: 10,
                                      backgroundColor: theme
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(20),
                                      color: gradeColors.gradeA,
                                      strokeCap: StrokeCap.round,
                                    ),
                                    Center(
                                      child: Text(
                                        '${passPercent.toStringAsFixed(0)}%',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Passing Rate',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Raw statistics Breakdown
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStatLabel(
                                label: 'Passing Subjects',
                                count: passCount,
                                color: gradeColors.gradeA,
                                icon: Icons.check_circle_outline,
                              ),
                              const SizedBox(height: 16),
                              _buildStatLabel(
                                label: 'Failing Subjects',
                                count: failCount,
                                color: gradeColors.gradeF,
                                icon: Icons.cancel_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: iconColor),
              ],
            ),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatLabel({
    required String label,
    required int count,
    required Color color,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              '$count ${count == 1 ? 'subject' : 'subjects'}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

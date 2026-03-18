import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/chapter_card.dart';
import '../../data/repositories/chapter_repository.dart';
import '../../domain/entities/chapter_entity.dart';

/// Chapters listing page
/// From Issue #3 - Navigation & Routing
class ChaptersPage extends ConsumerStatefulWidget {
  const ChaptersPage({super.key});

  @override
  ConsumerState<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends ConsumerState<ChaptersPage> {
  ChapterCategory _selectedCategory = ChapterCategory.all;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final chaptersAsync = ref.watch(chaptersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
      body: chaptersAsync.when(
        data: (chapters) => _buildContent(context, chapters),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load chapters'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(chaptersProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<ChapterEntity> chapters) {
    // Apply filters
    final filteredChapters = ref
        .read(filteredChaptersProvider.notifier)
        .filter(chapters, searchQuery: _searchQuery, category: _selectedCategory);

    return ListView(
      padding: const EdgeInsets.all(Spacing.md),
      children: [
        // Category chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ChapterCategory.values.map((category) {
              return _CategoryChip(
                label: category.displayName,
                isSelected: _selectedCategory == category,
                onTap: () {
                  setState(() => _selectedCategory = category);
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: Spacing.lg),

        // Show search results indicator
        if (_searchQuery.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.md),
            child: Row(
              children: [
                Text(
                  'Results for "$_searchQuery"',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() => _searchQuery = ''),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        ],

        // Chapter cards
        if (filteredChapters.isEmpty)
          _buildEmptyState(context)
        else
          ...filteredChapters.map((chapter) => Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: ChapterCard(
                  title: chapter.title,
                  description: chapter.description,
                  icon: chapter.icon,
                  lessonCount: chapter.lessonCount,
                  completedCount: chapter.completedCount,
                  color: chapter.color,
                  isPremium: chapter.isPremium,
                  onTap: () => context.push(
                    AppRoutes.chapterDetailPath(chapter.serverId),
                  ),
                ),
              )),

        const SizedBox(height: Spacing.xl),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: Spacing.md),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No chapters found for "$_searchQuery"'
                  : 'No chapters in this category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.md),
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedCategory = ChapterCategory.all;
                });
              },
              child: const Text('Show all chapters'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSearch(BuildContext context) async {
    final chapters = ref.read(chaptersProvider).valueOrNull ?? [];
    final result = await showSearch<ChapterEntity?>(
      context: context,
      delegate: _ChapterSearchDelegate(chapters: chapters),
    );

    if (result != null && mounted && context.mounted) {
      // ignore: unawaited_futures
      context.push(AppRoutes.chapterDetailPath(result.serverId));
    }
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primary,
      ),
    );
  }
}

/// Search delegate for chapters
class _ChapterSearchDelegate extends SearchDelegate<ChapterEntity?> {
  _ChapterSearchDelegate({required this.chapters});

  final List<ChapterEntity> chapters;

  @override
  String get searchFieldLabel => 'Search chapters...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final queryLower = query.toLowerCase();
    final results = query.isEmpty
        ? chapters
        : chapters.where((chapter) {
            return chapter.title.toLowerCase().contains(queryLower) ||
                chapter.description.toLowerCase().contains(queryLower) ||
                (chapter.titleArabic?.contains(queryLower) ?? false) ||
                (chapter.descriptionArabic?.contains(queryLower) ?? false);
          }).toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: Spacing.md),
            Text(
              query.isEmpty
                  ? 'Start typing to search'
                  : 'No chapters found for "$query"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(Spacing.md),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chapter = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: Spacing.md),
          child: ChapterCard(
            title: chapter.title,
            description: chapter.description,
            icon: chapter.icon,
            lessonCount: chapter.lessonCount,
            completedCount: chapter.completedCount,
            color: chapter.color,
            isPremium: chapter.isPremium,
            onTap: () => close(context, chapter),
          ),
        );
      },
    );
  }
}

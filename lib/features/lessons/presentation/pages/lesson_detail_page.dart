import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../audio/domain/entities/audio_state.dart';
import '../../../audio/presentation/controllers/audio_controller.dart';
import '../../../audio/presentation/widgets/audio_player_widget.dart';
import '../../../bookmarks/data/repositories/bookmark_repository.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../domain/entities/lesson_entity.dart';

/// Lesson detail page with content options
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #8 - Bookmarks Feature
class LessonDetailPage extends ConsumerWidget {
  const LessonDetailPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonProvider(lessonId));

    return lessonAsync.when(
      data: (lesson) {
        if (lesson == null) {
          return _buildNotFound(context);
        }
        return _LessonDetailContent(
          chapterId: chapterId,
          lesson: lesson,
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load lesson'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(lessonProvider(lessonId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textHint),
            const SizedBox(height: Spacing.md),
            Text(
              'Lesson not found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonDetailContent extends ConsumerWidget {
  const _LessonDetailContent({
    required this.chapterId,
    required this.lesson,
  });

  final String chapterId;
  final LessonEntity lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch bookmark state
    final isBookmarkedAsync = ref.watch(isLessonBookmarkedProvider(lesson.id));
    final isBookmarked = isBookmarkedAsync.valueOrNull ?? false;

    // Watch audio state
    final audioState = ref.watch(audioControllerProvider);
    final isPlayingThisLesson = audioState.currentTrackId == lesson.serverId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.secondary : null,
            ),
            onPressed: () async {
              final repo = ref.read(bookmarkRepositoryProvider);
              final wasBookmarked = await repo.toggleBookmark(lesson.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasBookmarked
                          ? 'Added to bookmarks'
                          : 'Removed from bookmarks',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson header image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                image: lesson.thumbnailUrl != null
                    ? DecorationImage(
                        image: NetworkImage(lesson.thumbnailUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: lesson.thumbnailUrl == null
                  ? const Center(
                      child: Icon(
                        Icons.auto_stories,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: Spacing.lg),

            // Completion badge
            if (lesson.isCompleted)
              Container(
                margin: const EdgeInsets.only(bottom: Spacing.md),
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    SizedBox(width: Spacing.xs),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Lesson title
            Text(
              lesson.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.sm),

            // Lesson meta info
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  lesson.duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                if (lesson.hasAudio) ...[
                  const SizedBox(width: Spacing.md),
                  const Icon(
                    Icons.headphones,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Audio available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
                if (lesson.hasQuiz) ...[
                  const SizedBox(width: Spacing.md),
                  const Icon(
                    Icons.quiz,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Quiz available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Spacing.lg),

            // Lesson description
            Text(
              lesson.subtitle ??
                  'In this lesson, you will learn an important story '
                      'with valuable lessons about faith and patience.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: Spacing.xl),

            // Action buttons
            Text(
              'Choose how to learn',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),

            // Read story button
            _LessonOptionCard(
              icon: Icons.menu_book,
              title: 'Read Story',
              subtitle: 'Read the story with illustrations',
              color: AppColors.primary,
              onTap: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lesson.serverId),
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Listen button
            if (lesson.hasAudio)
              _LessonOptionCard(
                icon: isPlayingThisLesson ? Icons.pause : Icons.headphones,
                title: isPlayingThisLesson ? 'Now Playing' : 'Listen to Audio',
                subtitle: isPlayingThisLesson
                    ? 'Tap to show player'
                    : 'Listen to the narration',
                color: AppColors.secondary,
                onTap: () => _openAudioPlayer(context, ref),
              ),
            if (lesson.hasAudio) const SizedBox(height: Spacing.md),

            // Quiz button
            if (lesson.hasQuiz)
              _LessonOptionCard(
                icon: Icons.quiz,
                title: 'Take Quiz',
                subtitle: 'Test your knowledge',
                color: AppColors.success,
                onTap: () => context.push(
                  AppRoutes.quizScreenPath(chapterId, lesson.serverId),
                ),
              ),
            if (lesson.hasQuiz) const SizedBox(height: Spacing.xl),

            // Continue button
            AppButton(
              text: lesson.isCompleted ? 'Read Again' : 'Start Reading',
              onPressed: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lesson.serverId),
              ),
            ),
          ],
        ),
      ),
      // Mini audio player at bottom when playing
      bottomNavigationBar:
          isPlayingThisLesson ? const MiniAudioPlayer() : null,
    );
  }

  void _openAudioPlayer(BuildContext context, WidgetRef ref) {
    final audioState = ref.read(audioControllerProvider);

    // If already playing this lesson, show the player
    if (audioState.currentTrackId?.startsWith(lesson.serverId) ?? false) {
      _showAudioPlayerSheet(context, ref);
      return;
    }

    // Show audio mode selection dialog
    _showAudioModeDialog(context, ref);
  }

  void _showAudioModeDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textHint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            Text(
              'Choose Audio Type',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              'Select how you want to listen to this lesson',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: Spacing.lg),

            // Audio mode options
            ...AudioMode.values.map((mode) => _AudioModeOption(
                  mode: mode,
                  onTap: () {
                    Navigator.pop(context);
                    _playAudioWithMode(context, ref, mode);
                  },
                )),

            const SizedBox(height: Spacing.md),
          ],
        ),
      ),
    );
  }

  void _playAudioWithMode(BuildContext context, WidgetRef ref, AudioMode mode) {
    final audioController = ref.read(audioControllerProvider.notifier);
    final settingsState = ref.read(settingsControllerProvider);
    final language = settingsState.settings.language;

    // Get the appropriate track based on mode and language
    final tracks = LessonAudioHelper.getTracksForLesson(
      lessonId: lesson.serverId,
      lessonTitle: lesson.title,
      lessonTitleArabic: lesson.titleArabic,
      language: language,
      mode: mode,
      durationMinutes: lesson.durationMinutes,
    );

    if (tracks.isNotEmpty) {
      // For now, play the first track (playlist support can be added later)
      audioController.loadAndPlay(tracks.first);
      _showAudioPlayerSheet(context, ref, mode: mode, tracks: tracks);
    }
  }

  void _showAudioPlayerSheet(
    BuildContext context,
    WidgetRef ref, {
    AudioMode? mode,
    List<AudioTrack>? tracks,
  }) {
    final audioState = ref.read(audioControllerProvider);
    final currentTrack = tracks?.firstWhere(
      (t) => t.id == audioState.currentTrackId,
      orElse: () => tracks.first,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textHint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Lesson info
            Text(
              lesson.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentTrack?.trackType == AudioTrackType.quranRecitation
                      ? Icons.menu_book
                      : Icons.record_voice_over,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: Spacing.xs),
                Text(
                  currentTrack?.trackType == AudioTrackType.quranRecitation
                      ? 'Quran Recitation'
                      : 'Story Narration (${currentTrack?.language ?? 'en'})',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.xl),

            // Audio player widget
            const AudioPlayerWidget(),

            // Track list if multiple tracks
            if (tracks != null && tracks.length > 1) ...[
              const SizedBox(height: Spacing.lg),
              const Divider(),
              const SizedBox(height: Spacing.sm),
              Text(
                'Playlist',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: Spacing.sm),
              ...tracks.map((track) => _TrackListItem(
                    track: track,
                    isPlaying: audioState.currentTrackId == track.id,
                    onTap: () {
                      ref.read(audioControllerProvider.notifier).loadAndPlay(track);
                    },
                  )),
            ],

            const SizedBox(height: Spacing.lg),
          ],
        ),
      ),
    );
  }
}

class _LessonOptionCard extends StatelessWidget {
  const _LessonOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Audio mode selection option
class _AudioModeOption extends StatelessWidget {
  const _AudioModeOption({
    required this.mode,
    required this.onTap,
  });

  final AudioMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Spacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(mode.icon, color: AppColors.primary),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mode.displayName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      mode.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.play_arrow, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

/// Track list item for playlist
class _TrackListItem extends StatelessWidget {
  const _TrackListItem({
    required this.track,
    required this.isPlaying,
    required this.onTap,
  });

  final AudioTrack track;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isPlaying
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(
          track.trackType == AudioTrackType.quranRecitation
              ? Icons.menu_book
              : Icons.record_voice_over,
          size: 18,
          color: isPlaying ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
      title: Text(
        track.title,
        style: TextStyle(
          fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
          color: isPlaying ? AppColors.primary : null,
        ),
      ),
      subtitle: Text(
        track.artist ?? '',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
      trailing: isPlaying
          ? const Icon(Icons.equalizer, color: AppColors.primary)
          : const Icon(Icons.play_arrow, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}

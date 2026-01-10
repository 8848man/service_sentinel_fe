import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/service_status.dart';
import '../../design_system/atoms/ss_loading.dart';
import '../../design_system/atoms/ss_empty_state.dart';
import '../../design_system/molecules/ss_service_tile.dart';
import '../../design_system/molecules/ss_status_indicator.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../../shared/error_view.dart';
import '../../../shared/refresh_wrapper.dart';
import 'services_viewmodel.dart';
import 'service_form_screen.dart';
import 'service_detail_screen.dart';

/// Services List Screen
class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    // Load services on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(servicesViewModelProvider.notifier).loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(servicesViewModelProvider);

    return Scaffold(
      appBar: SSAppBar(title: l10n.services),
      body: RefreshWrapper(
        onRefresh: () =>
            ref.read(servicesViewModelProvider.notifier).refreshServices(),
        child: state.when(
          initial: () => const Center(child: SSLoading()),
          loading: () => const Center(child: SSLoading()),
          loaded: (services) => _buildLoadedContent(context, services),
          error: (message) => ErrorView(
            message: message,
            onRetry: () =>
                ref.read(servicesViewModelProvider.notifier).loadServices(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ServiceFormScreen(service: null),
            ),
          );
          // Refresh list if a service was created
          if (result != null && mounted) {
            ref.read(servicesViewModelProvider.notifier).refreshServices();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, List services) {
    final l10n = AppLocalizations.of(context)!;

    if (services.isEmpty) {
      return SSEmptyState(
        icon: Icons.dns_outlined,
        title: l10n.emptyServices,
        description: l10n.emptyServicesDescription,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: SSServiceTile(
            name: service.name,
            status: _mapServiceStatusToIndicatorStatus(service.status ?? ServiceStatus.unknown),
            lastCheckTime: service.lastCheckedAt != null
                ? _formatRelativeTime(service.lastCheckedAt!)
                : null,
            latency: service.lastCheckLatencyMs != null
                ? '${service.lastCheckLatencyMs}ms'
                : null,
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ServiceDetailScreen(serviceId: service.id),
                ),
              );
              // Refresh list if service was deleted
              if (result == 'deleted' && mounted) {
                ref.read(servicesViewModelProvider.notifier).refreshServices();
              }
            },
          ),
        );
      },
    );
  }

  SSStatusType _mapServiceStatusToIndicatorStatus(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.healthy:
        return SSStatusType.healthy;
      case ServiceStatus.warning:
        return SSStatusType.warning;
      case ServiceStatus.down:
        return SSStatusType.down;
      case ServiceStatus.unknown:
        return SSStatusType.unknown;
    }
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

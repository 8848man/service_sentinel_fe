import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_sentinel_fe/presentation/enum/enum.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/service.dart';
import '../../design_system/atoms/ss_button.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import 'service_form_state.dart';
import 'service_form_viewmodel.dart';

/// Service Form Screen (Create or Edit)
class ServiceFormScreen extends ConsumerStatefulWidget {
  final Service? service; // If null, create mode; if not null, edit mode

  const ServiceFormScreen({super.key, this.service});

  @override
  ConsumerState<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends ConsumerState<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _endpointUrlController;
  late String _serviceTypeText;
  late final TextEditingController _timeoutController;
  late final TextEditingController _checkIntervalController;
  late final TextEditingController _failureThresholdController;

  // HTTP Method dropdown
  String _selectedHttpMethod = 'GET';
  final List<String> _httpMethods = [
    'GET',
    'POST',
    'PUT',
    'PATCH',
    'DELETE',
    'HEAD',
    'OPTIONS',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing values if editing
    _nameController = TextEditingController(text: widget.service?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.service?.description ?? '',
    );
    _endpointUrlController = TextEditingController(
      text: widget.service?.endpointUrl ?? '',
    );
    _serviceTypeText = ServiceTypeOption.httpsApi.value;
    _timeoutController = TextEditingController(
      text: widget.service?.timeoutSeconds.toString() ?? '30',
    );
    _checkIntervalController = TextEditingController(
      text: widget.service?.checkIntervalSeconds.toString() ?? '60',
    );
    _failureThresholdController = TextEditingController(
      text: widget.service?.failureThreshold.toString() ?? '3',
    );

    if (widget.service != null) {
      _selectedHttpMethod = widget.service!.httpMethod;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _endpointUrlController.dispose();
    _timeoutController.dispose();
    _checkIntervalController.dispose();
    _failureThresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(serviceFormViewModelProvider(widget.service));
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    // Listen to state changes
    ref.listen<ServiceFormState>(serviceFormViewModelProvider(widget.service), (
      previous,
      next,
    ) {
      next.when(
        initial: (service) {},
        submitting: () {},
        success: (service) {
          Navigator.of(context).pop(service);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.service != null
                    ? l10n.serviceUpdatedSuccess
                    : l10n.serviceCreatedSuccess,
              ),
            ),
          );
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: colors.statusCritical,
            ),
          );
        },
      );
    });

    final isLoading = state.maybeWhen(
      submitting: () => true,
      orElse: () => false,
    );

    return Scaffold(
      appBar: SSAppBar(
        title: widget.service != null
            ? l10n.serviceEditTitle
            : l10n.serviceCreateTitle,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Service Name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.serviceNameLabel,
                hintText: 'My API Service',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                return null;
              },
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.md),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.serviceDescriptionLabel,
                hintText: 'Optional description',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.md),

            // Endpoint URL
            TextFormField(
              controller: _endpointUrlController,
              decoration: InputDecoration(
                labelText: l10n.serviceEndpointLabel,
                hintText: 'https://api.example.com/health',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                if (!value.startsWith('http://') &&
                    !value.startsWith('https://')) {
                  return l10n.invalidUrl;
                }
                return null;
              },
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.md),

            // HTTP Method
            DropdownButtonFormField<String>(
              value: _selectedHttpMethod,
              decoration: InputDecoration(
                labelText: l10n.serviceHttpMethodLabel,
                border: const OutlineInputBorder(),
              ),
              items: _httpMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        _selectedHttpMethod = value!;
                      });
                    },
            ),

            const SizedBox(height: AppSpacing.md),

            // Service Type
            // TextFormField(
            //   controller: _serviceTypeController,
            //   decoration: InputDecoration(
            //     labelText: l10n.serviceTypeLabel,
            //     hintText: 'API, Database, etc.',
            //     border: const OutlineInputBorder(),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return l10n.fieldRequired;
            //     }
            //     return null;
            //   },
            //   enabled: !isLoading,
            // ),
            DropdownButtonFormField<ServiceTypeOption>(
              value: ServiceTypeOption.httpsApi,
              decoration: InputDecoration(
                labelText: l10n.serviceTypeLabel,
                border: const OutlineInputBorder(),
              ),
              items: ServiceTypeOption.values.map((type) {
                return DropdownMenuItem<ServiceTypeOption>(
                  value: type,
                  child: Text(type.value),
                );
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (value) {
                      setState(() {
                        value != null ? _serviceTypeText = value.value : null;
                      });
                    },
              validator: (value) {
                if (value == null) {
                  return l10n.fieldRequired;
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.md),

            // Timeout (seconds)
            TextFormField(
              controller: _timeoutController,
              decoration: InputDecoration(
                labelText: l10n.serviceTimeoutLabel,
                hintText: '30',
                border: const OutlineInputBorder(),
                suffixText: 'seconds',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                final number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return l10n.invalidNumber;
                }
                return null;
              },
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.md),

            // Check Interval (seconds)
            TextFormField(
              controller: _checkIntervalController,
              decoration: InputDecoration(
                labelText: l10n.serviceCheckIntervalLabel,
                hintText: '60',
                border: const OutlineInputBorder(),
                suffixText: 'seconds',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                final number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return l10n.invalidNumber;
                }
                return null;
              },
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.md),

            // Failure Threshold
            TextFormField(
              controller: _failureThresholdController,
              decoration: InputDecoration(
                labelText: l10n.serviceFailureThresholdLabel,
                hintText: '3',
                border: const OutlineInputBorder(),
                helperText: l10n.failureThresholdHelp,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                final number = int.tryParse(value);
                if (number == null || number <= 0) {
                  return l10n.invalidNumber;
                }
                return null;
              },
              enabled: !isLoading,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Submit Button
            SSButton.primary(
              text: widget.service != null
                  ? l10n.buttonSave
                  : l10n.serviceCreate,
              isLoading: isLoading,
              onPressed: isLoading ? null : _submitForm,
            ),

            const SizedBox(height: AppSpacing.md),

            // Cancel Button
            SSButton.secondary(
              text: l10n.buttonCancel,
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'endpoint_url': _endpointUrlController.text.trim(),
        'http_method': _selectedHttpMethod,
        'service_type': _serviceTypeText.trim(),
        'timeout_seconds': int.parse(_timeoutController.text),
        'check_interval_seconds': int.parse(_checkIntervalController.text),
        'failure_threshold': int.parse(_failureThresholdController.text),
      };

      ref
          .read(serviceFormViewModelProvider(widget.service).notifier)
          .submitForm(data, serviceId: widget.service?.id);
    }
  }
}

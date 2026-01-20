import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/enums.dart';
import '../../application/providers/service_provider.dart';
import '../../domain/entities/service.dart';

/// Create service dialog - Form for registering a new service/API
/// Consumes: (will use ServiceRepository via use case when creating)
///
/// Features:
/// - Service name and description
/// - Endpoint URL
/// - HTTP method selection
/// - Service type selection
/// - Basic configuration (timeout, interval, threshold)
/// - Input validation
/// - Loading state within dialog
///
/// Returns: true if service was created successfully
class CreateServiceDialog extends ConsumerStatefulWidget {
  const CreateServiceDialog({super.key});

  @override
  ConsumerState<CreateServiceDialog> createState() => _CreateServiceDialogState();
}

class _CreateServiceDialogState extends ConsumerState<CreateServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _endpointController = TextEditingController();

  HttpMethod _selectedMethod = HttpMethod.get;
  ServiceType _selectedType = ServiceType.httpsApi;
  int _timeoutSeconds = 10;
  int _checkIntervalSeconds = 60;
  int _failureThreshold = 3;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _endpointController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final createData = ServiceCreate(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      endpointUrl: _endpointController.text.trim(),
      httpMethod: _selectedMethod,
      serviceType: _selectedType,
      timeoutSeconds: _timeoutSeconds,
      checkIntervalSeconds: _checkIntervalSeconds,
      failureThreshold: _failureThreshold,
    );

    final useCase = ref.read(createServiceProvider);
    final result = await useCase.execute(createData);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result.isSuccess) {
      // Invalidate services list to refresh
      ref.invalidate(servicesProvider);

      // Close dialog and return the created service
      Navigator.of(context).pop(result.dataOrNull);
    } else {
      setState(() {
        _errorMessage = result.errorOrNull?.message ?? 'Failed to create service';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Add Service'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Service name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name',
                  hintText: 'My API Service',
                  prefixIcon: Icon(Icons.label),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Service name is required';
                  }
                  return null;
                },
                enabled: !_isLoading,
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                enabled: !_isLoading,
              ),

              const SizedBox(height: 16),

              // Endpoint URL
              TextFormField(
                controller: _endpointController,
                decoration: const InputDecoration(
                  labelText: 'Endpoint URL',
                  hintText: 'https://api.example.com/health',
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Endpoint URL is required';
                  }
                  if (!value.startsWith('http://') && !value.startsWith('https://')) {
                    return 'URL must start with http:// or https://';
                  }
                  return null;
                },
                enabled: !_isLoading,
              ),

              const SizedBox(height: 16),

              // HTTP Method
              DropdownButtonFormField<HttpMethod>(
                value: _selectedMethod,
                decoration: const InputDecoration(
                  labelText: 'HTTP Method',
                  prefixIcon: Icon(Icons.http),
                  border: OutlineInputBorder(),
                ),
                items: HttpMethod.values
                    .map((method) => DropdownMenuItem(
                          value: method,
                          child: Text(method.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: _isLoading
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() => _selectedMethod = value);
                        }
                      },
              ),

              const SizedBox(height: 16),

              // Service Type
              DropdownButtonFormField<ServiceType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Service Type',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: ServiceType.values
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type.displayName),
                        ))
                    .toList(),
                onChanged: _isLoading
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() => _selectedType = value);
                        }
                      },
              ),

              const SizedBox(height: 16),

              // Advanced settings
              ExpansionTile(
                title: const Text('Advanced Settings'),
                initiallyExpanded: false,
                children: [
                  const SizedBox(height: 8),
                  // Timeout
                  TextFormField(
                    initialValue: _timeoutSeconds.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Timeout (seconds)',
                      prefixIcon: Icon(Icons.timer),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Invalid number';
                      }
                      final num = int.parse(value);
                      if (num < 1 || num > 300) {
                        return 'Must be between 1-300 seconds';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final num = int.tryParse(value);
                      if (num != null) {
                        setState(() => _timeoutSeconds = num);
                      }
                    },
                    enabled: !_isLoading,
                  ),

                  const SizedBox(height: 12),

                  // Check interval
                  TextFormField(
                    initialValue: _checkIntervalSeconds.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Check Interval (seconds)',
                      prefixIcon: Icon(Icons.schedule),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Invalid number';
                      }
                      final num = int.parse(value);
                      if (num < 30 || num > 3600) {
                        return 'Must be between 30-3600 seconds';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final num = int.tryParse(value);
                      if (num != null) {
                        setState(() => _checkIntervalSeconds = num);
                      }
                    },
                    enabled: !_isLoading,
                  ),

                  const SizedBox(height: 12),

                  // Failure threshold
                  TextFormField(
                    initialValue: _failureThreshold.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Failure Threshold',
                      prefixIcon: Icon(Icons.warning),
                      border: OutlineInputBorder(),
                      helperText: 'Consecutive failures before incident',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || int.tryParse(value) == null) {
                        return 'Invalid number';
                      }
                      final num = int.parse(value);
                      if (num < 1 || num > 10) {
                        return 'Must be between 1-10';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final num = int.tryParse(value);
                      if (num != null) {
                        setState(() => _failureThreshold = num);
                      }
                    },
                    enabled: !_isLoading,
                  ),

                  const SizedBox(height: 8),
                ],
              ),

              // Error message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _handleCreate,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add),
          label: Text(_isLoading ? 'Creating...' : 'Create'),
        ),
      ],
    );
  }
}

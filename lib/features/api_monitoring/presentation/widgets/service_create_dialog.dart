import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/enums.dart';
import '../../application/providers/service_provider.dart';
import '../../domain/entities/service.dart';

/// Service Create Dialog
///
/// Modal dialog for creating a new monitored service/API.
/// Includes comprehensive form validation and error handling.
/// Consumes createServiceProvider for creation logic.
class ServiceCreateDialog extends ConsumerStatefulWidget {
  const ServiceCreateDialog({super.key});

  @override
  ConsumerState<ServiceCreateDialog> createState() => _ServiceCreateDialogState();
}

class _ServiceCreateDialogState extends ConsumerState<ServiceCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _endpointUrlController = TextEditingController();
  final _timeoutController = TextEditingController(text: '10');
  final _checkIntervalController = TextEditingController(text: '60');
  final _failureThresholdController = TextEditingController(text: '3');

  HttpMethod _selectedHttpMethod = HttpMethod.get;
  ServiceType _selectedServiceType = ServiceType.httpsApi;
  bool _isLoading = false;
  String? _errorMessage;

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
      endpointUrl: _endpointUrlController.text.trim(),
      httpMethod: _selectedHttpMethod,
      serviceType: _selectedServiceType,
      timeoutSeconds: int.parse(_timeoutController.text),
      checkIntervalSeconds: int.parse(_checkIntervalController.text),
      failureThreshold: int.parse(_failureThresholdController.text),
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
    return AlertDialog(
      title: const Text('Create New Service'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Service Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Service Name *',
                  hintText: 'e.g., User API',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Service name is required';
                  }
                  if (value.length > 100) {
                    return 'Service name cannot exceed 100 characters';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Endpoint URL Field
              TextFormField(
                controller: _endpointUrlController,
                decoration: const InputDecoration(
                  labelText: 'Endpoint URL *',
                  hintText: 'https://api.example.com/health',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Endpoint URL is required';
                  }
                  final urlPattern = RegExp(r'^https?://');
                  if (!urlPattern.hasMatch(value)) {
                    return 'URL must start with http:// or https://';
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // HTTP Method Dropdown
              DropdownButtonFormField<HttpMethod>(
                value: _selectedHttpMethod,
                decoration: const InputDecoration(
                  labelText: 'HTTP Method *',
                  border: OutlineInputBorder(),
                ),
                items: HttpMethod.values.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method.value),
                  );
                }).toList(),
                onChanged: _isLoading
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() {
                            _selectedHttpMethod = value;
                          });
                        }
                      },
              ),
              const SizedBox(height: 16),

              // Service Type Dropdown
              DropdownButtonFormField<ServiceType>(
                value: _selectedServiceType,
                decoration: const InputDecoration(
                  labelText: 'Service Type *',
                  border: OutlineInputBorder(),
                ),
                items: ServiceType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName),
                  );
                }).toList(),
                onChanged: _isLoading
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() {
                            _selectedServiceType = value;
                          });
                        }
                      },
              ),
              const SizedBox(height: 16),

              // Timeout Seconds Field
              TextFormField(
                controller: _timeoutController,
                decoration: const InputDecoration(
                  labelText: 'Timeout (seconds) *',
                  hintText: '10',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Timeout is required';
                  }
                  final timeout = int.tryParse(value);
                  if (timeout == null || timeout <= 0 || timeout > 300) {
                    return 'Timeout must be between 1 and 300 seconds';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Check Interval Field
              TextFormField(
                controller: _checkIntervalController,
                decoration: const InputDecoration(
                  labelText: 'Check Interval (seconds) *',
                  hintText: '60',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Check interval is required';
                  }
                  final interval = int.tryParse(value);
                  if (interval == null || interval < 10 || interval > 3600) {
                    return 'Check interval must be between 10 and 3600 seconds';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Failure Threshold Field
              TextFormField(
                controller: _failureThresholdController,
                decoration: const InputDecoration(
                  labelText: 'Failure Threshold *',
                  hintText: '3',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Failure threshold is required';
                  }
                  final threshold = int.tryParse(value);
                  if (threshold == null || threshold <= 0 || threshold > 10) {
                    return 'Failure threshold must be between 1 and 10';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Enter service description',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading,
                maxLines: 2,
                textInputAction: TextInputAction.done,
              ),

              // Error Message
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),

        // Create Button
        ElevatedButton(
          onPressed: _isLoading ? null : _handleCreate,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}

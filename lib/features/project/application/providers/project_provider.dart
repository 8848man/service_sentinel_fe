import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/repository_providers.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/project.dart';
import '../use_cases/load_projects.dart';
import '../use_cases/create_project.dart';
import '../use_cases/update_project.dart';
import '../use_cases/delete_project.dart';

part 'project_provider.g.dart';

/// Provider for LoadProjects use case
@riverpod
LoadProjects loadProjects(LoadProjectsRef ref) {
  return LoadProjects(
    repository: ref.watch(projectRepositoryProvider),
  );
}

/// Provider for CreateProject use case
@riverpod
CreateProject createProject(CreateProjectRef ref) {
  return CreateProject(
    repository: ref.watch(projectRepositoryProvider),
  );
}

/// Provider for UpdateProject use case
@riverpod
UpdateProject updateProject(UpdateProjectRef ref) {
  return UpdateProject(
    repository: ref.watch(projectRepositoryProvider),
  );
}

/// Provider for DeleteProject use case
@riverpod
DeleteProject deleteProject(DeleteProjectRef ref) {
  return DeleteProject(
    repository: ref.watch(projectRepositoryProvider),
  );
}

/// Provider to fetch all projects
/// This provider auto-refreshes when dependencies change
@riverpod
Future<List<Project>> projects(ProjectsRef ref) async {
  final useCase = ref.watch(loadProjectsProvider);
  final result = await useCase.execute();

  if (result.isSuccess) {
    return result.dataOrNull!;
  } else {
    throw result.errorOrNull!;
  }
}

/// Provider to fetch active projects only
@riverpod
Future<List<Project>> activeProjects(ActiveProjectsRef ref) async {
  final useCase = ref.watch(loadProjectsProvider);
  final result = await useCase.executeFiltered(isActive: true);

  if (result.isSuccess) {
    return result.dataOrNull!;
  } else {
    throw result.errorOrNull!;
  }
}

/// Provider to fetch a project by ID
@riverpod
Future<Project> projectById(ProjectByIdRef ref, String projectId) async {
  final repository = ref.watch(projectRepositoryProvider);
  final result = await repository.getById(projectId);

  if (result.isSuccess) {
    return result.dataOrNull!;
  } else {
    throw result.errorOrNull!;
  }
}

/// Provider to fetch project statistics
@riverpod
Future<ProjectStats> projectStats(ProjectStatsRef ref, String projectId) async {
  final repository = ref.watch(projectRepositoryProvider);
  final result = await repository.getStats(projectId);

  if (result.isSuccess) {
    return result.dataOrNull!;
  } else {
    throw result.errorOrNull!;
  }
}

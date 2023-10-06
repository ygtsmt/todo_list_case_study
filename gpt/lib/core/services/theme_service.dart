import "package:gpt/core/data_sources/local_data_source/secure_data_storage.dart";
import "package:gpt/core/injection/injection.dart";
import "package:injectable/injectable.dart";

@injectable
class ThemeService {
  Future<void> setSavedThemeMode() async {
    final savedThemeMode = await getIt<SecureDataStorage>().getThemeMode();
    // getIt<AppBloc>().add(SetThemeEvent(savedThemeMode));
  }
}

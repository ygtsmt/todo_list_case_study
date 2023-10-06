import "package:get_it/get_it.dart";
import "package:gpt/core/injection/injection.config.dart";
import "package:injectable/injectable.dart";

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

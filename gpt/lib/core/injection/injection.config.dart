// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:gpt/core/routes/app_router.dart' as _i4;
import 'package:gpt/core/services/account_permission_service.dart' as _i3;
import 'package:gpt/core/services/bottom_sheet_service.dart' as _i5;
import 'package:gpt/core/services/image_picker_service.dart' as _i6;
import 'package:gpt/core/services/snackbar_service.dart' as _i8;
import 'package:gpt/core/services/theme_service.dart' as _i9;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AccountPermissionService>(
        () => _i3.AccountPermissionService());
    gh.factory<_i4.AppRouter>(() => _i4.AppRouter());
    gh.factory<_i4.AuctionGuard>(() => _i4.AuctionGuard());
    gh.lazySingleton<_i5.BottomSheetService>(() => _i5.BottomSheetService());
    gh.factory<_i6.ImagePickerService>(
        () => _i6.ImagePickerService(gh<_i7.ImagePicker>()));
    gh.factory<_i8.SnackBarService>(() => _i8.SnackBarService());
    gh.factory<_i9.ThemeService>(() => _i9.ThemeService());
    return this;
  }
}

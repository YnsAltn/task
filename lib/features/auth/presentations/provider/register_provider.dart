import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/features/auth/presentations/model/register_model.dart';
import 'package:task/features/auth/presentations/model/register_response_model.dart';
import 'package:task/features/auth/presentations/service/register_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part '../states/register_state.dart';

final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);

class RegisterNotifier extends Notifier<RegisterState> {
  final RegisterService _registerService = RegisterService();

  @override
  RegisterState build() {
    return const RegisterState();
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<RegisterResponseModel?> registerUser(context) async {
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(
        errorMessage: AppLocalizations.of(context)!.pleaseFillCorrectly,
      );
      return null;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final model = RegisterModel(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      final response = await _registerService.registerUser(model);
      state = state.copyWith(isSubmitting: false);
      return response;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: "${AppLocalizations.of(context)!.anErrorOccurred}: $e",
      );
      return null;
    }
  }
}

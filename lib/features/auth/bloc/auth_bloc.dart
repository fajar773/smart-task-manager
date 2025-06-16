import 'package:bloc/bloc.dart';
import 'package:smart_task_manager/features/auth/bloc/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_task_manager/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final user = _auth.currentUser;
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated(result.user!.uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<LoggedOut>((event, emit) async {
      await _auth.signOut();
      emit(Unauthenticated());
    });
  }
}

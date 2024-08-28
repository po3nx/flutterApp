import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/repository/user_repository.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final User user;

  LoginEvent(this.user);

  @override
  List<Object?> get props => [user];
}
class LogoutEvent extends AuthEvent {
  LogoutEvent();

}

class RegisterEvent extends AuthEvent {
  final User user;

  RegisterEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthState extends Equatable {
  final String? token;

  const AuthState({required this.token});

  @override
  List<Object?> get props => [token];
}
class AuthLoading extends AuthState {
  const AuthLoading({required super.token});
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required super.token});
}

class AuthFailure extends AuthState {
  final String error;
  const AuthFailure({required this.error}) : super(token: '');
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(const AuthState(token: null));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield const AuthLoading(token: '');
      try {
        final token = await userRepository.login(event.user);
        if (token != null){
           yield AuthState(token: token);
           yield AuthSuccess(token: token);
        }else{
          yield const AuthFailure(error: 'Invalid credentials');
        }
       
      } catch (e) {
        yield const AuthState(token: null);
        yield AuthFailure(error: e.toString());
      }
    }else if (event is RegisterEvent) {
      try {
        await userRepository.register(event.user);
        yield const AuthState(token: null);
      } catch (e) {
        yield const AuthState(token: null);
      }
    } else if (event is LogoutEvent) {
      try {
        yield const AuthState(token: null);
      } catch (e) {
        yield const AuthState(token: null);
      }
    }
  }
}
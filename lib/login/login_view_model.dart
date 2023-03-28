import 'dart:async';

import 'package:flutter_mvvm_demo_1/helpers/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _buttonSubject = BehaviorSubject<bool>();

  var emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String error = Validation.validateEmail(data) != null
          ? Validation.validateEmail(data)!
          : '';
      sink.add(error);
    },
  );

  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String error = Validation.validatePassword(data) != null
          ? Validation.validatePassword(data)!
          : '';
      sink.add(error);
    },
  );

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation).skip(1);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(passwordValidation).skip(1);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get buttonStream => _buttonSubject.stream;
  Sink<bool> get buttonSink => _buttonSubject.sink;

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _buttonSubject.close();
  }

  LoginViewModel() {
    Rx.combineLatest2(_emailSubject, _passwordSubject, (email, password) {
      return Validation.validateEmail(email) == null &&
          Validation.validatePassword(password) == null;
    }).listen((event) {
      buttonSink.add(event);
    });
  }
}

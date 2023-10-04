// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(_current != null,
        'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(instance != null,
        'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?');
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
        context, GeneratedLocalization);
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Theme App`
  String get themeApp {
    return Intl.message(
      'Theme App',
      name: 'themeApp',
      desc: '',
      args: [],
    );
  }

  /// `Language APP`
  String get languageApp {
    return Intl.message(
      'Language APP',
      name: 'languageApp',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to back Your NOTE...`
  String get signInTitle {
    return Intl.message(
      'Welcome to back Your NOTE...',
      name: 'signInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your NOTE is here...`
  String get signUpTitle {
    return Intl.message(
      'Your NOTE is here...',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter email address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add Password`
  String get addPassword {
    return Intl.message(
      'Add Password',
      name: 'addPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Open Gallery`
  String get openGallery {
    return Intl.message(
      'Open Gallery',
      name: 'openGallery',
      desc: '',
      args: [],
    );
  }

  /// `Open Camera`
  String get openCamera {
    return Intl.message(
      'Open Camera',
      name: 'openCamera',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get addPhoto {
    return Intl.message(
      'Add Photo',
      name: 'addPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Secret note Password`
  String get secretPassword {
    return Intl.message(
      'Secret note Password',
      name: 'secretPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get profileImage {
    return Intl.message(
      'Profile Image',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `New Note`
  String get newNote {
    return Intl.message(
      'New Note',
      name: 'newNote',
      desc: '',
      args: [],
    );
  }

  /// `Update your secret\nNotes password`
  String get updateSecretPass {
    return Intl.message(
      'Update your secret\nNotes password',
      name: 'updateSecretPass',
      desc: '',
      args: [],
    );
  }

  /// `Create your secret\nNotes password`
  String get newSecretPass {
    return Intl.message(
      'Create your secret\nNotes password',
      name: 'newSecretPass',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set new password`
  String get setPassword2 {
    return Intl.message(
      'Set new password',
      name: 'setPassword2',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short, it must be at least 8 characters`
  String get passwordLength {
    return Intl.message(
      'Password is too short, it must be at least 8 characters',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Password shouldn't have space`
  String get passwordSpace {
    return Intl.message(
      'Password shouldn\'t have space',
      name: 'passwordSpace',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least one number`
  String get passwordNumber {
    return Intl.message(
      'Password must have at least one number',
      name: 'passwordNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least one letter`
  String get passwordLetter {
    return Intl.message(
      'Password must have at least one letter',
      name: 'passwordLetter',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least one Capital letter`
  String get passwordCapitalLetter {
    return Intl.message(
      'Password must have at least one Capital letter',
      name: 'passwordCapitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address!`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address!',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `You are already Registered`
  String get alreadyRegister {
    return Intl.message(
      'You are already Registered',
      name: 'alreadyRegister',
      desc: '',
      args: [],
    );
  }

  /// `Invalid name!`
  String get invalidName {
    return Intl.message(
      'Invalid name!',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `You don't have Account`
  String get doNotHave {
    return Intl.message(
      'You don\'t have Account',
      name: 'doNotHave',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with `
  String get signInWith {
    return Intl.message(
      'Sign in with ',
      name: 'signInWith',
      desc: '',
      args: [],
    );
  }

  /// `Text with link`
  String get textWithLink {
    return Intl.message(
      'Text with link',
      name: 'textWithLink',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Link`
  String get addLink {
    return Intl.message(
      'Add Link',
      name: 'addLink',
      desc: '',
      args: [],
    );
  }

  /// `User didn't take any picture.`
  String get didNotPicture {
    return Intl.message(
      'User didn\'t take any picture.',
      name: 'didNotPicture',
      desc: '',
      args: [],
    );
  }

  /// `User didn't take any image.`
  String get didNotImage {
    return Intl.message(
      'User didn\'t take any image.',
      name: 'didNotImage',
      desc: '',
      args: [],
    );
  }

  /// `Enter title of note...`
  String get enterTitle {
    return Intl.message(
      'Enter title of note...',
      name: 'enterTitle',
      desc: '',
      args: [],
    );
  }

  /// `This is where your note will be. It’ll be housed here. You’ll save your note here. Type your memories here. Write down your thoughts.`
  String get bodyText {
    return Intl.message(
      'This is where your note will be. It’ll be housed here. You’ll save your note here. Type your memories here. Write down your thoughts.',
      name: 'bodyText',
      desc: '',
      args: [],
    );
  }

  /// `Please check the password again`
  String get checkPasswordAgain {
    return Intl.message(
      'Please check the password again',
      name: 'checkPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Your email address`
  String get yourEmailAddress {
    return Intl.message(
      'Your email address',
      name: 'yourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter again`
  String get enterAgain {
    return Intl.message(
      'Enter again',
      name: 'enterAgain',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message(
      'Send code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `You entered the password incorrectly`
  String get incorrectlyPassword {
    return Intl.message(
      'You entered the password incorrectly',
      name: 'incorrectlyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get couldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'couldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy note taking with friends`
  String get enjoyNote {
    return Intl.message(
      'Enjoy note taking with friends',
      name: 'enjoyNote',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Change Your name`
  String get changeYourName {
    return Intl.message(
      'Change Your name',
      name: 'changeYourName',
      desc: '',
      args: [],
    );
  }

  /// `Your old password`
  String get oldPassword {
    return Intl.message(
      'Your old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields.`
  String get snackBar {
    return Intl.message(
      'Please fill all fields.',
      name: 'snackBar',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password. Please try again.`
  String get snackBar2 {
    return Intl.message(
      'Incorrect password. Please try again.',
      name: 'snackBar2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a 4-digit new password.`
  String get snackBar3 {
    return Intl.message(
      'Please enter a 4-digit new password.',
      name: 'snackBar3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

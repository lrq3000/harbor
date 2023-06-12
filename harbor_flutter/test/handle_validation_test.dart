import 'package:test/test.dart';

import 'package:harbor_flutter/handle_validation.dart' as handle_validation;

void main() {
  group("twitter", () {
    test('too short', () {
      expect(handle_validation.isHandleValid("Twitter", "aaa"), false);
    });
    test('too long', () {
      expect(
          handle_validation.isHandleValid(
              "Twitter", List.filled(16, "a").join()),
          false);
    });
    test('invalid character', () {
      expect(handle_validation.isHandleValid("Twitter", "test:blah"), false);
    });
    test('valid', () {
      expect(handle_validation.isHandleValid("Twitter", "a1_Z3"), true);
    });
  });

  group("discord", () {
    test('username too short', () {
      expect(handle_validation.isHandleValid("Discord", "a#1234"), false);
    });
    test('username too long', () {
      expect(
        handle_validation.isHandleValid(
          "Discord",
          '${List.filled(34, "a").join()}#5321',
        ),
        false,
      );
    });
    test('reserved', () {
      expect(
          handle_validation.isHandleValid("Discord", "everyone#4123"), false);
      expect(handle_validation.isHandleValid("Discord", "here#4123"), false);
      expect(
          handle_validation.isHandleValid("Discord", "abcdiscord#4123"), false);
    });
    test('invalid tag', () {
      expect(handle_validation.isHandleValid("Discord", "aoeuo#12335"), false);
      expect(handle_validation.isHandleValid("Discord", "aoeea#hello"), false);
      expect(handle_validation.isHandleValid("Discord", "aoeoae"), false);
    });
    test('valid', () {
      expect(handle_validation.isHandleValid("Discord", "abc#5522"), true);
    });
  });
}

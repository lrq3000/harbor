import 'package:test/test.dart';

import 'package:harbor_flutter/models.dart' as models;
import 'package:harbor_flutter/handle_validation.dart' as handle_validation;

void main() {
  group("twitter", () {
    test('too short', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeTwitter, "aaa"),
          false);
    });
    test('too long', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeTwitter, List.filled(16, "a").join()),
          false);
    });
    test('invalid character', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeTwitter, "test:blah"),
          false);
    });
    test('valid', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeTwitter, "a1_Z3"),
          true);
    });
  });

  group("discord", () {
    test('username too short', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "a#1234"),
          false);
    });
    test('username too long', () {
      expect(
        handle_validation.isHandleValid(
          models.ClaimType.claimTypeDiscord,
          '${List.filled(34, "a").join()}#5321',
        ),
        false,
      );
    });
    test('reserved', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "everyone#4123"),
          false);
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "here#4123"),
          false);
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "abcdiscord#4123"),
          false);
    });
    test('invalid tag', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "aoeuo#12335"),
          false);
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "aoeea#hello"),
          false);
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "aoeoae"),
          false);
    });
    test('valid', () {
      expect(
          handle_validation.isHandleValid(
              models.ClaimType.claimTypeDiscord, "abc#5522"),
          true);
    });
  });
}

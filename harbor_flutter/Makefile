.PHONY: run clean build-apk test lint format icons proto splash

run:
	flutter run

clean:
	flutter clean

build-apk:
	flutter build apk --debug

test:
	flutter test

lint:
	flutter analyze \
		lib/main.dart \
		lib/ranges.dart \
		lib/queries.dart \
		lib/synchronizer.dart \
		lib/pages/* \
		lib/api_methods.dart \
		lib/shared_ui.dart \
		lib/handle_validation.dart \
		test/*

format:
	dart format --set-exit-if-changed \
		lib/main.dart \
		lib/queries.dart \
		lib/ranges.dart \
		lib/synchronizer.dart \
		lib/pages/* \
		lib/api_methods.dart \
		lib/shared_ui.dart \
		lib/handle_validation.dart \
		test/*

icons:
	dart run flutter_launcher_icons

splash:
	dart run flutter_native_splash:create

proto:
	protoc \
		--proto_path=../../polycentric/proto \
		--dart_out=./lib \
		--experimental_allow_proto3_optional \
		../../polycentric/proto/protocol.proto

.PHONY: run clean build-apk test lint format icons proto

run:
	flutter run

clean:
	flutter clean

build-apk:
	flutter build apk

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
		test/*

format:
	dart format --set-exit-if-changed \
		lib/main.dart \
		lib/queries.dart \
		lib/ranges.dart \
		lib/synchronizer.dart \
		lib/pages/* \
		lib/api_methods.dart \
		test/*

icons:
	flutter pub run flutter_launcher_icons:main

proto:
	protoc \
		--proto_path=../../polycentric/proto \
		--dart_out=./lib \
		--experimental_allow_proto3_optional \
		../../polycentric/proto/protocol.proto

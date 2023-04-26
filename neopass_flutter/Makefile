run:
	flutter run

clean:
	flutter clean

build-apk:
	flutter build apk

lint:
	flutter analyze \
		lib/main.dart \
		lib/ranges.dart \
		lib/pages/* \
		lib/api_methods.dart \
		test/*

format:
	dart format \
		lib/main.dart \
		lib/ranges.dart \
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

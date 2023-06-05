VERSION=$(git rev-parse HEAD)

echo $VERSION

cat <<EOT > neopass_flutter/lib/version.dart
final version = "${VERSION}";
EOT



VERSION=$(git rev-parse HEAD)

echo $VERSION

cat <<EOT > harbor_flutter/lib/version.dart
final version = "${VERSION}";
EOT



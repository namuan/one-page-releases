echo "Upload Release on Github"

VERSION="$1"

mv dist/OnePage.app.zip dist/onepage-macos-${VERSION}.zip
github-release upload --owner ${OWNER} --repo one-page-releases --tag "${VERSION}" --name "${VERSION}" --body "OnePage Release ${VERSION}" --prerelease=false dist/onepage-macos-${VERSION}.zip
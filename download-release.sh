echo "###### Downloading released file ###############"

RELEASE_VERSION="$1"
ZIP_FILE=onepage-macos-${RELEASE_VERSION}.zip

rm -rf dist
mkdir -vp dist
wget https://github.com/namuan/one-page-releases/releases/download/${RELEASE_VERSION}/${ZIP_FILE} -O ./dist/${ZIP_FILE}
cd dist
unzip ${ZIP_FILE}
rm -rf ${ZIP_FILE}
cd ..

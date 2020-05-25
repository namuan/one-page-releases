echo "###### Uploading file to notarize ###############"

USER="$1"
KEYCHAIN="$2"

cd dist
echo "-> Making a copy"
ditto -c -k --keepParent OnePage.app OnePage.app.zip
echo "-> Uploading file"
xcrun altool --notarize-app --primary-bundle-id dev.deskriders.onepage --password "@keychain:${KEYCHAIN}" --file OnePage.app.zip
echo "-> Checking status"
xcrun altool --notarization-history 0 -u ${USER} -p "@keychain:${KEYCHAIN}"

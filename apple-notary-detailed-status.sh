echo "###### Checking details status ###############"

USER="$1"
KEYCHAIN="$2"
REQUEST_ID="$3"

xcrun altool --notarization-info ${REQUEST_ID} -u ${USER} -p "@keychain:${KEYCHAIN}"
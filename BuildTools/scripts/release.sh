SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
. "${SCRIPT_DIR}/common.sh"

function update_git_repo () {
	git checkout "Duplicati/License/VersionTag.txt"
	git checkout "Duplicati/Library/AutoUpdater/AutoUpdateURL.txt"
	git checkout "Duplicati/Library/AutoUpdater/AutoUpdateBuildChannel.txt"
	git add "Updates/build_version.txt"
	git add "${RELEASE_CHANGELOG_FILE}"
	git commit -m "Version bump to v${RELEASE_VERSION}-${RELEASE_NAME}" -m "You can download this build from: " -m "Binaries: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip" -m "Signature file: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip.sig" -m "ASCII signature file: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip.sig.asc" -m "MD5: ${ZIP_MD5}" -m "SHA1: ${ZIP_SHA1}" -m "SHA256: ${ZIP_SHA256}"
	git tag "v${RELEASE_VERSION}-${RELEASE_NAME}"                       -m "You can download this build from: " -m "Binaries: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip" -m "Signature file: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip.sig" -m "ASCII signature file: https://updates.duplicati.com/${RELEASE_TYPE}/${RELEASE_FILE_NAME}.zip.sig.asc" -m "MD5: ${ZIP_MD5}" -m "SHA1: ${ZIP_SHA1}" -m "SHA256: ${ZIP_SHA256}"
	git push --tags
}


echo
echo "3. Deploying"
bash "deploy.sh" #--target-dir "${UPDATE_TARGET}/Installers" "${UPDATE_TARGET}/${RELEASE_FILE_NAME}.zip"

echo
echo "4. Updating git"
increase_release_number
update_git_repo
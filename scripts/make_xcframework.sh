#!/bin/sh

CURRENT_DIR=$(pwd)
PROJECT_NAME="AppMetrica"
iOS_SCHEME_NAMES=("AppMetricaCore" "AppMetricaCrashes")

# ---------------
# Make archives folder
# ---------------

BUILDED_ARCHIVES_iOS_FOLDER_PATH="${CURRENT_DIR}/Build/Archives/iOS"

echo "Will delete \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"
rm -rf "${BUILDED_ARCHIVES_iOS_FOLDER_PATH}"
echo "Did delete \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder\n"

echo "Will make \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder"
mkdir -p "${BUILDED_ARCHIVES_iOS_FOLDER_PATH}"
echo "Did make \"${BUILDED_ARCHIVES_iOS_FOLDER_PATH}\" folder\n"

CURRENT_DIR_PERMISSIONS=$(stat -f "%A" "${CURRENT_DIR}")

if [ "${CURRENT_DIR_PERMISSIONS}" != "755" ]; then
    echo "Will change permissions of \"${CURRENT_DIR}\" to 755"
    chmod -R 755 "${CURRENT_DIR}"
    echo "Did change permissions of \"${CURRENT_DIR}\" to 755\n"
fi

# -------------------------------
# Make XCFramework folder
# -------------------------------

CREATED_XCFRAMEWORK_FOLDER_PATH="${CURRENT_DIR}/Build/XCFramework"

echo "Will delete \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"
rm -rf "${CREATED_XCFRAMEWORK_FOLDER_PATH}"
echo "Did delete \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder\n"

echo "Will make \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder"
mkdir -p "${CREATED_XCFRAMEWORK_FOLDER_PATH}"
echo "Did make \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" folder\n"

CREATED_XCFRAMEWORK_FOLDER_PATH_DIR_PERMISSIONS=$(stat -f "%A" "${CREATED_XCFRAMEWORK_FOLDER_PATH}")

if [ "${CREATED_XCFRAMEWORK_FOLDER_PATH_DIR_PERMISSIONS}" != "755" ]; then
	echo "Will change permissions of \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" to 755"
	chmod -R 755 "${CREATED_XCFRAMEWORK_FOLDER_PATH}"
	echo "Did change permissions of \"${CREATED_XCFRAMEWORK_FOLDER_PATH}\" to 755\n"
fi




for iOS_SCHEME_NAME in "${iOS_SCHEME_NAMES[@]}"; do
	# ---------------------------
	# Make archive for iOS device
	# ---------------------------

	iOS_DEVICE_ARCHIVE_PATH="${BUILDED_ARCHIVES_iOS_FOLDER_PATH}/${iOS_SCHEME_NAME}-iOS-device.xcarchive"
#	echo "iOS_DEVICE_ARCHIVE_PATH = \"${iOS_DEVICE_ARCHIVE_PATH}\""


#	cd "${CURRENT_DIR}/../"

#	echo "Will make archive for iOS device at \"${iOS_DEVICE_ARCHIVE_PATH}\""
#	xcodebuild archive \
#		-quiet \
#		-scheme "${iOS_SCHEME_NAME}" \
#		-archivePath "${iOS_DEVICE_ARCHIVE_PATH}" \
#		-sdk iphoneos \
#		-destination generic/platform=iOS \
#		SKIP_INSTALL=NO \
#		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
#	echo "Did make archive for iOS device at \"${iOS_DEVICE_ARCHIVE_PATH}\"\n"




	# ------------------------------
	# Make archive for iOS simulator
	# ------------------------------

	iOS_SIMULATOR_ARCHIVE_PATH="${BUILDED_ARCHIVES_iOS_FOLDER_PATH}/${iOS_SCHEME_NAME}-iOS-simulator.xcarchive"
#	echo "iOS_SIMULATOR_ARCHIVE_PATH = \"${iOS_SIMULATOR_ARCHIVE_PATH}\""

	echo "Will make archive for iOS simulator at \"${iOS_SIMULATOR_ARCHIVE_PATH}\""
	xcodebuild archive \
		-quiet \
		-scheme "${iOS_SCHEME_NAME}" \
		-archivePath "${iOS_SIMULATOR_ARCHIVE_PATH}" \
		-destination "generic/platform=iOS Simulator" \
		-sdk iphonesimulator \
		SKIP_INSTALL=NO \
		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
	echo "Did make archive for iOS simulator at \"${iOS_SIMULATOR_ARCHIVE_PATH}\"\n"

	# -----------------
	# Make xcframeworks
	# -----------------

	FRAMEWORK_NAME=$iOS_SCHEME_NAME

	iOS_DEVICE_FRAMEWORK="${iOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework"
#	echo "iOS_DEVICE_FRAMEWORK = \"${iOS_DEVICE_FRAMEWORK}\""

	iOS_SIMULATOR_FRAMEWORK="${iOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework"
#	echo "iOS_SIMULATOR_FRAMEWORK = \"${iOS_SIMULATOR_FRAMEWORK}\""

	XCFRAMEWORK_PATH="${CREATED_XCFRAMEWORK_FOLDER_PATH}/${iOS_SCHEME_NAME}.xcframework"
#	echo "XCFRAMEWORK_PATH = \"${XCFRAMEWORK_PATH}\""

	echo "Will create XCFramework at \"${XCFRAMEWORK_PATH}\""
	xcodebuild -create-xcframework \
		-framework "${iOS_DEVICE_FRAMEWORK}" \
		-framework "${iOS_SIMULATOR_FRAMEWORK}" \
		-output "${XCFRAMEWORK_PATH}"
	echo "Did create XCFramework at \"${XCFRAMEWORK_PATH}\"\n"
done

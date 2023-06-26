# Get Version from Pubspec
version=$(LC_ALL=en_US.utf8 grep -P "version: (.+)" ../pubspec.yaml -o | awk -F ':' '{print $2}' | xargs)

# Get the description from Pubspec
description=$(LC_ALL=en_US.utf8 grep -P "description: (.+)" ../pubspec.yaml -o | awk -F ':' '{print $2}' | xargs)

echo "Version: $version"
echo "Description: $description"

git tag -a $version -m "$description Release von $version" --force

git push origin --tags --force

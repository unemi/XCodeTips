#! /bin/csh
#
# Count the Bundle Version in info.plist, which is shown as "Build" number of the app.
# Add the absolute path of this file in the "Run Script" row in
# "Build Phases" tab of your TARGET. You can add a new "Run Script" row
# by clicking "+" at the top left.
# It's not necessary but recommended to be placed blow the "Link Binary ..." row.
# Then the "Build" number increases by one every build-operation.
#
if (! $?PRODUCT_SETTINGS_PATH || ! $?CONFIGURATION) exit
if ("$CONFIGURATION" != Release) exit
awk '/CFBundleVersion/ {a = NR}\
/string/ && NR == a+1 {split($0,b,">");split(b[2],c,"<");\
$0 = "\t<string>" c[1]+1 "</string>"}\
{print}' "$PRODUCT_SETTINGS_PATH" > z$$ && mv z$$ "$PRODUCT_SETTINGS_PATH"

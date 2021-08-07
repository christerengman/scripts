# Archives files from $0 to $1/%Y/%Y-%M leaving $2 GB behind
# Use case is to archive media files synced from mobile device leaving only the most recent media.

SRC=${1:-.}
DST=${2:-.}
LIMIT=${3:-1}

echo "Source: ${SRC}"
echo "Dest  : ${DST}"
echo "Leave : ${LIMIT} GB"

ls -tsdb "${SRC}"**/* |
    awk "{ sum += \$1; if (sum > ${LIMIT} * 1024 * 1024) { \$1 = \"\"; print }}" |
        xargs exiftool "-Filename<FileModifyDate" "-Filename<MediaCreateDate" "-Filename<DateTimeOriginal" -d "${2}/%Y/%Y-%m/%%f%%-c.%%e"
#!/bin/bash

# Get the parameters/args
src="$1";
dest="$2";

# Get the path of this script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set path variables
list_path="$script_dir"/migrate_home_paths_list;
log_path="$script_dir"/migrate_home-$(date -I'seconds').log;

# The message that gets displayed as help
help_message="Usage: migrate_home.sh SOURCE DEST

Copy from SOURCE to DEST all the files and directories (including all contained subdirectories and files) mentioned in the file \$script_dir/migrate_home_paths
Lines in that file will be skipped if the line begins with a hash #.

Arguments:
        --help  display this help and exit

A logfile will be created at \$script_dir/migrate_home.log.
This script will overwrite any matching files and folders in the DEST directory.
It will fail on an individual file if it exists at DEST and is of a different type (normal file or directory) than the one in SOURCE.

Known assumptions:
    - That SOURCE, DEST and migrate_home_paths exist."

# Display help if not exactly 2 args or if 1 arg is --help
if [ $# -eq 1 ] && [ $1 == "--help" ] || [ $# -ne 2 ]; then
    echo "$help_message"
    exit 1
fi


main()  {
    # If we cant change dir, then exit
    cd "$src" || exit 1
    while read -r; do
        # Skip line if it begins with a hash.
        [[ "$REPLY" =~ ^# ]] && echo mig: skipping "$REPLY" && continue
        # Skip line if $REPLY is missing in $src
        [[ ! -e "$REPLY" ]] && echo mig: SOURCE missing for "$src"/"$REPLY" && continue
        # If everything is fine
        echo mig: attempting rync: "$REPLY">> log_file 2>&1
        rsync -avHAXEc --progress "$REPLY" "$dest" 2>&1 && echo mig: success rsync: "$REPLY" || echo mig: failure rsync: "$REPLY"
    done < "$list_path"

}

# Outputting stdout and stderr to logfile
main 2>&1 | tee "$log_path"

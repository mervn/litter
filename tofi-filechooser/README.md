
# tofi-filechooser

## Notes

./tofi-filechooser.sh
send notification to user when selected file does not match expected type

* `echo -n` is implementation defined and therefore may cause issues
* Can not write to non-exsistent file that matches substring of an existing file
* Silent errors may occur due to `/bin/sh -e`. keep this in mind when debugging
* Use of 'num-results' may result in filenames being truncated in tofi visual

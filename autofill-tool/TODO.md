# TO DO

This file contains concepts, planned features, and relevant notes.
It can be seen as a roadmap.

The target file will be addressed in the sub-heading;
with significant sections addressed in further sub-headings.

## Makefile

- add chmod(1) and chown(1) to "INSTALL" for permission changes.

### build

- substitute @@PROGRAM\_NAME@@ with NAME, and @@PROGRAM\_VERSION@@ with VERSION.

    Use sed(1) to add in the intended values.

### uninstall

- add this target

    The $(bins) variable is used and contains multi-level path names. This means
    that `rm -f` alone cannot be used to remove installed files from the system.

    Using a for-loop to process $(bins) is extremely inefficient. Find if there
    is an efficient POSIX method to handle this. If not, use the for-loop.

## README.md

- add a section that redirects user to manual for miscellaneous data

    This includes examples, exit-status, and option descriptions.

### Status

- remove this section

    It is redundant, as it should be present in the manual.

### Usage

- add quote: "In some entries, attribute.user may contain the username."

- include example of -E .

- include example of clipboard support (if added) and '!' support (if added).

- include example with `url2attr` (if added).

## docs/autofill-tool.1

- add nroff manual page

    This should contain defined options, examples, experimental features, and
    other common manual sections (i.e BUGS, EXIT STATUS, STANDARDS, STDIN, etc).

    Installation should be able to fail, as some systems do not have man(1).

## src/autofill-tool.sh

- add internal redirection support.

    Outside of configuration files, output will very likely require a custom
    script to be useful. Provide baseline functionality to ease (or offload)
    much of the required work.

    There should be a convenience option that redirects to a clipboard program.

    There should be a convenience option that notifies when next entry is to be
    processed.

    There should be a convenience option that waits N-seconds before processing
    next entry (with a default of 0 ; default 10 if clipboard). 0 will cause all
    data to be sent immediately.

### awk script

#### END

- add support for attribute name containing separator.

    This is may require an upstream patch, as separator is semantic.

- return "value name" instead of "value".

    The "name" can be used for error-checking. If "name" is not null, and
    "value" is empty, this is not an error. If "name" is null, this is an error.

### search()

- exit(1) non-zero on failure.

    The caller can (and should) handle this , but it will complicate
    the pipe logic - which this script heavily depends on.
         
    If an error is caused by this function, usage() and version()
    must also cause errors, for consistency.

### usage()

- add mode and option descriptions

## src/img2attr.sh

- add script which extracts attribute info from an image (i.e screenshot).

    Using Optical Character Recognition (OCR), scan the image for text and
    map common labels to attributes. Fields that are empty will be requested;
    Fields that are filled will be used as lookup-attributes.

    For example, if a screenshot is taken of "codeberg.org/user/login". This
    script should return "-o username,secret,otp issuer codeberg.org" after
    processing.

    Mapping will probably have to be tuned (or trained); and also have an option
    for a user-defined mapping data.

## src/url2attr.sh

- add script which extracts attribute info from a url.

    This will map the base-domain (i.e codeberg.org) to issuer attribute.

    There should be an option to change the default attribute name.

    There should be an option to extract parameters (i.e ?q=hello).

    There should be an option to extract the Nth subdomain (i.e n.codeberg.org).

## .git/

- add hook that requests a new version each time a commit to src/* is made.

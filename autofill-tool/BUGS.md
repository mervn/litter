# BUGS

This file contains known bugs and issues.

## src/autofill-tool.sh

- remove '-e' from /bin/sh

    Do not throw errors without descriptive diagnostic. Otherwise, debugging
    becomes significantly more challenging.

### awk script

#### END

- Searching for unknown attribute with '-E' does not result in a failed state

    This is a branching error. 'shell is true', meaning something within it's
    block must handle 'value is false' - due to if/elif/else. However no such
    handle exists, leading to a failed case (unknown attribute) not resulting
    a failed state.

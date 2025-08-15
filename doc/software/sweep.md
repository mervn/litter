### sweep

A driver program that uses curl(1) for browser navigation. Here is the flow:

1. Fetch HTML (via curl)
2. Render HTML without loading remote content
3. When click on remote-content, use user-defined command and refresh
4. When click on link, use user-defined command and repeat from step1

The program should be portable (POSIX C or Shell) and use commonly installed
libraries/programs.


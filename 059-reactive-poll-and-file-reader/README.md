There are three main parts of the server code:

1. The first sets up an observer which writes to a log file once every second. This is just to make the example work; typically some external process will be writing to a file.

1. The second part uses a `reactiveFileReader` to monitor the log file for changes every 0.5 seconds.

1. The third part uses a `reactivePoll` to monitor the log file for changes every 4 seconds. The `reactivePoll` is general, and it will watch for things other than file changes. It could, for example, query a database.

The `session$clientdata` object provides the server with some information about the client.

If the client is visiting a URL with a query string or hash (such as http://localhost:8100/?a=xxx&b=yyy#zzz), there will be values for `url_search` and `url_hash_initial`. This app will also display the parsed query string.

This app in the Shiny gallery is displayed without a query string. To see the query string, follow [this link](https://gallery.shinyapps.io/032-client-data-and-query-string/?a=xxx&b=yyy#zzz).

#RSS_READER
##Introduction
This program is Simple RSS Reader Web application.

##how to use in local

```
$ cd /tmp
$ git clone https://github.com/daguniko/rss_reader.git
$ cd rss_reader
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake fetch_feed
$ rake cal_tfidf
$ rails server
```
and type "localhost:3000"in browser for access this application.

##Q&A

###Q.error occcured while installing pg(0.15.1)

###A.You have to execute follow command.


```
$ ARCHFLAGS="-arch x86_64" bundle install
```

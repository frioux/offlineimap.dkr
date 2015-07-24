# OfflineIMAP Container

## Usage

       docker run -d --name offlineimap          \
          -v             ~/.netrc:/opt/etc/netrc \
          -v           ~/var/mail:/opt/var/mail  \
          -v   ~/.offlineimap/log:/opt/log       \
          -v ~/.offlineimap/index:/opt/var/index \
          --env EMAIL=frioux@gmail.com           \
          --restart=always frew/offlineimap

## Description

If you care about having all your email at your fingertips,
[`offlineimap`](http://offlineimap.org/) is an excellent tool to acheive that
lofty goal.  Unfortunately, `offlineimap` tends to be a little bit buggy.  This
container helps to keep `offlineimap` running.  There are two main functions
with a few smaller bits and bobs.

 1. [Restart OfflineIMAP after it leaks to 1 GB](https://github.com/frioux/offlineimap/blob/master/monitrc) - achieved with [monit](http://mmonit.com/monit/)
 2. [Restart OfflineIMAP after it
    hangs](https://github.com/frioux/offlineimap/blob/master/bin/cerberus#L30) - achieved with ~20 lines of Perl

## Beware

Before going much further I have to say: I have done nothing to make this
project work for anyone other than me.  It can definitely be done, and the most
important parts are already generic, but realize that this is very much a work
in progress and was not made to serve the general public.

## Volumes

There are two absolutely required volumes and two more recommended volumes you
should set up to use this:

 1. _/opt/etc/netrc_ - this is the file containing your username and password. **required**
    It should look like this:

        machine imap.gmail.com
        login frioux@gmail.com
        password foobar

 2. _/opt/var/mail_ - this is where the mail gets downloaded to. **required**

 3. _/opt/var/index_ - this is directory where `offlineimap` stores its
    metadata.  If you don't make this volume offlineimap will have to reindex
    all  your mail every time you start the container afresh. **highly recommended**

 4. _/opt/log_ - this is the directory where logs for `offlineimap`, `monit`, and `cerberus` go.

## Ports

There's just one port:

 * 2812 - this is the web interface for `monit`.  Currently it's hard coded to
   username: `frew`, password: `test`.  At some point I'll make this based on an
   env var.

## Notes on running on Ubuntu

If you care about the memory leak thing (it only happens on one of the three
machines I use, so you might not) you need to enable `ptrace` for `docker`.  On
my system, ubuntu 14.10, I had to enable `ptrace` by adding `ptrace,` to the
first list of options in _/etc/apparmor.d/docker_.

## Ideas for the future

[Documented on github issues](https://github.com/frioux/offlineimap/issues)

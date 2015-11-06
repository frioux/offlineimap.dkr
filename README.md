# OfflineIMAP Container

## Usage

       docker run -d --name offlineimap          \
          -v             ~/.netrc:/opt/etc/netrc \
          -v           ~/var/mail:/opt/var/mail  \
          -v ~/.offlineimap/index:/opt/var/index \
          --env EMAIL=frioux@gmail.com           \
          --restart=always frew/offlineimap

## Description

If you care about having all your email at your fingertips,
[`offlineimap`](http://offlineimap.org/) is an excellent tool to acheive that
lofty goal.

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

## Environment Variables

There is one required environment variable:

 1. `EMAIL` - this is the email address you want to be syncing.

## Ideas for the future

[Documented on github issues](https://github.com/frioux/offlineimap/issues)

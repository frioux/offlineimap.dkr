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
lofty goal. Unfortunately, `offlineimap` tends to be a little bit buggy.  This
container helps to keep `offlineimap` running.  Currently it [restarts
OfflineIMAP after it
hangs](https://github.com/frioux/offlineimap/blob/master/bin/cerberus#L19) with
~30 lines of Python.

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

 4. _/opt/var/log_ - this is where the logs are kept.  You can mount this if you
    want, but I set up a `tail` to docker's built in logs.

## Environment Variables

There is one required environment variable:

 1. `EMAIL` - this is the email address you want to be syncing.

## Ideas for the future

[Documented on github issues](https://github.com/frioux/offlineimap/issues)

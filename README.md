Mozilla-Fennec-Dev-Env-Setup
============================

A set of scripts to automate the Fennec setup process.

# Install

``
wget https://github.com/DouglasSherk/Mozilla-Fennec-Dev-Env-Setup/raw/master/bootstrap.sh -O - | sh
``

# Requirements

1) Must be running Ubuntu 12.04, 64-bit. Ideally it should be a fresh install.
2) Must have already rooted phone.
3) Phone must be plugged in.

# What it does

This will do everything you need to start working on Fennec. The first steps take a
very very long time, so please be patient. Depending on your computer and whether or
not you're using a VM, this could literally take an entire day.

This script is only designed to run a completely fresh install of Ubuntu. It
will install ALL prerequisites. It will probably work on an already heavily
used OS depending on how customized it is.

A copy of mozilla-central will be cloned into ~/mozilla-central-mobile/ and be
mostly configured for you.

IMPORTANT: You must have already rooted your device, and it must be plugged in
when you move onto the next step. No other setup is required.

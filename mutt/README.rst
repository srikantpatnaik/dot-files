README
======

This directory contains the ``.muttrc`` configuration file. This file goes to
user's home directory. Modify file according to your need.

Prerequisites
-------------


Setting up
----------

GPG signed passwords(optional, never store password in plain text)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a password file : ``~/.mutt/passwords``

Add following content ::

	set imap_pass="password"
	set smtp_pass="password"

Encrypt using GPG(GNU Privacy Guard) key (make sure you install 'gnupg-agent'
first::

	gpg --gen-key

Now encrypt the password file ::

	gpg -r your.email@example.com -e ~/.mutt/passwords

Verify the creation of GPG file in ``~/.mutt`` directory, later shred the plain
text file ::

	shred ~/.mutt/passwords && rm ~/.mutt/passwords

Now remove all your plain passwords from ``.muttrc`` and add the following at
the end of the file(or wherever) ::

	source "gpg -d ~/.mutt/passwords.gpg |"


Adding Google Address in mutt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install ``goobook`` using pip ::

	sudo pip install goobook

Get authenticated by Google ::

	goobook authenticate

Update your ``.muttrc`` with following content ::

	set query_command="goobook query %s"
	macro index,pager a "<pipe-message>goobook add<return>" "add sender to google contacts"
	bind editor <Tab> complete-query

Unlike many posts on internet, you don't need to create any ``.goobookrc`` file.
Thanks to developers, no more plain text passwords.


Adding sidebar
^^^^^^^^^^^^^^

Install ``mutt-patched`` ::

	sudo apt-get install mutt-patched

Locate comments and settings in ``.muttrc`` file.


Faster caching
^^^^^^^^^^^^^^

Create a RAM disk and mount it to any location. Typically a RAM disk can be used
for any application data for faster access.

Create a directory ::

	mkdir /mnt/mutt-ramdisk

Mount it with ``tmpfs`` ::

	mount -t tmpfs -o size=200m tmpfs /mnt/mutt-ramdisk

Now change your ``.muttrc`` with new header and message locations. See my muttrc
in ``pwd``.

It has a drawback too, upon restart the RAM disk will loose all its content.
Hence, it will fetch again.

External links
--------------

#. http://mutt.org

#. http://www.muttrcbuilder.org/


# Use the command-line to set a firmware password on macOS
## https://technology.siprep.org/use-the-command-line-to-set-a-firmware-password-on-macos/
For extra security, you can add a firmware password to Macs, especially since Find My Mac is essentially useless (unlike for iPads, which have an activation lock preventing thieves from reactivating the iPad after a factory reset) and DEP-to-MDM enrollments for Macs can even be avoided by thieves if they’re resourceful enough.

If you have a laptop with a firmware password, you need that password to boot from anything except the startup disk. Combine that with FileVault encryption, and a stolen Mac is pretty much useless. Doesn’t mean that you’ll necessarily get it back, but the likelihood is higher if the device is useless to thieves.

You can, of course, enable the firmware password via Recovery Mode, but it’s easier to do it from the command line:

sudo firmwarepasswd -setpasswd
You’ll be prompted for the new firmware password. Afterwards, you’ll need to reboot the machine for the change to take effect. (Be sure to make sure you have an actual startup disk selected in System Preferences!)
There are two modes for a firmware password: command and full. By default, the firmware password mode will be command, which means you’ll be prompted for the password only if you boot from something other than the startup disk. If, for some strange reason, you want the mode to be full, it would mean you’d be prompted for a firmware password at every boot, regardless of what you’re booting to.

A few other commands you might find useful…

sudo firmwarepasswd -check
checks to see if the firmware password is set.
sudo firmwarepasswd -verify
allows you to verify you have the correct password (without rebooting).
sudo firmwarepasswd -delete
deletes the firmware password. You’ll need the current one to delete it, of course.
If you want to script firmware password setting, someone wrote a fairly simple script that does it. There’s also firmware password manager, which is a far more sophisticated way to manage firmware passwords.

Your MDM (I know, for example, Mosyle does this) may be able to change firmware passwords for you.

If you’re a Munki admin, you can use this update-firmware-password nopkg in a pinch—just keep in mind that it, like the script above, stores the passwords in plain text.

Firmware Password Manager also stores the passwords in a key file in plain text, but that file gets deleted very shortly afterwards.

Nota Bene: If you enable a firmware password, you can get into target disk mode by holding down the Alt/Option key at boot, typing in the firmware password, and then holding down the T key. However, you will be unable to boot into Safe Mode unless you delete the firmware password.

Share this:
Click to share on Twitter (Opens in new window)Click to share on Facebook (Opens in new window)
July 21, 2017
Alan Siu

Uncategorized
firmware password, mac, macos, scripts, security
2 responses to “Use the command-line to set a firmware password on macOS”
rahul roy says:
August 12, 2019 at 2:32 pm
forgot firmware password

Reply
roy says:
September 1, 2020 at 8:44 am
^ WELL THEN YOU ARE SCREWED

Reply
Leave a Reply
Your email address will not be published. Required fields are marked *

Comment *

Name *

Email *

Website

 Notify me of follow-up comments by email.

 Notify me of new posts by email.

This site uses Akismet to reduce spam. Learn how your comment data is processed.

St. Ignatius College Prep Tech Blog

Proudly powered by WordPress
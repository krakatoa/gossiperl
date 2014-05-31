1. Create the deploy user
=========================
In the remote server:

adduser deploy
passwd -l deploy

Add this line to the /etc/sudoers file:

%deploy ALL=(ALL) NOPASSWD: ALL

chmod 440 /etc/sudoers

2. For each user that will use the deploy user:
===============================================

Add the public SSH key to the deploy user authorized_keys file, /home/deploy/.ssh/authorized_keys

chmod 600 /home/deploy/.ssh/authorized_keys
chmod 700 /home/deploy/.ssh
chown -R deploy:deploy /home/deploy/.ssh

3. Run bootstrap task:
======================

bundle exec cap development deploy:bootstrap
bundle exec cap development puppet:run

4. Deploy app:
==============

bundle exec cap development deploy
bundle exec cap development deploy:release

# README  

# Getting Started with You Are Not Alone  

This README describes the steps needed to get up and running as a developer
of the project.  This project uses Rails 6, Postgres, and Bootstrap.  The
instructions below describe how you set up an ubuntu linux environment, including
linux running under vagrant on Windows.  The steps for Mac are similar except
that you do brew install.

# Configuring Vagrant if you are using it

Rails 6 uses Webpacker and Yarn.  As a result, it requires support in the
environment for symbolic links.  To enable this, add the following to your
Vagrantfile:

```
config.vm.provider "virtualbox" do |v|
      v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end
```
You may already have the config.vm.provider block, in which case you add the
line described.  Then, bring down your vagrant environment with "vagrant halt"
if it is running, and close the Git Bash session.  Then, start a new Git Bash
session running it as the windows administrator.  Then do a "vagrant up".
From now on, whenever you do "vagrant up", you will need to do it from a Git
Bash session that was run as the windows administrator.

# Installing Prerequisites

Do:

`sudo apt-get update`  
`sudo apt-get install postgresql`    
`sudo apt-get install postgresql-contrib`  
`sudo apt-get install libpq-dev`  
`sudo apt-get install yarn`  

Now on linux (only) we need to get a current version of node, and the nodejs command must
point to it.  So we do:

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash`   
`nvm install --lts`  
`sudo apt remove nodejs`  
`which node`  

The which command will return a filename like

`/home/vagrant/.nvm/versions/node/v14.15.1/bin/node`

You create a symbolic link to it via

`ln -s /usr/bin/nodejs /home/vagrant/.nvm/versions/node/v14.15.1/bin/node`

Be sure that the ln command is passed the actual location returned by which.
The node/nodejs stuff is not needed on mac.

# Getting started with the git repository

In your browser, go to https://github.com/CodeTheDream/not-alone
Then fork that repository into your own github workspace.  Then clone your
not-alone workspace to your laptop, in an appropriate directory.  We will
use a git process as described here: https://learn.codethedream.org/midnight-train-git-workflow/
Please read the instructions at that link.  You may not understand them yet,
but you will.  The main point is that you have a triangular workflow, as
described in the document.  To set up the triangle, you need to do

git remote add upstream https://github.com/CodeTheDream/not-alone

# Setting up the not-alone application

You will do the following:

`yarn add bootstrap@4.5.3 jquery popper.js`  
`rvm install 2.70`  
`cd not-alone`  
`rvm use 2.7.0`  
`bundle install`  
`bin/rails webpacker:install`  
`yarn install --checkfiles`  
`bin/rails db:create`  
`bin/rails db:migrate`  
`bin/rails db:migrate RAILS_ENV=test`  
`bin/rails db:seed`    
`rspec`  

Each of these commands should complete without failures, including Rspec.  Then
run  

`bin/rails s`

adding -b 0.0.0.0 if you are running in vagrant.  Then see if you can get to
the server at localhost:3000.

If any of this fails, post the problem in the slack channel.

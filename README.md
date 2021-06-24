# Commit Viewer

Commit Viewer is a tool that allows you to view and store all commits of any GitHub repository.

This tool built with Ruby is available by using the Terminal where you will:
- input the HTTPS of the repository you wish
- view the commit list belonging to this repository.

Future improvements would brind a Ruby on Rails app that helps any user to visualize a commit list on a nice interface.

## Setup

After you cloned this project and "cd" to it, please install some gems:

```ruby
gem install 'timeout'
gem install 'csv'
gem install 'date'
gem install 'open-uri'
gem install 'json'
```

## Usage

At the root of the project, launch the interface:

```ruby
ruby interface.rb
```

Then, a message will ask you for a GitHub url. This is the HTTPS url of any repository of your choice (you know that link which ends with ".git")
Just copy that HTTPS and paste it into the Terminal. Run enter.

You get the commit list of that repository.
Have a look at the project folder, a csv file containing the commit list was creating so you can view it any time, even after exiting Terminal.

## Thanks and let's commit!

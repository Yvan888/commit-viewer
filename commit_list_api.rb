require 'open-uri'
require 'json'

def find_username(url)
  ## This method finds username of the GitHub account through the
  ## url provided by user.

  url_to_list = url.scan(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/)

  # username
  url_to_list[0][3]
end

def get_commits_api(username, repository)
  ## This method returns a json containing commits of the repository url
  ## provided by user.

  response = URI.open("https://api.github.com/repos#{username}#{repository}/commits")
  JSON.parse(response.read)
end

def parsing_api(commits)
  ## This method parse the commit list into an array of hashes.
  docs = []

  commits.each do |commit|
    docs << {
      SHA: commit['sha'],
      message: commit['commit']['message'],
      date: commit['commit']['author']['date'],
      author: commit['commit']['author']['name']
    }
  end

  docs
end

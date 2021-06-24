require 'csv'

def file_exists(file_name)
  ## This method fetch the commit list from a csv.

  fetched = []

  CSV.foreach(file_name) do |row|
    fetched << {
      SHA: row[0],
      message: row[1],
      date: row[2],
      author: row[3]
    }
  end

  # Deletes column names of the csv file
  fetched.delete_at(0)

  puts fetched
end

def file_does_not_exists(url)
  ## This method is applied when this is the first time
  ## getting a repository (with git CLI).

  commits = get_commits(url)

  docs = parsing(commits)

  data_persistence(docs, url)
end

def file_does_not_exists_api(url)
  ## This method is applied when this is the first time
  ## getting a repository (with GitHub API).

  username = find_username(url)

  commits = get_commits_api(username, File.basename(url, '.*'))

  docs = parsing_api(commits)

  data_persistence(docs, url)
end

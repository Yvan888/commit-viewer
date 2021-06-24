require 'date'
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

def get_commits(url)
  ## This method gets a commit list from a repository.

  puts `git clone #{url}`

  folder_name = File.basename(url, '.*')

  commits = Dir.chdir(folder_name.to_s) do
    `git log --pretty='%H|%s|%cd|%an'`
  end

  commits
end

def parsing(commits)
  ## This method parse the commit list into an array of hashes.

  docs = []

  commits.each_line do |line|
    parts = line.split('|')
    docs << {
      SHA: parts[0],
      message: parts[1],
      date: Date.parse(parts[2]),
      author: parts[3]
    }
  end

  docs
end

def data_persistence(docs, url)
  ## This methods persists the parsed commit lists to a csv file.

  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

  # TODO: csv file name change according to GitHub username
  # and repository name to avoid having two csv files
  # with the same name
  filepath = File.basename(url, '.*') + '_commits.csv'
  CSV.open(filepath, 'wb', csv_options) do |csv|
    csv << ['SHA', 'message', 'date', 'author']
    docs.each do |n|
      csv << n.values
    end
  end
end

def file_does_not_exists(url)
  ## This method is applied when this is the first time
  ## getting a repository.

  commits = get_commits(url)

  docs = parsing(commits)

  data_persistence(docs, url)
end

require 'date'
require 'csv'

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

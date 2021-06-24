require 'date'

puts 'To get a list of commits, please provide the GitHub url of a repository:'

# TODO: Regex to have: https://github.com/<username>/<repository>
url = gets.chomp

puts `git clone #{url}`

folder_name = File.basename(url, '.*')

commits = Dir.chdir(folder_name.to_s) do
  `git log --pretty='%H|%s|%cd|%an'`
end

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

puts docs

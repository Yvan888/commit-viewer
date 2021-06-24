require_relative 'file_existence'
require_relative 'commit_list'
require_relative 'commit_list_api'

require 'timeout'

puts 'To get a list of commits, please provide the GitHub url of a repository:'

# TODO: Regex to make sure input is of the form:
# https://github.com/<username>/<repository>
url = gets.chomp

if File.exist?(File.basename(url, '.*') + '_commits.csv')
  file_name = File.basename(url, '.*') + '_commits.csv'
  file_exists(file_name)
else
  # GitHub API
  begin
    Timeout.timeout(5) {
      puts file_does_not_exists_api(url)
    }

  # fallback git CLI:
  rescue Timeout.Error
    puts file_does_not_exists(url)
  end
end

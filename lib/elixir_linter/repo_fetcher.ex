defmodule ElixirLinter.RepoFetcher do 

  def fetch(repo) do 
    # git clone <repo link> ../../tmp/name_of_repo
    Porcelain.shell("git clone https://#{ENV['github_token']}:x-oauth-basic@github.com/#{repo}")
  end
end
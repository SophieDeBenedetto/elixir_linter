require IEx;

defmodule ElixirLinter.RepoFetcher do 
  @dir "tmp"
  def fetch(repo) do 
    repo 
    |> get_repo_name
    |> clone_repo_to_tmp(repo)
  end

  def get_repo_name(repo) do 
    String.split(repo, "/")
    |> List.last
  end

  def clone_repo_to_tmp(repo_name, repo) do 
    delete_repo_if_cloned(repo_name)
    Porcelain.shell("git clone https://#{Application.get_env(:elixir_linter, :github_oauth_token)}:x-oauth-basic@github.com/#{repo} #{@dir}/#{repo_name}")
    "#{@dir}/#{repo_name}"
  end

  def delete_repo_if_cloned(repo_name) do 
    File.ls!(@dir)
    |> Enum.member?(repo_name)
    |> remove_repo(repo_name)
  end

  def remove_repo(true, repo_name), do: File.rm_rf("#{@dir}/#{repo_name}")
  def remove_repo(false, repo_name), do: nil

end
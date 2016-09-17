defmodule Pinthub.Model.User  do
    @derive [Poison.Encoder]
    defstruct [:login, :id, :avatar_url, :gravatar_id, :url,
    :html_url, :followers_url, :following_url,
    :gists_url, :starred_url, :subscriptions_url,
    :organizations_url, :repos_url, :events_url,
    :received_events_url, :type, :site_admin, :name,
    :company, :blog, :location, :email, :hireable, :bio,
    :public_repos, :public_gists, :followers, :following, :created_at,
    :updated_at, :total_private_repos, :owned_private_repos,
    :private_gists, :disk_usage, :collaborators,
    plan: [:name, :space, :private_repos, :collaborators]]
end

namespace :deploy do
  task :compile do
    on roles(:app) do
      execute "cd '#{release_path}'; cd rel; rebar compile; rebar generate"
    end
  end

  task :release => [:'compile'] do
    on roles(:app) do
      execute "sudo", :service, "gossiperl restart"
    end
  end
end

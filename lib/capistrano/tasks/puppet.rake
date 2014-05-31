set :puppet_install_path, "/etc/puppet"

namespace :deploy do
  task :bootstrap do
    on roles(:all) do
      execute :mkdir, '-p', "/tmp/#{fetch(:application)}"
      upload!("manifests/bootstrap.sh", "/tmp/#{fetch(:application)}")
      execute "sudo", "sh -c", "'/tmp/#{fetch(:application)}/bootstrap.sh'"
    end
  end
end

namespace :puppet do
  task :upload do
    on roles(:all) do
      execute :mkdir, '-p', "/tmp/#{fetch(:application)}"
      upload!("manifests", "/tmp/#{fetch(:application)}", recursive: true)
    end
  end

  task :run => [:'upload'] do
    on roles(:all) do
      execute "sudo", "puppet", "apply", "/tmp/#{fetch(:application)}/manifests/gossip.pp", "--templatedir", "/tmp/#{fetch(:application)}/manifests/templates", "--verbose", "--debug"
    end
  end
end

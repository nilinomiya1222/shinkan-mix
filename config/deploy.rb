# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'shinkan-mix'
set :repo_url, 'git@github.com:nilinomiya1222/shinkan-mix.git'
set :bundle_gemfile,  "Gemfile"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/shinkan-mix'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# Ruby version by rbenv
set :rbenv_ruby, '2.1.7'

# Log
set :log_level, :debug

namespace :deploy do

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
#unicornのpidファイル、設定ファイルのディレクトリを指定
namespace :unicorn do
  task :environment do
    set :unicorn_pid,    "#{current_path}/tmp/pids/unicorn.pid"
    set :unicorn_config, "#{current_path}/config/unicorn/production.rb"
  end

#unicornをスタートさせるメソッド
  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end

#unicornを停止させるメソッド
  def stop_unicorn
    execute :kill, "-s QUIT $(< #{fetch(:unicorn_pid)})"
  end

#unicornを再起動するメソッド
  def reload_unicorn
    execute :kill, "-s USR2 $(< #{fetch(:unicorn_pid)})"
  end

#unicronを強制終了するメソッド
  def force_stop_unicorn
    execute :kill, "$(< #{fetch(:unicorn_pid)})"
  end

#unicornをスタートさせるtask
  desc "Start unicorn server"
  task start: :environment do
    on roles(:app) do
      start_unicorn
    end
  end

#unicornを停止させるtask
  desc "Stop unicorn server gracefully"
  task stop: :environment do
    on roles(:app) do
      stop_unicorn
    end
  end

#既にunicornが起動している場合再起動を、まだの場合起動を行うtask
  desc "Restart unicorn server gracefully"
  task restart: :environment do
    on roles(:app) do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        reload_unicorn
      else
        start_unicorn
      end
    end
  end

#unicornを強制終了させるtask 
  desc "Stop unicorn server immediately"
  task force_stop: :environment do
    on roles(:app) do
      force_stop_unicorn
    end
  end
end

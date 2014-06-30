role :app, %w{root@128.199.156.230}
role :web, %w{root@128.199.156.230}
role :db,  %w{root@128.199.156.230}

server '128.199.156.230', user: 'root', roles: %w{web app}

{ pkgs, lib, config, ... }:
let
app = "restupwebsite";
domain = "localhost";
socket = "/run/phpfpm/${app}.sock";
# dataDir = "/var/www/${domain}";
dataDir = "/var/www/restup";
in
{
  containers.webdev = {
    config = {
      networking.firewall.enable = false;
      networking.firewall.allowedTCPPorts = [ 80 82 ];

      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
      };
      services.phpfpm.pools.${app} = {
        user = app;
        settings = {
          "listen.owner" = "nginx";
          "pm" = "dynamic";
          "pm.max_children" = 32;
          "pm.max_requests" = 500;
          "pm.start_servers" = 2;
          "pm.min_spare_servers" = 2;
          "pm.max_spare_servers" = 5;
          "php_admin_value[error_log]" = "stderr";
          "php_admin_flag[log_errors]" = true;
          "catch_workers_output" = true;
        };
        phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
      };
      systemd.services.nginx.serviceConfig = {
        ProtectSystem = lib.mkForce false;
        ProtectHome = lib.mkForce false;
        ReadWritePahts = [ "/var" "/home" ];
      };
      services.nginx = {
        enable = true;
        virtualHosts.${domain} = {
          listen = [{
            addr = "127.0.0.1";
            port = 80;
          }];

          locations."/" = {
            root = dataDir;
            extraConfig = ''
              fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:${socket};
            include ${pkgs.nginx}/conf/fastcgi.conf;
            '';
          };
        };
      };
      users.users.${app} = {
        isSystemUser = true;
        createHome = true;
        home = dataDir;
        group  = app;
      };
      users.groups.${app} = {};
    };
  };
}

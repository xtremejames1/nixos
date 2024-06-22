{ pkgs, lib, config, ... }:
let
app = "restupwebsite";
domain = "127.0.0.1";
socket = "/run/phpfpm/${app}.sock";
# dataDir = "/var/www/${domain}";
dataDir = "/var/www/restup";
in
{
  environment.systemPackages = with pkgs; [
    nginx
    php
    php83Packages.composer
  ];
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

      root = dataDir;

      extraConfig = ''
      index index.html index.htm index.php;
      '';
      locations."/" = {
        extraConfig = ''
        try_files $uri $uri/ /index.html /index.php =404;
        '';
      };
      locations."~ \\.php$" = {
        # extraConfig = ''
        #   fastcgi_split_path_info ^(.+\.php)(/.+)$;
        #   fastcgi_pass unix:${socket};
        #   include ${pkgs.nginx}/conf/fastcgi.conf;
        # '';
        extraConfig = ''
          fastcgi_pass  unix:${socket};
        fastcgi_index index.php;
        '';
      };
    };
  };
  # users.users.${app} = {
  #   isSystemUser = true;
  #   createHome = true;
  #   home = dataDir;
  #   group  = app;
  # };
  # users.groups.${app} = {};
}

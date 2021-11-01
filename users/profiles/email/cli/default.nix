{ config
, pkgs
, ...
}:

{
  programs = {
    neomutt = {
      enable = true;
      vimKeys = true;
      sort = "threads";
      extraConfig = ''
        set sort_aux = reverse-last-date-received
      '';
    };
    mbsync = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };
  };

  services = {
    mbsync = {
      enable = true;
    };
  };

  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/mail";
    accounts = {
      "contact@rayandrew.me" = {
        address = "contact@rayandrew.me";
        userName = "contact@rayandrew.me";
        realName = "Ray Andrew";
        signature = {
          text = ''
            -- Ray Andrew
            -- https://rayandrew.me
          '';
          showSignature = "append";
        };
        passwordCommand = "${pkgs.pass}/bin/pass show email/contact@rayandrew.me";
        smtp = {
          host = "smtp.gmail.com";
        };
        imap = {
          host = "imap.gmail.com";
        };
        gpg = {
          key = "DB6291D746A44D86502B8EF83DF30C0071130B7D";
          signByDefault = true;
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
        msmtp = {
          enable = false;
        };
        notmuch = {
          enable = true;
        };
        neomutt = {
          enable = true;
        };
      };
      "raydreww@gmail.com" = {
        address = "raydreww@gmail.com";
        userName = "raydreww@gmail.com";
        smtp = {
          host = "smtp.gmail.com";
        };
        imap = {
          host = "imap.gmail.com";
        };
        gpg = {
          key = "DB6291D746A44D86502B8EF83DF30C0071130B7D";
          signByDefault = true;
        };
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
        msmtp = {
          enable = false;
        };
        notmuch = {
          enable = true;
        };
        neomutt = {
          enable = true;
        };
        primary = true;
        realName = "Ray Andrew";
        signature = {
          text = ''
            -- Ray Andrew
          '';
          showSignature = "append";
        };
        passwordCommand = "${pkgs.pass}/bin/pass show email/raydreww@gmail.com";
      };
    };
  };
}

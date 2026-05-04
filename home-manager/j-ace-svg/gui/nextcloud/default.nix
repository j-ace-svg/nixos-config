{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    /*
      systemd.user.services.nextcloud-client.Service.ExecStartPre = let
      server = "https://nextcloud.philotic.xyz";
      user = "j.ace.svg";
      displayName = "J.ace.svg";
      nextcloud-client-config = pkgs.writeText "nextcloud.cfg" ''
        [General]
        clientVersion=${pkgs.nextcloud-client.version}
        confirmExternalStorage=true
        isVfsEnabled=false
        launchOnSystemStartup=false
        newBigFolderSizeLimit=500
        optionalServerNotifications=false
        overrideLocalDir=
        overrideServerUrl=
        promptDeleteAllFiles=false
        showCallNotifications=false
        showChatNotifications=false
        showInExplorerNavigationPane=false
        useNewBigFolderSizeLimit=true

        [Accounts]
        0\Folders\1\ignoreHiddenFiles=false
        0\Folders\1\journalPath=.sync_ee05714b9319.db
        0\Folders\1\localPath=${config.home.homeDirectory}/Nextcloud/
        0\Folders\1\paused=false
        0\Folders\1\targetPath=/
        0\Folders\1\version=2
        0\Folders\1\virtualFilesMode=off
        0\authType=webflow
        0\dav_user=${user}
        0\displayName=${displayName}
        0\encryptionCertificateSha256Fingerprint=@ByteArray()
        0\networkDownloadLimit=0
        0\networkDownloadLimitSetting=-2
        0\networkProxyHostName=
        0\networkProxyNeedsAuth=false
        0\networkProxyPort=0
        0\networkProxySetting=0
        0\networkProxyType=2
        0\networkProxyUser=
        0\networkUploadLimit=0
        0\networkUploadLimitSetting=-2
        0\serverColor=@Variant(\0\0\0\x43\x1\xff\xff\0\0\x82\x82\xc9\xc9\0\0)
        0\serverHasValidSubscription=false
        0\serverTextColor=@Variant(\0\0\0\x43\x1\xff\xff\xff\xff\xff\xff\xff\xff\0\0)
        0\serverVersion=31.0.5.1
        0\url=${server}
        0\version=13
        0\webflow_user=${user}
      '';
      execstartpre-script = pkgs.writeScript "nextcloud-config-setup.sh" ''
        #!/bin/sh
        /run/current-system/sw/bin/mkdir -p ${config.home.homeDirectory}/.config/Nextcloud && /run/current-system/sw/bin/install "${nextcloud-client-config}" -T "${config.home.homeDirectory}/.config/Nextcloud/nextcloud.cfg"
      '';
    in ''
      /bin/sh ${execstartpre-script}
    '';
    */

    home.packages = [
      pkgs.nextcloud-client
    ];
  };
}

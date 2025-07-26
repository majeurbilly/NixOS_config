# Modifiez ce fichier de configuration pour définir ce qui doit être installé sur
# votre système. De l’aide est disponible dans la page de manuel configuration.nix(5)
# et dans le manuel de NixOS (accessible via la commande nixos-help).

{ config, pkgs, ... }:

{
  imports =
    [ # Inclut les résultats de l’analyse matérielle.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Définir le nom d’hôte de votre machine.
  # networking.wireless.enable = true;  # Active le support sans fil via wpa_supplicant.

  # Configurez un proxy réseau si nécessaire
  # networking.proxy.default = "http://utilisateur:motdepasse@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,domaine.interne";

  # Active le réseau
  networking.networkmanager.enable = true;

  # Définir le fuseau horaire.
  time.timeZone = "America/Toronto";

  # Sélectionner les propriétés de langue.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Activer le système de fenêtrage X11.
  services.xserver.enable = true;

  # Activer l’environnement de bureau GNOME.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configurer la disposition du clavier dans X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Activer CUPS pour permettre l’impression de documents.
  services.printing.enable = true;

  # Activer le son avec PipeWire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Si vous voulez utiliser des applications JACK, décommentez cette ligne
    #jack.enable = true;

    # Utilise le gestionnaire de session par défaut (le seul disponible pour le moment),
    # inutile de le redéfinir dans votre configuration pour l’instant.
    #media-session.enable = true;
  };

  # Activer le pavé tactile (activé par défaut dans la plupart des environnements de bureau).
  # services.xserver.libinput.enable = true;

  # Définir un compte utilisateur. N’oubliez pas de définir un mot de passe avec la commande `passwd`.
  users.users.g2k4 = {
    isNormalUser = true;
    description = "g2k4";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Installer Firefox.
  programs.firefox.enable = true;

  # Lister les paquets installés dans le profil système. Pour rechercher un paquet, utilisez :
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # N’oubliez pas d’ajouter un éditeur pour modifier ce fichier ! Nano est installé par défaut.
  #  wget
  ];

  # Certains programmes ont besoin de droits SUID, peuvent être configurés plus finement ou
  # sont lancés dans les sessions utilisateur.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Liste des services à activer :

  # Activer le service OpenSSH.
  # services.openssh.enable = true;

  # Ouvrir des ports dans le pare-feu.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Ou désactiver complètement le pare-feu.
  # networking.firewall.enable = false;

  # Cette valeur détermine la version de NixOS à partir de laquelle les réglages
  # par défaut (comme les emplacements des fichiers ou versions de base de données)
  # ont été appliqués à votre système. Il est recommandé de laisser cette valeur
  # à celle de votre installation initiale.
  # Avant de la modifier, lisez la documentation de cette option
  # (ex. man configuration.nix ou https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Avez-vous lu le commentaire ?
}
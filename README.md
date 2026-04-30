# nix-pipette-macos

Nix Home Manager configurations for the pipette macOS host (aarch64-darwin).

## 1. Prerequisites

Install [Nix](https://nixos.org/download/), then enable flakes by adding to `/etc/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

Restart the daemon after editing:

```bash
sudo launchctl kickstart -k system/org.nixos.nix-daemon
```

## 2. Installation

Clone the repo and make it readable by all users:

```bash
sudo git clone git@github.com:Liquid4All/nix-pipette-macos.git /private/etc/nix-config
sudo chmod -R a+rX /private/etc/nix-config
```

## 3. Usage

First time (home-manager not yet installed):

```bash
nix run home-manager -- switch --flake "path:/private/etc/nix-config#<username>"
```

After that:

```bash
home-manager switch --flake "path:/private/etc/nix-config#<username>"
```

## 4. Updating

Pull the latest changes and re-apply:

```bash
sudo git -C /private/etc/nix-config pull
home-manager switch --flake "path:/private/etc/nix-config#<username>"
```

## 5. Customization

### 5.1 Adding a new user

In `flake.nix`, add an entry to `homeConfigurations`:

```nix
alice = mkHome { username = "alice"; };
```

### 5.2 Per-user packages

Uncomment and populate `extraPackages` in `flake.nix`:

```nix
alice = mkHome {
  username = "alice";
  extraPackages = with pkgs; [ spotify-player ];
};
```

### 5.3 Shared packages

Edit `common.nix` to add or remove packages shared by all users.

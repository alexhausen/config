# Nix OS

### instalação
```
cd config/nixos
nix-shell
```

### upgrade
```sh
cd config/nixos
nix flake update
```


### rebuild
```sh
sudo nixos-rebuild switch --upgrade --flake ~/config/nixos#inspiron
```

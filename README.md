# ICPConfig

## Usage
```bash
nix run .#minimal $Filename
```

```bash
nix run . $Filename
```


You can also access it over the internet by using:
```bash
nix run github:ElrohirGT/ICPConfig#minimal $Filename
```

Remember to use nix flakes, otherwise you would need to add the flags like this:
```bash
nix run --experimental-features 'nix-command flakes' github:ElrohirGT/ICPConfig#minimal $Filename
```

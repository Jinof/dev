# DEV

> This is a repo for dev docker which contains pre installed dev enviroment

## Usage

```bash
docker pull jinof/dev:latest
docker run --name dev -v path/to/source:/root/source -it jinof/dev:latest /bin/zsh
```
Next time you want to open your container

```bash
docker exec -it dev /bin/zsh
```
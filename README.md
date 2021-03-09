# DockerPHP

Docker base image for PHP in development, developed by SDL Technology

To push a new version do the following (where `<version>` is the new semantic image version you want to push, example: `1.5.2`):

```bash
docker build -t sdl-docker-php:<version> .
docker tag sdl-docker-php:<version> 1vasari/sdl-docker-php:<version>
docker push 1vasari/sdl-docker-php:<version>
```

# License

GNU General Public License

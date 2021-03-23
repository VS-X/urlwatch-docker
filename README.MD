# urlwatch-docker

This is an image with `urlwatch` installed.

## Info

There are 2 images, `slim` and `navigate`. The latter one is larger, with more dependencies to run headless Chromium which is used for `navigate` jobs (when websites require JS to render). Slim has the bare minimum number of dependencies.

Additionally, to enable sandboxing in Chromium you might need to do `sysctl` modification:

```
kernel.unprivileged_userns_clone=1
```

The image uses `yacron` for easy cron scheduling via `yaml` file

## Basic example

`docker-compose.yaml`

```yaml
version: '2.4'

services:
  urlwatch:
    image: ghcr.io/vs-x/urlwatch-docker:navigate
    container_name: urlwatch
    user: 1000:1000
    cap_add: # is needed in `navigate` to enable sandboxing in Chromium
      - SYS_ADMIN
    volumes:
      - /ContainerData/urlwatch:/home/urlwatch/.urlwatch
    restart: unless-stopped
```

Additionally this image needs 3 more files: `cron.yaml`, `urls.yaml`, `urlwatch.yaml`.

`cron.yaml` - modify schedule cron to your needs

```yaml
jobs:
  - name: run urlwatch
    command: urlwatch --urls urls.yaml --config urlwatch.yaml --hooks hooks.py --cache cache.db
    shell: /bin/bash
    schedule: '*/30 * * * *'
```

Consult official `urlwatch` docs to find out what `urls.yaml` and `urlwatch.yaml` should contain.

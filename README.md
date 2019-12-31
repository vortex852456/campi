# campi
Docker camera module for RPI (only tested with RPI Zero W Rev 1.1)

## Use with docker-compose.yml
```
version: "3"

services:
  campi:
    image: vortex852456/campi:latest
    container_name: campi
    ports:
      - 8081:8081
      - 8554:8554
    devices:
      - /dev/video0:/dev/video0
```

# V Rising Dedicated Server

Docker Container with Wine wrapper.  
This is a temporary solution until a proper linux executable server is released.

Tested with v0.5.41821

## Requirements

- docker v20.10.16 [how to install - step 1 & 2](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
- docker-compose (recommended) v1.29.2 [how to install](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)

## Preparation

Create a `vrising-server` directory in your user's home directory.  
In there, the docker container will generate the `Saves` folder and you can add a `Settings` folder with your custom settings. This can be done ahead of starting the container for the first time.

Custom settings are three files:

- ServerGameSettings.json
- ServerHostSettings.json
- ServerVoipSettings.json

Examples for the first two is available in `${HOME}/VRisingServer_Data/StreamingAssets/Settings` inside the docker container itself or online searching for examples.

The third one is to allow VOIP to be enabled in the game. You'll need to apply for a developer token at Vivox and fill the empty values with your credentials when approved. If you don't have a valid token or don't care for VOIP to be enabled in game, you can skip this file.

```
{
    "VOIPEnabled": true,
    "VOIPIssuer": "",
    "VOIPSecret": "",
    "VOIPAppUserId": "",
    "VOIPAppUserPwd": "",
    "VOIPVivoxDomain": "",
    "VOIPAPIEndpoint": "",
    "VOIPConversationalDistance": 14,
    "VOIPAudibleDistance": 40,
    "VOIPFadeIntensity": 2.0
}
```

## Start it

Clone this repo with `git clone https://github.com/theCrius/v-rising.git`.  
This will generate a directory called `v-rising`.

From the `v-rising` directory:

Run these two commands to be sure that the container user have access to your `vrising-server` directory:  
`export UID=$(id -u)`  
`export GID=$(id -g)`

The first command should give you a warning telling you that the UID environment already exists and it's read only. That is the correct output to expect.

After that, run:

`docker-compose up --build -d`

## Stop it

From the `v-rising` directory:

`docker-compose down`

## Update V Rising

From the `v-rising` directory:

Run `export UID=$(id -u)` and `export GID=$(id -g)`

Then `docker-compose build --no-cache && docker-compose up -d --force-recreate`

## Access the running container

`docker exec -it vrising-server_vrising_1 /bin/bash`  

`vrising-server_vrising_1` is an example. Your container name may be different.

## Add an admin to the V Rising Server

Due to a current bug(?) in how the server read the `adminlist.txt` file, you have to edit the file that is running in the container. This could be fixed in future releases so you may ignore this section.  
Simply enter the container and run `echo "steamID64" > VRisingServer_Data/StreamingAssets/Settings/adminlist.txt` just replacing `steamID64` with the Steam ID you want to add to the admin list.

The `adminlist.txt` file is watched so there is no need for a restart.

## Check logs from outside the container

From the `v-rising` directory:

`docker-compose logs --follow` and `CTRL+C` to stop watching the logs

## Contributing

Feel free to fork this repo and open a PR if you want to contribute.

## Credits

Initial Dockerfile from Ponjimon/vrising-docker

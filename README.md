# Using Docker containers with Node.js script 'as an executable'

(See also ["Using Docker containers with Node.js/express"](https://github.com/a-sansom/nodejs_docker)).

This is just an experimental repository for seeing what's possible with Docker (`Dockerfile` and `docker-compose.yml`
that references the `Dockerfile`) and VS Code and PHPStorm IDEs for development/debugging purposes of a Node.js script,
so a Docker container runs the script as if it was an executable command on the host system.

See comments in the `Dockerfile` and `docker-compose.yml` files for general usage.

Running `docker-compose --verbose build` will build a new `alexsansom/nodejs_executable_docker` image (with
a `latest` tag).

To create and run a container (outside/independently of any IDE's Docker capabilities) from it use
`docker-compose run --rm nodejs_executable_docker` (where the `--rm` means the container will be removed after running).

To affect the number of iterations output when running, supply a parameter, for example
`docker-compose run --rm nodejs_executable_docker 10`.

The running container runs a simple Node.js script that prints an iteration count to the console a specified number of
times (5, by default).

## Step debugging 'docker as an executable' Node.js script using Dockerfile/docker-compose.* and VS Code

Included in this repository is the file `.vscode/extensions.json`. When this directory is opened in VS Code, because of
this file, a dialogue offering to install the extensions listed in the file will appear, which you should accept. The
extensions installed are related to Docker and remote debugging, which are needed for step debugging in a Docker
container.

To achieve step debugging of the `simple-script-example.js` script with VS code, we need to create a second Docker
compose file `docker-compose.extend.yml` with a `command` that overrides the default `CMD` in the `Dockerfile`, and then
create a `.devcontainer.json` project file that references both the `docker-compose.yml` and the
`docker-compose.extend.yml` files.

Open the project in VS Code, and you're prompted (by the existence of `.devcontainer.json`) to open the folder in a
container, for development.

When the folder is re-opened in the container (you can use `Remote-Containers: Reopen Folder in Container` in command
palette also), a tagged Docker image is built (if one doesn't already exist), the Docker container is created/modified
by VS Code (and left in a running, 'sleep'-like state (show this by running `docker ps`).

You can then set a breakpoint in the code and start/run the application (`F5 or Debug: Start Debugging` from command
palette), and any debug breakpoint(s) should be hit whilst script output goes to stdout.

Once the script finishes, the container is still running (verify via `docker ps`) due to the `docker-compose.extend.yml`
configuration `command: sleep infinity`.

The running Docker container is stopped when you close VS Code (the folder that was opened 'in the container').

## Step debugging 'docker as an executable' Node.js script using Dockerfile/docker-compose.* and PHPStorm (2019.1.3)

To be able to debug the script, you just need to add a new 'Run/debug configuration' with a new remote Node.js
interpreter that's configured by selecting the `Docker compose` option and using the `docker-compose.yml` file in this
directory.

Doesn't seem like you can currently pass arguments to the `docker-coompose` command that PHPStorm creates/calls, so
therefore you can't supply the `--rm` option to remove the container after it's exited. There's also no option to be
able to use that option directly in the `docker-compose.yml` file either.

With this simple setup, you don't seem to be able to use the `Application parameters` field to override the default
`Dockerfile`'s `CMD` value. You can override that value on the CLI though, for example
`docker-compose run --rm nodejs_executable_docker 10` (May be a bug? It seems that this functionality is possibly
quite new, going by a Jetbrains blog [1]).

[1] [WebStorm 2019.1 EAP #7: run Node.js using Docker Compose, Recent Locations popup]()https://blog.jetbrains.com/webstorm/2019/03/webstorm-2019-1-eap-7/)
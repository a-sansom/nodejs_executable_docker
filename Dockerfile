# Make changes to this file. Then, build a new image with:
#
#     docker build -t alexsansom/nodejs_executable_docker .
#
# Run a container 'as an executable', and mount the current directory as a Docker volume, based on the image, with:
#
# NOTE: Not using the '-d' docker CLI option as we're using the image 'as an executable', so we want to see its output when run.
# NOTE: We are using the '--rm' option to remove the container when it exists so we're not left with numerous stopped containers after running multiple times.
# NOTE: (pwd) is fish shell specific for printing present working directory. Could be ($pwd) in other shells.
#
#     docker run --rm -v (pwd):/app alexsansom/nodejs_executable_docker
#
# Alternatively, using docker-compose(.yml) that encompasses CLI params in the file, to build a new image(s):
#
#     docker-compose --verbose build
#
# Using docker-compose to run a new container for the specified docker-compose 'service', and remove it when it exits (again, so we aren't left with numerous stopped containers):
#
#     docker-compose run --rm nodejs_executable_docker
#
# Or, the same as previous example, but specifying a param that's passed in to the running script, which overrides the default CMD in the Dockerfile:
#
#     docker-compose run --rm nodejs_executable_docker 20
#
FROM node:10

# Set the context of where we will be executing commands in the container.
WORKDIR /app

# Run the 'application', with 'node'.
#
# Both ENTRYPOINT and CMD achieve a running node(mon) 'application'. But, the
# intent of each directive is different. The closest to a decent, easy to
# understand explanation on the difference yet seen is each commands section
# in this 'best practices' guide:
#
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
ENTRYPOINT ["node", "simple-script-example.js"]

# Default to count to. By specify both ENTRYPOINT and CMD here the default command
# that gets run is 'nodemon simple-script-example.js 10', as both directives are
# supplied in the 'exec form' (using parenthesis), not the 'shell form'.
#
# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
CMD ["5"]
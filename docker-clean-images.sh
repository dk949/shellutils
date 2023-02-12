#shellcheck disable=SC2046 # Need to remove all images, not one image with spaces
docker rmi $(docker images -a --filter=dangling=true -q)

#shellcheck disable=SC2046 # Need to remove all images, not one image with spaces
docker rm $(docker ps --filter=status=exited --filter=status=created -q)

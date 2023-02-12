docker rmi $(docker images -a --filter=dangling=true -q)

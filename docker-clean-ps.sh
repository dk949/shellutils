docker rm $(docker ps --filter=status=exited --filter=status=created -q)

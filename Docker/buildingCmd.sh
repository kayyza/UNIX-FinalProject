
#to remplace <name>:<tag> and <image-name>:<tag> with dockerfile name and image name and tags

docker build -t <name>:<tag>
docker run -p 9000:80 <image-name>:<tag> 

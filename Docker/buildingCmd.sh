
#to remplace <name>:<tag> and <image-name>:<tag> with dockerfile name and image name and tags

docker build -t brinaWebApp:1.0 .
docker run -d -p 8080:80 brinaWebApp:1.0

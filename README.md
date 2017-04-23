# docker for tars

docker build -t tars  .

docker run -d -p 8080:8080 -v /tmp:/root/Tars/cpp/build tars

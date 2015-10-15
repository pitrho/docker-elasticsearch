# Docker Elasticsearch

This repository contains the configuration for building a
[Elasticsearch](https://www.elastic.co/products/elasticsearch) Docker image using
[Ubuntu 14.04 LTS](http://releases.ubuntu.com/trusty/). This particular
Docker image

* has a reasonable default Elasticsearch configuration;
* makes it easy to override those defaults;
* makes it easy to persist your data across container restarts;


## Building the image

Clone the repository

  	git clone https://github.com/pitrho/docker-elasticsearch.git
  	cd docker-elasticsearch
  	./build

De default tag for the new image is pitrho/elasticsearch. If you want to specify a
different tag, pass the -t flag along with the tag name:

    ./build -t new/tag

Be default, the image installs version 1.7.2. If you want to install
a different version, pass the -v flag along with the version name:

    ./build -v 1.7.1


## Example usage

### Basic usage

Start the image using the default configuration:

	docker run -d -p 27017:27017 pitrho/elasticsearch

## Passing extra configuration to start Elasticsearch

To pass additional settings to `elasticsearch`, you can use environment variable
`EXTRA_OPTS`.

  	docker run -d -p 27017:27017 -e EXTRA_OPTS="--other-options-here" pitrho/elasticsearch


## Volumes

This image does not enforce any volumes on the user. Instead, it is up to the
user to decide how to create any volumes to store the data. Docker has several
ways to do this. More information can be found in the Docker
[user guide](https://docs.docker.com/userguide/dockervolumes/).

Note that the default path where the data is stored inside the container is at
/var/lib/elasticsearch. You can mount a volume at this location to create external
backups.

## Logs

By default, logs are stored at /var/logs/elasticsearch and they are automatically
rotated and printed to stdout.

## License

MIT. See the LICENSE file.


## Contributors

* [Alejandro Mesa](https://github.com/alejom99)
* [Gilman Callsen](https://github.com/callseng)

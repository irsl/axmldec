FROM debian:buster

RUN apt update -y && \
    apt install -y g++ cmake zlib1g-dev git \
	   libboost-system-dev libboost-iostreams-dev libboost-program-options-dev libboost-locale-dev libboost-regex-dev \
	   libboost-system1.67.0 libboost-iostreams1.67.0 libboost-program-options1.67.0 libboost-locale1.67.0 libboost-regex1.67.0 \
	   && \
	mkdir /build && \
	cd /build && \
	git clone --recursive https://github.com/ytsutano/axmldec.git && \
	cd axmldec && \
	cmake -DCMAKE_BUILD_TYPE=Release . && \
	make install && \
	apt remove -y g++ cmake zlib1g-dev git libboost-system-dev libboost-iostreams-dev libboost-program-options-dev libboost-locale-dev libboost-regex-dev && \
	apt autoremove -y && \
	rm -rf /var/lib/{apt,dpkg,cache,log}
	
# mount your stuff here!
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/axmldec"]

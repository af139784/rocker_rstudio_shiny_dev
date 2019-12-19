#!/usr/bin/with-contenv bash

ADD_ARROW=${ADD_ARROW:=none}

## A script to add apache-arrow to an rocker image.  

if [ "$ADD_ARROW" == "yes" ]; then
echo "Adding apache-arrow to container..."	

  apt update && apt install -y -V apt-transport-https curl gnupg lsb-release && \
	tee /etc/apt/sources.list.d/backports.list <<APT_LINE && \
	deb http://deb.debian.org/debian $(lsb_release --codename --short)-backports main && \
	APT_LINE && \
	curl --output /usr/share/keyrings/apache-arrow-keyring.gpg https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-keyring.gpg && \
	tee /etc/apt/sources.list.d/apache-arrow.list <<APT_LINE && \
	deb [arch=amd64 signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main && \
	deb-src [signed-by=/usr/share/keyrings/apache-arrow-keyring.gpg] https://dl.bintray.com/apache/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/ $(lsb_release --codename --short) main && \
	APT_LINE && \
	curl https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - && \
	tee /etc/apt/sources.list.d/llvm.list <<APT_LINE && \
	deb http://apt.llvm.org/$(lsb_release --codename --short)/ llvm-toolchain-$(lsb_release --codename --short)-7 main && \
	deb-src http://apt.llvm.org/$(lsb_release --codename --short)/ llvm-toolchain-$(lsb_release --codename --short)-7 main && \
	APT_LINE && \
	apt update && \
	apt install -y -V libarrow-dev && \
	apt install -y -V libarrow-glib-dev && \
	apt install -y -V libarrow-flight-dev && \
	apt install -y -V libplasma-dev && \
	apt install -y -V libplasma-glib-dev && \
	apt install -y -V libgandiva-dev && \
	apt install -y -V libgandiva-glib-dev && \
	apt install -y -V libparquet-dev && \
	apt install -y -V libparquet-glib-dev && \
	install2.r -s --error \
	    arrow && \
	R -e "arrow::install_arrow()"
fi

if [ $"$ADD_ARROW" == "none" ]; then
  echo "Nothing additional to add"
fi       

[200~# Darkness4/dnsmasq
dnsmasq separated from host's configs

## Usage

### From Docker Hub (after image build)

```sh
docker pull darkness4/dnsmasq:latest
```

Create first your own hosts. This file will be **appended** to the container hosts (which is nothing).

Optionally, create your own dnsmasq.conf.

By default, dnsmasq.conf:

```bash
log-queries

# Never forward plain names (without a dot or domain part)
domain-needed

# Never forward addresses in the non-routed address spaces.
bogus-priv

# Include all files in a directory which end in .conf
# conf-dir=/etc/dnsmasq.d/,*.conf

# If you don't want dnsmasq to read /etc/resolv.conf or any other
# file, getting its servers from this file instead (see below), then
# uncomment this.
no-resolv

server=8.8.8.8
server=1.1.1.1

# Whenever /etc/resolv.conf is re-read, clear the DNS
# cache.  This is useful when new nameservers may have
#	different data than that held in cache.
clear-on-reload

# By  default,  dnsmasq  will  send queries to any of the upstream
# servers it knows about and tries to favour servers to are  known
# to  be  up.  Uncommenting this forces dnsmasq to try each query
# with  each  server  strictly  in  the  order  they   appear   in
# /etc/resolv.conf
strict-order

# If you want to disable negative caching, uncomment this.
no-negcache

# If you don't want dnsmasq to poll /etc/resolv.conf or other resolv
# files for changes and re-read them then uncomment this.
no-poll

# Set the cachesize here.
cache-size=1000

```

Then, run:


```bash
docker run -it --restart always -v /path/to/your/dnsmasq.conf:/etc/dnsmasq.conf -v /path/to/your/hosts:/data/hosts -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --name dnsmasq darkness4/dnsmasq:latest
```

### From Github (before image build)

```sh
git pull https://github.com/Darkness4/dnsmasq.git
```

Customize ./conf/dnsmasq.conf.

Add/modify files in ./hosts

Then, run:

```sh
./build.sh && ./run.sh
```

## Update hosts and configuration files without removing container

### Files created after image build

Edit your /path/to/your/dnsmasq.conf and/or /path/to/your/hosts.

Then, run:

```sh
docker restart dnsmasq
```

or, if you want to attach (Ctrl+P then Ctrl+Q to detach):

```sh
docker stop dnsmasq
docker start dnsmasq -ai
```

### Files created before image build

#### From Github

Edit any files in hosts.

```sh
./update-hosts.sh
```

#### Docker exec

##### dnsmasq.conf

If you ran with a volume (-v /path/to/your/dnsmasq.conf:/etc/dnsmasq.conf), then edit your /path/to/your/dnsmasq.conf. 

If not, then, edit/create dnsmasq.conf (if you have the github repo, dnsmasq.conf is in ./conf/)

```bash
docker cp path/to/dnsmasq.conf dnsmasq:/etc/dnsmasq.conf
```

##### hosts

Cleanup:

```sh
docker exec dnsmasq sh -c "rm /data/*"
```

Add your hosts_file,

```sh
docker cp hosts_file dnsmasq:/data/
```

```sh
docker cp folder_containing_multiples_hosts_files/. dnsmasq:/data/
```

Then, **replace** hosts:

```sh
docker exec dnsmasq sh -c "cat /data/* > /etc/hosts"
```

Then, run:

```sh
docker restart dnsmasq
```

or, if you want to attach (Ctrl+P then Ctrl+Q to detach):

```sh
docker stop dnsmasq
docker start dnsmasq -ai
```

## License

```
MIT License

Copyright (c) 2019 Marc NGUYEN

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

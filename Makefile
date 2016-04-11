all: base

base: Dockerfile Puppetfile default.pp
	docker build -t tier/base .


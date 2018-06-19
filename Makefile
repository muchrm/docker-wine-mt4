name = metatrader4
repo = muchrm/$(name)
commit = latest
docker:
	docker build -f Dockerfile -t $(repo):$(commit) .
run:
	docker run --rm -t -d -p 5900:5900 --name $(name) $(repo)
push:
	docker push $(repo)
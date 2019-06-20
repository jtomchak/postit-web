# Postit

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix

- create compute instance VPS
  gcloud compute instances create postit-instance --image-family debian-9 --image-project debian-cloud --machine-type g1-small --scopes "userinfo-email,cloud-platform" --metadata-from-file startup-script=instance-startup.sh --metadata release-url=gs://\${BUCKET_NAME}/postit-release --zone us-central1-f --tags http-server

- check if instance was created
  gcloud compute instances get-serial-port-output postit-instance --zone us-central1-f

- firewall rule
  gcloud compute firewall-rules create default-allow-http-4000 --allow tcp:4000 --source-ranges 0.0.0.0/0 --target-tags http-server --description "Allow port 4000 access to http-server"

## Going with Docker 🤷‍♀️

The reason really only comes down to deployment. Seems the only way I'm gonna get smooth CI/CD upgrades on commit is to create a docker wrapper for my app executable.

[x] - create new phx app and `mix ecto.create`, then get it running
[x] - create sql instance for project in gcloud
[x] - connect manually to sql db `psql -h /tmp/cloudsql/[connection-name] -U postgres
[x] - build a prod release

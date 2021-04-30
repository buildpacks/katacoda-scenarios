# Setup local environment

First, we'll create a sample Ruby app that you can use when developing your buildpack:

<!-- test:exec -->
```bash
mkdir ruby-sample-app
```{{execute}}

Create a file in the current directory called `ruby-sample-app/app.rb`{{open}} with the following contents:

<pre class="file" data-filename="ruby-sample-app/app.rb" data-target="replace">
require 'sinatra'

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  'Hello World!'
end
</pre>

Then, create a file called `ruby-sample-app/Gemfile`{{open}} with the following contents:

<!-- test:file=ruby-sample-app/Gemfile -->
<pre class="file" data-filename="ruby-sample-app/Gemfile" data-target="replace">
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "sinatra"
</pre>

Finally, make sure your local Docker daemon is running by executing:

<!-- test:exec -->
```bash
docker version
```{{execute}}

If you see output similar to the following, you're good to go! Otherwise, start Docker and check again.

```
Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:39 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:13:06 2019
  OS/Arch:          linux/amd64
  Experimental:     true
```

---

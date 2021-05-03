# Building blocks of a Cloud Native Buildpack
<!-- test:suite=create-buildpack;weight=2 -->

Now we will set up the buildpack scaffolding. 

Let's create the directory where your buildpack will live:

<!-- test:exec -->
```bash
mkdir ruby-buildpack
```{{execute}}

### buildpack.toml

You will now need a `buildpack.toml` to describe our buildpack.

Create the `ruby-buildpack/buildpack.toml`{{open}} file and copy the following into it:

<!-- test:file=ruby-buildpack/buildpack.toml -->
<pre class="file" data-filename="ruby-buildpack/buildpack.toml" data-target="replace">
# Buildpack API version
api = "0.5"

# Buildpack ID and metadata
[buildpack]
id = "examples/ruby"
version = "0.0.1"
name = "Ruby Buildpack"

# Stacks that the buildpack will work with
[[stacks]]
id = "io.buildpacks.samples.stacks.bionic"
</pre>

You will notice two specific fields in the file: `buildpack.id` and `stack.id`. The buildpack ID is the way you will reference the buildpack when you create buildpack groups, builders, etc. The stack ID is the root file system in which the buildpack will be run. This example can be run on one of two different stacks, both based upon Ubuntu Bionic.

### `detect` and `build`

Next you will need to create the `detect` and `build` scripts. These files must exist in a `bin` directory in your buildpack directory.

Create your `bin` directory and then change to that directory.

<!-- test:exec -->
```bash
mkdir ruby-buildpack/bin
```{{execute}}

Now create your `ruby-buildpack/bin/detect`{{open}} file and copy in the following contents:

<!-- test:file=ruby-buildpack/bin/detect -->
<pre class="file" data-filename="ruby-buildpack/bin/detect" data-target="replace">
#!/usr/bin/env bash
set -eo pipefail

exit 1
</pre>

Now create your `ruby-buildpack/bin/build`{{open}} and copy in the following contents:

<!-- test:file=ruby-buildpack/bin/build -->
<pre class="file" data-filename="ruby-buildpack/bin/build" data-target="replace">
#!/usr/bin/env bash
set -eo pipefail

echo "---> Ruby Buildpack"
exit 1
</pre>

You will need to make both of these files executable, so run the following command:

<!-- test:exec -->
```bash
chmod +x ruby-buildpack/bin/detect ruby-buildpack/bin/build
```{{execute}}

These two files are now executable `detect` and `build` scripts. You are now able to use this buildpack.

### Using your buildpack with `pack`

In order to test your buildpack, you will need to run the buildpack against your sample Ruby app using the `pack` CLI.

Set your default [builder][builder] by running the following:

<!-- test:exec -->
```bash
pack config default-builder cnbs/sample-builder:bionic
```{{execute}}

Then run the following `pack` command:

<!-- test:exec;exit-code=1 -->
```bash
pack build test-ruby-app --path ./ruby-sample-app --buildpack ./ruby-buildpack
```{{execute}}

The `pack build` command takes in your Ruby sample app as the `--path` argument and your buildpack as the `--buildpack` argument.

After running the command, you should see that it failed to detect, as the `detect` script is currently written to simply error out.

<!-- test:assert=contains -->
```
===> DETECTING
[detector] err:  examples/ruby@0.0.1 (1)
[detector] ERROR: No buildpack groups passed detection.
[detector] ERROR: failed to detect: buildpack(s) failed with err
```


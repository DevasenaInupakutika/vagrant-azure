#Vagrant Windows Azure Provider

<span class="badges">
[![Build Status](https://secure.travis-ci.org/10thmagnitude/vagrant-azure.png)](http://travis-ci.org/10thmagnitude/vagrant-azure) [![Code Climate](https://codeclimate.com/repos/528a8e3ff3ea0041270b7cee/badges/4e4e11d58022df01ca23/gpa.png)](https://codeclimate.com/repos/528a8e3ff3ea0041270b7cee/feed)
[![Coverage Status](https://coveralls.io/repos/10thmagnitude/vagrant-azure/badge.png)](https://coveralls.io/r/10thmagnitude/vagrant-azure)
</span>

This is a [Vagrant](http://www.vagrantup.com) 1.2+ plugin that adds a [Windows Azure](http://www.windowsazure.com/)
provider to Vagrant, allowing Vagrant to control and provision machines in
Windows Azure.

**NOTE:** This plugin requires Vagrant 1.2+,

## Features

* Boot up virtual machines in Azure (TODO)
* SSH or WinRM into the instances (TODO)
* Provision the instances with the built-in providers (shell, Puppet, Chef) (TODO)

## Usage

Install using standard Vagrant 1.1+ plugin installation methods. After
installing, `vagrant up` and specify the `azure` provider. An example is
shown below.

```
$ vagrant plugin install vagrant-azure
...
$ vagrant up --provider=azure
...
```
This assumes you have an Azure-compatible box file for use with Vagrant.

## Quick Start

After installing the plugin (instructions above), the quickest way to get
started is to actually use a dummy AWS box and specify all the details
manually within a `config.vm.provider` block. So first, add the dummy
box using any name you want:

```
$ vagrant box add dummy URL REDACTED
...
```

And then make a Vagrantfile that looks like the following, filling in
your information where necessary.

```
Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :azure do |azure, override|
    azure.publish_settings_file= "PATH TO YOUR PUBLISH SETTINGS"
    azure.subscription_id = "YOUR SUBSCRIPTION ID"
    azure.source_vhd = "chef-tpl-2k8r2"

  end
end
```

And then run `vagrant up --provider=azure`.

This will start an Ubuntu 12.04 instance in the REDACTED region within
your account. And assuming your SSH/WinRM information was filled in properly
within your Vagrantfile, SSH/WinRM and provisioning will work as well.

## Box Format

Every provider in Vagrant must introduce a custom box format. This
provider introduces `azure` boxes. You can view an example box in
the [example_box/ directory](https://github.com/mitchellh/vagrant-aws/tree/master/example_box).
That directory also contains instructions on how to build a box.

The box format is basically just the required `metadata.json` file
along with a `Vagrantfile` that does default settings for the
provider-specific configuration for this provider.

## Configuration

This provider exposes quite a few provider-specific configuration options:

(more to come)

* `publish_settings_file` - Path to the publish settings to use
* `subscription_id` - Which subscription to use in the account
* `source_vhd` - The name of the image to start with

These can be set like typical provider-specific configuration:

```ruby
Vagrant.configure("2") do |config|
  # ... other stuff

  config.vm.provider :azure do |azure|
    azure.publish_settings_file = "c:\users\mstratton\mstratton.publishsettingsfile"
    azure.ssubscription_id = "cc0e62b9-6a31-XXXX-a580-907c8297557b"
  end
end
```

## Networks

Networking features in the form of `config.vm.network` are not
supported with `vagrant-azure`, currently. If any of these are
specified, Vagrant will emit a warning, but will otherwise boot
the Windows Azure machine.

## Synced Folders

There is currently no support for synced folders. TODO!

## Contributing

To work on the `vagrant-azure` plugin, clone this repository out, and use
[Bundler](http://gembundler.com) to get the dependencies:

```
$ bundle
```

Once you have the dependencies, verify the unit tests pass with `rake`:

```
$ bundle exec rake
```

If those pass, you're ready to start developing the plugin. You can test
the plugin without installing it into your Vagrant environment by just
creating a `Vagrantfile` in the top level of this directory (it is gitignored)
and add the following line to your `Vagrantfile` 
```ruby
Vagrant.require_plugin "vagrant-aws"
```
Use bundler to execute Vagrant:
```
$ bundle exec vagrant up --provider=aws
```

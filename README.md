# Packer Community Example Templates

[Packer Community](https://github.com/packer-community/packer-windows-plugins/) Templates for Windows environments.

## Running 

* Install [Packer](https://github.com/mitchellh/packer/) and [Packer Community](https://github.com/packer-community/packer-windows-plugins/)
* Clone this repo:

  ```
  git clone git@github.com:mefellows/packer-windows-templates.git && cd packer-community-templates
  ```

* Run Packer 
  This example runs only the OVF builder:

  ```
  packer build -only=virtualbox-windows-ovf winrm-vagrant-rsync.json
  ```

# Packer Community Example Templates

[Packer Community](https://github.com/packer-community/packer-windows-plugins/) Templates for Windows environments to test/showcase many of the Windows-specific Builders and Provisioners.

## Running 

* Install [Packer](https://github.com/mitchellh/packer/) and [Packer Community](https://github.com/packer-community/packer-windows-plugins/)
* Clone this repo:

  ```
  git clone git@github.com:mefellows/packer-windows-templates.git && cd packer-community-templates
  ```

* Run Packer 

  Run the ISO builder to produce a simple base box with VirtualBox guest additions and optionally Windows updates:

  ```
  packer build -only=virtualbox-windows-iso 2012r2_virtualbox.json
  ```

  Run the OVF builder to produce a simple base box with rsync and Seek DSC resources installed:
  

  ```
  packer build -only=virtualbox-windows-ovf 2012r2_virtualbox.json
  ```

## Sysprep

An example unattended sysprep file is automatically uploaded to `c:/Windows/Temp/Autounattend_sysprep.xml` which can be used in a provisioner to sysprep the machine. For example, 
you may replace the default `shutdown_command` in the OVF builder with the following: 

```
"shutdown_command": "c:/windows/system32/sysprep/sysprep.exe /generalize /oobe /quiet /shutdown /unattend:a:Autounattend_sysprep.xml",
```


NOTE: This currently impacts the rsync (SSH) capability.

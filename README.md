# Packer Community Example Templates

[Packer Community](https://github.com/packer-community/packer-windows-plugins/) Templates for Windows environments to test/showcase many of the Windows-specific Builders and Provisioners.

## Running 

* Install [Packer](https://github.com/mitchellh/packer/) and [Packer Community](https://github.com/packer-community/packer-windows-plugins/)
* Clone this repo:

  ```
  git clone git@github.com:mefellows/packer-windows-templates.git && cd packer-community-templates
  ```

* Run Packer 

  Common practice is to create intermediate boxes in [machine image pipelines](http://www.onegeek.com.au/articles/machine-factories-part1-vagrant), such as a 'Base' and 'Application' images. The examples below follow this pattern.

  ### Vagrant Boxes

  Run the ISO builder to produce a simple Base box with VirtualBox guest additions and optionally Windows updates (Uncomment the [relevant](/blob/master/answer_files/2012_r2/Autounattend.xml#L242-L265) lines in the Autounattend.xml files to enable this):

  ```
  packer build -only=virtualbox-windows-iso 2012r2-virtualbox.json
  ```

  Run the OVF builder to produce a simple base box with rsync and Seek DSC resources installed:
  

  ```
  packer build -only=virtualbox-windows-ovf 2012r2-virtualbox.json
  ```

  ### AWS Machines

  ```
  packer build --var base_ami=ami-ac3a1cc4 --var subnet_id=subnet-1234abcd--var vpc_id=vpc-4567defg ./amazon-sysprep.json
  ```


## Windows Updates

Use the `/answer_files/2012_r2/updates/Autounattend.xml` file as a replacement in the `floppy_files` configuration item.

## Sysprep

An example unattended sysprep file is automatically uploaded to `c:/Windows/Temp/Autounattend_sysprep.xml` which can be used in a provisioner to sysprep the machine. For example, you may replace the default `shutdown_command` in the OVF builder with the following:

```
"shutdown_command": "c:/windows/system32/sysprep/sysprep.exe /generalize /oobe /quiet /shutdown /unattend:c:/Windows/Temp/Autounattend_sysprep.xml",
"shutdown_timeout": "15m"
```

NOTE: This currently impacts the rsync (SSH) capability due to SIDs and such.

## Credits

Thanks to Joe's [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows) templates for the inspiration and basis for much of this work.
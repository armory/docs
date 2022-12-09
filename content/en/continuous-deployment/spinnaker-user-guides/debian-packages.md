---
title: Use Debian Packages with Spinnaker
title: Debian Packages
aliases:
  - /user-guides/debian-packages/
  - /user-guides/debian_packages/
  - /user_guides/debian-packages/
  - /user_guides/debian_packages/
  - /spinnaker_user_guides/debian_packages/
  - /spinnaker_user_guides/debian-packages/
  - /spinnaker-user-guides/debian_packages/
description: >
  Learn why you should use Debian packages in your Spinnaker pipelines.
---

## Why use Debian packages

While Spinnaker is flexible enough to use any dependency management system, it is predisposed to manage Debian packages due to its default settings with Rosco, Orca, and Jenkins.  

- Out-of-the-box settings for Spinnaker look for an archived package with a `.deb` suffix within Jenkins. Spinnaker also gets the version from the package and automatically appends it to the package name within Rosco. This makes it easy to specify your package in Rosco without the version number, `mycompany-app`. However, during the bake provisioning process Spinnaker installs the version that was specified by the Jenkins build: `mycompany-app.3.24.9-3`.  

- Debian packaging allows service teams to easily add their app specific configuration to common Packer templates. If you're using any Debian-based system (Ubuntu, DSL, Astra, etc), you'll likely be using Debian packages for your system configuration and dependency management. So it's a natural extension to use a Debian package for your own applications. Using Debian packages helps reduce the variations in Packer templates, or variables passed to Packer templates, during the bake process.


## Creating Debian packages

You can create a Debian package by using various open source packaging tools. If you're using Java, use the `OS Package` library. You can also use the [packaging tools provided by Debian](https://www.debian.org/doc/manuals/maint-guide/build.en.html).  

| Language | Tool | Package Types |
|---|---|---|
| Java    | [OS Package](https://github.com/nebula-plugins/gradle-ospackage-plugin)  | deb/rpm |
| Python  | [stdeb](https://pypi.python.org/pypi/stdeb/0.8.5) | deb |
| Node    | [node-deb](https://www.npmjs.com/package/node-deb) | deb |
| PHP     | [php-deb-packager](https://github.com/wdalmut/php-deb-packager) | deb |
| Any     | [pkgr](https://github.com/crohr/pkgr) | deb/rpm |
| Any     | [fpm](https://github.com/jordansissel/fpm/wiki) | deb/rpm/others |


### Example: Debian package with OSPackage Gradle plugin

Begin by creating a `build.gradle`.  You also need to create a `config/scripts/post-install.sh` file in your project directory.


Below is an example of what a Gradle file might look like for an app that builds a `war`. This uses the [gradle-ospackage-plugin](https://github.com/nebula-plugins/gradle-ospackage-plugin) package. Basic usage of the Deb Plugin in the [Deb Plugin docs](https://github.com/nebula-plugins/gradle-ospackage-plugin/wiki/Deb-Plugin).

```javascript
buildscript {
  repositories {
    jcenter()
    maven { url "https://plugins.gradle.org/m2/" }
  }
  dependencies {
       classpath 'com.netflix.nebula:gradle-ospackage-plugin:8.5.6'
   }
}

apply plugin: 'nebula.ospackage'

ospackage {
  packageName = "mycompanyname-service"
  version = "1.10.3"

  requires('nginx')

  postInstall file('config/scripts/post-install.sh')

  from('build/application.war') {
    into '/opt/application/'
  }
}
```

Then build your Debian package based on your Gradle build file:

```bash
gradle buildDeb
```

If the build succeeds then you should find a Debian package in the following path:

```bash
./build/distributions/mycompanyname-service.1.10.3_all.deb
```

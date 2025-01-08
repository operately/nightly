# Operately Nightly Builds

[![Build Status](https://operately.semaphoreci.com/badges/nightly/branches/master.svg?style=shields)](https://operately.semaphoreci.com/projects/nightly)

This repository contains the scripts and configurations to generate nightly builds for Operately.
The nightly builds are generated every morning at 07:00 UTC, and are available for download as
[releases in this repository](https://github.com/operately/nightly/releases).

Apart from the nightly builds, the builds are also generated for
[every passed pipeline](https://operately.semaphoreci.com/branches/eef1dbd0-8066-4f8b-b874-380ba75b091b)
run on the `main` branch of the [Operately repository](https://github.com/operately/operately).

## How to use the nightly builds

The nightly builds are available as GitHub releases in this repository. You can follow the
[single-host installation guide](https://github.com/operately/operately/blob/main/docs/installation/single-host.md) to install
the nightly builds, but instead of downloading the latest stable release, replace the url with the
latest nightly build release.

#### Download the latest nightly build

```bash
wget -q https://github.com/operately/nightly/releases/latest/download/operately-single-host.tar.gz
tar -xf operately-single-host.tar.gz
cd operately
```

#### Run the installation script

```bash
./install.sh
```

#### Start the Operately services

```bash
docker compose up --wait --detach
```

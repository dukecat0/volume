# volume

Adjust the volume from the command line on macOS.

## Installation

Using [Homebrew](https://brew.sh):
```shell
brew tap meowmeowmeowcat/taps
brew install meowmeowmeowcat/taps/volume
```

Using [Mint](https://github.com/yonaskolb/Mint):
```shell
mint install meowmeowmeowcat/volume@v0.0.1
```

## Usage

```shell
USAGE: volume [--input] [--alert] [--all] <up|down|value>

ARGUMENTS:
  <up|down|value>         Use up or down to increase or decrease the volume.
                          Input a value(0-100) to adjuct the volume.
                          Default to output volume.

OPTIONS:
  -i, --input             Set input volume.
  -a, --alert             Set alert volume.
  --all                   Set all volumes to the same level.
                          \(blue)Including output, input and alert volume.\(reset)
  --version               Show the version.
  -h, --help              Show help information.
```

## Example

Increase the output volume:

```shell
$ volume up
```

Decrease the output volume:

```shell
$ volume down
```

Set the output volume to 10:

```shell
$ volume 10
```

Set the input volume to 60:

```shell
$ volume --input 60
```

Set the alert volume to 100:

```shell
$ volume --alert 100
```

Set all volume(including output, input and alert volume) to 50:

```shell
$ volume --all 50
```

If you want to adjust the volume from the command line faster, using `alias` would be a good choice:

```shell
$ alias vol="volume"
```

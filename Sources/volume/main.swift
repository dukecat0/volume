import Foundation

let blue = "\u{001B}[0;34m"
let red = "\u{001B}[0;31m"
let reset = "\u{001B}[0;0m"

let argument = Array(CommandLine.arguments.dropFirst(1))
let version = "0.0.1"
let help_msg = """
OVERVIEW: Adjust the volume from the terminal.

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
"""

func isStringAnInt(_ string: String) -> Bool {
    return Int(string) != nil
}

if CommandLine.arguments.count < 1 {
    print("\(red)Not enough arguments! See --help for more info.\(reset)")
    exit(1)
} else if CommandLine.arguments.count == 1 {
    print(help_msg)
    exit(0)
}

var type: String = ""
var arg: String = ""
var error: NSDictionary?

if CommandLine.arguments.count == 2 && argument.first == "--input" || argument.first == "-i" {
    print("\(red)Incorrect arguments! Maybe --input <number>? See --help for more info.\(reset)")
    exit(1)
} else if CommandLine.arguments.count == 2 && argument.first == "--alert" || argument.first == "-a" {
    print("\(red)Incorrect arguments! Maybe --alert <number>? See --help for more info.\(reset)")
    exit(1)
} else if CommandLine.arguments.count == 2 && argument.first == "--all" {
    print("\(red)Incorrect arguments! Maybe --all <number>? See --help for more info.\(reset)")
    exit(1)
}

switch argument.first {
    case "--version",
         "-v":
        print(version)
        exit(0)
    case "--help",
        "-h":
        print(help_msg)
        exit(0)
    case "--input",
         "-i":
        type = "input"
        arg = argument[1]
    case "--alert",
         "-a":
        type = "alert"
        arg = argument[1]
    case "--all":
        type = "all"
        arg = argument[1]
    case "up":
        type = "up"
        arg = "0"
    case "down":
        type = "down"
        arg = "0"
    default:
        type = "output"
        arg = argument[0]
}

if !isStringAnInt(arg) {
    print("\(red)Incorrect arguments! See --help for more info.\(reset)")
    exit(1)
}

var script = "set volume \(type) volume \(arg)"

if type == "all" {
    script = """
        set volume output volume \(arg)
        set volume input volume \(arg)
        set volume alert volume \(arg)
        """
} else if type == "up" {
    script = """
        set Outputvol to output volume of (get volume settings)
        set volume output volume (Outputvol + 6.25)
        """
} else if type == "down" {
    script = """
    set Outputvol to output volume of (get volume settings)
    set volume output volume (Outputvol - 6.25)
    """
}

var normal_msg: String = "\(blue)Your \(type) volume is \(arg) now.\(reset)"
let increased_msg: String = "Your volume has been increased!"
let decreased_msg: String = "Your volume has been decreased!"

func run(_ source: String) {
    if let scriptObject = NSAppleScript(source: source) {
        scriptObject.executeAndReturnError(&error)
        if (error != nil) {
            print("\(red)Error: \(String(describing: error)))\(reset)")
        } else {
            if type != "up" && type != "down" {
                print(normal_msg)
            } else if type == "up" {
                print(increased_msg)
            } else if type == "down" {
                print(decreased_msg)
            }
        }
    }
}

run(script)

import Foundation

let blue = "\u{001B}[0;34m"
let red = "\u{001B}[0;31m"
let reset = "\u{001B}[0;0m"

let argument = Array(CommandLine.arguments.dropFirst(1))
let version = "0.0.1"
let help_msg = """
OVERVIEW: Adjust the volume from the terminal.

USAGE: volume <number> [--input] [--alert] [--all]

ARGUMENTS:
  <number>                Input a number(0-100) to adjuct the volume.
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
    case "--help",
        "-h":
        print(help_msg)
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
    default:
        type = "output"
        arg = argument[0]
}

if type == "" {
    exit(1)
} else if !isStringAnInt(arg) {
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
}

var error: NSDictionary?

func run(_ source: String) {
    if let scriptObject = NSAppleScript(source: source) {
        scriptObject.executeAndReturnError(&error)
        if (error != nil) {
            print("\(red)Error: \(String(describing: error)))\(reset)")
        } else {
            print("\(blue)Your \(type) volume is \(arg) now.\(reset)")
        }
    }
}

run(script)

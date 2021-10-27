import Foundation
import ArgumentParser

let blue = "\u{001B}[0;34m"
let red = "\u{001B}[0;31m"
let reset = "\u{001B}[0;0m"

struct Volume: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Adjust the volume from the terminal.",
        version: "0.0.1"
    )
    @Argument(help: "Input a number(0-100) to adjuct the volume.\nDefault to output volume.")
    var number: String

    @Flag(name: .shortAndLong, help: "Set input volume.")
    var input = false

    @Flag(name: .shortAndLong, help: "Set alert volume.")
    var alert = false

    @Flag(name: [.customLong("all")], 
    help: "Set all volumes to the same level.\n\(blue)Including output, input and alert volume.\(reset)")
    var all = false

}

let option = Volume.parseOrExit()
var type: String

if option.input {
    type = "input"
} else if option.alert {
    type = "alert"
} else if option.all {
    type = "all"
} else {
    type = "output"
}

var script = "set volume \(type) volume \(option.number)"

if type == "all" {
    script = """
        set volume output volume \(option.number)
        set volume input volume \(option.number)
        set volume alert volume \(option.number)
    """
}

var error: NSDictionary?

func run(_ source: String) {
    if let scriptObject = NSAppleScript(source: source) {
        scriptObject.executeAndReturnError(&error)
        if (error != nil) {
            print("\(red)Error: \(String(describing: error)))\(reset)")
        } else {
            print("\(blue)Your \(type) volume is \(option.number) now.\(reset)")
        }
    }
}

run(script)

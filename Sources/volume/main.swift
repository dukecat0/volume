import Foundation
import ArgumentParser

struct Volume: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Adjust the volume from the terminal.",
        version: "0.0.1"
    )
    @Argument(help: "Input a number(0-100) to adjuct the volume.\nDefault to output volume.")
    var option: String

    @Flag(help: "Set input volume.")
    var input = false

    @Flag(help: "Set alert volume.")
    var alert = false

}

let blue = "\u{001B}[0;34m"
let red = "\u{001B}[0;31m"

let option = Volume.parseOrExit()
var type: String

if option.input {
    type = "input"
} else if option.alert {
    type = "alert"
} else {
    type = "output"
}

let script = "set volume \(type) volume \(option.option)"

var error: NSDictionary?

func run(_ source: String) {
    if let scriptObject = NSAppleScript(source: source) {
        scriptObject.executeAndReturnError(&error)
        if (error != nil) {
            print("\(red)Error: \(String(describing: error)))")
        } else {
            print("\(blue)Your \(type) volume is \(option.option) now.")
        }
    }
}

run(script)

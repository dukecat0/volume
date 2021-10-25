import Foundation
import ArgumentParser

struct Volume: ParsableArguments {
    @Argument(help: "Input a number(0-100) to adjuct the volume.")
    var number: String
}

let option = Volume.parseOrExit()

let script = "set volume output volume \(option.number)"

func run(_ source: String) {
    if let scriptObject = NSAppleScript(source: source) {
        scriptObject.executeAndReturnError(nil)
    }
}

run(script)

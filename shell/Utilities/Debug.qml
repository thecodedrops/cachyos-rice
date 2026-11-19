pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property bool _DEBUG_MODE_: Quickshell.env("DEBUG") === "1"

    function log(ctx, ...args) {
        if (!_DEBUG_MODE_) return;

        const ctxarray = [(new Date()).toTimeString().slice(0, 5), ...ctx]
        const ctxhead = ctxarray.map(item => `[${item}]`).join('');

        const formattedArgs = args.map(arg => {
            if (typeof arg === "object" && arg !== null) {
                try {
                    return JSON.stringify(arg, null, 2);
                } catch (e) {
                    return arg; // Fallback if circular references exist
                }
            }
            return arg;
        });

        console.log(ctxhead, "::", ...formattedArgs);
    }

    function uri(target) {
        if (!target || typeof target !== "string") return "";

        // 1. Expand leading tilde (~) to $HOME
        if (target.startsWith("~")) {
            let home = Quickshell.env("HOME") || "";
            target = home + target.substring(1);
        }

        // 2. Expand environment variables like $VAR or ${VAR}
        return target.replace(/\$\{?([a-zA-Z_][a-zA-Z0-9_]*)\}?/g, function (match, varName) {
            let envVal = Quickshell.env(varName);
            return envVal !== undefined && envVal !== null ? envVal : match;
        });
    }
}
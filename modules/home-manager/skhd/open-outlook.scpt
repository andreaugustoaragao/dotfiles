#!/usr/bin/osascript

tell application "System Events"
    set appList to name of every application process
    if "Microsoft Outlook" is not in appList then
        tell application "Microsoft Outlook"
            activate
        end tell
    else
        tell application "Microsoft Outlook"
            activate
            tell application "System Events"
                if (value of attribute "AXMinimized" of window 1 of process "Microsoft Outlook") is true then
                  set frontmost to true
                else
                    keystroke "`" using {command down}
                end if
            end tell
        end tell
    end if
end tell

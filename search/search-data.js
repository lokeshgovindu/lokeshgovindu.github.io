/* Site-wide search index — consumed by /search/index.html via Fuse.js */
const SITE_SEARCH_DATA = [

  // ═══════════════════════════════════════════════════════════
  //  VISUAL STUDIO — Extensions
  // ═══════════════════════════════════════════════════════════
  { title: "Align Assignments", section: "Visual Studio", category: "Extension",
    content: "Automatically aligns variable assignments and declarations across multiple lines for cleaner, more readable code.",
    tags: ["align", "format", "assignments", "code style"], url: "/visual-studio/#ext-align" },

  { title: "Customize VS Window Title", section: "Visual Studio", category: "Extension",
    content: "Replace the default Visual Studio title bar with a custom template showing solution name, Git branch, active configuration, and more.",
    tags: ["title bar", "window title", "customize", "branch", "solution"], url: "/visual-studio/#ext-window-title" },

  { title: "Dependency Graph", section: "Visual Studio", category: "Extension",
    content: "Visualise project and file dependencies as an interactive graph. Identify circular dependencies and understand the architecture at a glance.",
    tags: ["dependency", "graph", "visualization", "architecture", "circular"], url: "/visual-studio/#ext-dependency-graph" },

  { title: "GitBlame", section: "Visual Studio", category: "Extension",
    content: "Inline git blame annotations show who last modified each line and when, directly in the editor margin. No switching to a separate window.",
    tags: ["git", "blame", "annotation", "author", "version control"], url: "/visual-studio/#ext-gitblame" },

  { title: "IntelliCommand", section: "Visual Studio", category: "Extension",
    content: "Shows a popup listing keyboard shortcuts for every command you execute, helping you learn and memorize Visual Studio shortcuts over time.",
    tags: ["shortcuts", "keyboard", "learn", "commands", "intellicommand"], url: "/visual-studio/#ext-intellicommand" },

  { title: "Presentation Assistant", section: "Visual Studio", category: "Extension",
    content: "Displays the name and shortcut of every command you execute in an on-screen overlay — perfect for demos, screen recordings, and pair programming.",
    tags: ["presentation", "demo", "screencast", "shortcut display", "overlay"], url: "/visual-studio/#ext-presentation-assistant" },

  { title: "Visual Commander", section: "Visual Studio", category: "Extension",
    content: "Add custom commands and macros to Visual Studio using C# or VB.NET scripts. Automate repetitive tasks without writing a full extension.",
    tags: ["macro", "automation", "script", "command", "vcmd"], url: "/visual-studio/#ext-visual-commander" },

  { title: "VSColorOutput64", section: "Visual Studio", category: "Extension",
    content: "Color-codes the Output window by message type — errors in red, warnings in yellow, success in green — making long build logs easy to scan.",
    tags: ["color", "output window", "build log", "errors", "warnings"], url: "/visual-studio/#ext-vscoloroutput" },

  { title: "VSDoxyHighlighter", section: "Visual Studio", category: "Extension",
    content: "Syntax highlighting for Doxygen documentation comments in C, C++, and C# files. Makes @param, @return and other tags visually distinct.",
    tags: ["doxygen", "documentation", "highlight", "comments", "c++", "c#"], url: "/visual-studio/#ext-vsdoxy" },

  { title: "Entrian Inline Watch", section: "Visual Studio", category: "Extension",
    content: "Shows variable values inline in the editor during debugging — like a permanent Watch window built into the code view itself.",
    tags: ["debug", "watch", "variable", "inline", "debugger"], url: "/visual-studio/#ext-entrian" },

  // ═══════════════════════════════════════════════════════════
  //  VISUAL STUDIO — Keyboard Shortcuts
  // ═══════════════════════════════════════════════════════════
  { title: "Go to Definition / Peek Definition", section: "Visual Studio", category: "Shortcut",
    content: "F12 — go to definition. Alt+F12 — peek definition inline without leaving current file. Ctrl+F12 — go to implementation.",
    tags: ["F12", "definition", "navigate", "peek", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Find All References", section: "Visual Studio", category: "Shortcut",
    content: "Shift+F12 — find all places a symbol is referenced across the entire solution.",
    tags: ["references", "find", "Shift+F12", "symbol", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Quick Find & Replace", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+F — find in file. Ctrl+H — find and replace. Ctrl+Shift+F — find in all files. Ctrl+Shift+H — replace in all files.",
    tags: ["find", "replace", "search", "Ctrl+F", "Ctrl+H", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Navigate Backward / Forward", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+- (minus) to navigate to the previous location. Ctrl+Shift+- to go forward. Essential for jumping around a large codebase.",
    tags: ["navigate", "back", "forward", "history", "Ctrl+-", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Go to Any File or Symbol", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+, (comma) opens the 'Go To All' dialog. Type a file name, class, method, or member to jump anywhere in the solution instantly.",
    tags: ["go to", "navigate", "Ctrl+comma", "file", "class", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Comment / Uncomment Code", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+K, Ctrl+C — comment selected lines. Ctrl+K, Ctrl+U — uncomment selected lines.",
    tags: ["comment", "uncomment", "Ctrl+K", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Format Document / Selection", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+K, Ctrl+D — format the entire document. Ctrl+K, Ctrl+F — format only the selected code.",
    tags: ["format", "indent", "beautify", "Ctrl+K Ctrl+D", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Start / Stop Debugging", section: "Visual Studio", category: "Shortcut",
    content: "F5 — start with debugger. Shift+F5 — stop debugging. Ctrl+F5 — run without debugger.",
    tags: ["debug", "run", "F5", "start", "stop", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Breakpoints", section: "Visual Studio", category: "Shortcut",
    content: "F9 — toggle breakpoint on current line. Ctrl+Shift+F9 — delete all breakpoints. F10 — step over. F11 — step into. Shift+F11 — step out.",
    tags: ["breakpoint", "debug", "F9", "step over", "step into", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Quick Actions & Refactoring", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+. (period) — show quick actions, code fixes, and refactoring suggestions for the symbol under the cursor.",
    tags: ["refactor", "quick actions", "Ctrl+.", "lightbulb", "fix", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "Build Solution", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+Shift+B — build the entire solution. Ctrl+Break — cancel current build.",
    tags: ["build", "compile", "Ctrl+Shift+B", "solution", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  { title: "IntelliSense / Auto-complete", section: "Visual Studio", category: "Shortcut",
    content: "Ctrl+Space — trigger IntelliSense / auto-complete manually. Ctrl+Shift+Space — show parameter info for the current method call.",
    tags: ["intellisense", "autocomplete", "Ctrl+Space", "parameters", "shortcut"], url: "/visual-studio/#keyboard-shortcuts" },

  // ═══════════════════════════════════════════════════════════
  //  CMD PROMPT — Built-in Commands
  // ═══════════════════════════════════════════════════════════
  { title: "DIR — List Directory", section: "CMD Prompt", category: "Command",
    content: "List directory contents. DIR /S recurses subdirectories, /B gives bare names, /O:N sorts by name, /O:S by size, /A:H shows hidden files.",
    tags: ["dir", "list", "directory", "files", "cmd"], url: "/cmd-prompt/" },

  { title: "FINDSTR — Search Text in Files", section: "CMD Prompt", category: "Command",
    content: "Search for text in files with regular expression support. FINDSTR /S searches subdirectories, /I is case-insensitive, /N shows line numbers.",
    tags: ["findstr", "find", "search", "text", "regex", "grep", "cmd"], url: "/cmd-prompt/" },

  { title: "TASKLIST / TASKKILL", section: "CMD Prompt", category: "Command",
    content: "TASKLIST lists all running processes. TASKKILL /IM name.exe terminates by name, /PID number by process ID, /F forces termination.",
    tags: ["process", "kill", "task", "tasklist", "taskkill", "pid", "cmd"], url: "/cmd-prompt/" },

  { title: "ROBOCOPY — Robust File Copy", section: "CMD Prompt", category: "Command",
    content: "Mirror directories, retry failed copies, log results. Use /MIR to mirror, /R:3 to retry 3 times, /LOG:file.txt to log output.",
    tags: ["copy", "backup", "sync", "robocopy", "mirror", "cmd"], url: "/cmd-prompt/" },

  { title: "IPCONFIG — Network Configuration", section: "CMD Prompt", category: "Command",
    content: "Show IP addresses for all adapters. /all shows DNS, MAC, DHCP details. /flushdns clears the DNS resolver cache.",
    tags: ["network", "ip", "ipconfig", "dns", "mac", "dhcp", "cmd"], url: "/cmd-prompt/" },

  { title: "NETSTAT — Network Connections", section: "CMD Prompt", category: "Command",
    content: "Show active TCP/UDP connections and listening ports. -ano adds PIDs to identify which process owns a port. -b shows the executable.",
    tags: ["network", "ports", "connections", "netstat", "tcp", "udp", "cmd"], url: "/cmd-prompt/" },

  { title: "WMIC — System Information", section: "CMD Prompt", category: "Command",
    content: "Query hardware and OS info. wmic cpu get name, wmic memorychip get capacity, wmic logicaldisk get size,freespace.",
    tags: ["wmic", "system", "hardware", "cpu", "memory", "disk", "cmd"], url: "/cmd-prompt/" },

  { title: "SET / SETX — Environment Variables", section: "CMD Prompt", category: "Command",
    content: "SET VAR=value sets a variable for the current session. SETX VAR value persists it permanently. SETX /M sets a system-wide variable.",
    tags: ["environment", "variables", "set", "setx", "path", "cmd"], url: "/cmd-prompt/" },

  // ═══════════════════════════════════════════════════════════
  //  CMD PROMPT — Tools
  // ═══════════════════════════════════════════════════════════
  { title: "Cmder", section: "CMD Prompt", category: "Tool",
    content: "Portable console emulator for Windows built on ConEmu + Clink. Multi-tab terminal with Monokai theme, Git for Windows, Unix commands, aliases, and custom tasks.",
    tags: ["cmder", "terminal", "console", "tabs", "portable", "conemu"], url: "/cmd-prompt/#cmder" },

  { title: "Clink — GNU Readline for CMD", section: "CMD Prompt", category: "Tool",
    content: "Injects GNU Readline into cmd.exe. Adds inline auto-suggestions, persistent history (F7), rich Tab completion, directory shortcuts, context-aware sub-command listing, and Lua scripting. Bundled in Cmder.",
    tags: ["clink", "autocomplete", "readline", "history", "completion", "tab", "cmd"], url: "/cmd-prompt/#clink" },

  { title: "Oh My Posh — Prompt Theme Engine", section: "CMD Prompt", category: "Tool",
    content: "Blazing-fast prompt engine for any shell. Displays Git branch, ahead/behind count, staged/modified/untracked files, language versions, and more in a beautiful colored prompt. Works in CMD, PowerShell, Bash, and more.",
    tags: ["oh my posh", "prompt", "theme", "git", "terminal", "powershell", "bash"], url: "/cmd-prompt/#oh-my-posh" },

  // ═══════════════════════════════════════════════════════════
  //  WINDOWS — Power Tools
  // ═══════════════════════════════════════════════════════════
  { title: "Microsoft PowerToys", section: "Windows", category: "Tool",
    content: "Free open-source utility suite from Microsoft. FancyZones, PowerToys Run (Alt+Space), Color Picker, File Locksmith, Image Resizer, PowerRename, Text Extractor, Peek, Keyboard Manager, Mouse utilities and more.",
    tags: ["powertoys", "microsoft", "utilities", "productivity", "fancyzones", "windows"], url: "/windows/#powertoys" },

  { title: "FancyZones — Custom Window Snap", section: "Windows", category: "Tool",
    content: "Define custom window snap zones beyond Windows' default corners. Drag windows while holding Shift to snap into your custom grid layouts. Part of PowerToys.",
    tags: ["fancy zones", "snap", "window layout", "grid", "powertoys", "windows"], url: "/windows/#powertoys" },

  { title: "PowerToys Run — Quick Launcher", section: "Windows", category: "Tool",
    content: "Alt+Space opens a fast launcher to find apps, files, URLs, and evaluate calculations — like macOS Spotlight, built into Windows. Part of PowerToys.",
    tags: ["launcher", "alt+space", "spotlight", "quick launch", "search", "powertoys"], url: "/windows/#powertoys" },

  { title: "Color Picker (PowerToys)", section: "Windows", category: "Tool",
    content: "Win+Shift+C — pick any color on screen and instantly copy its HEX, RGB, or HSL value to the clipboard. Part of PowerToys.",
    tags: ["color picker", "hex", "rgb", "hsl", "design", "powertoys"], url: "/windows/#powertoys" },

  { title: "PowerRename", section: "Windows", category: "Tool",
    content: "Bulk rename files using regular expressions directly from the right-click context menu. Live preview shows changes before committing. Part of PowerToys.",
    tags: ["rename", "batch rename", "regex", "files", "bulk", "powertoys"], url: "/windows/#powertoys" },

  { title: "Text Extractor (PowerToys)", section: "Windows", category: "Tool",
    content: "Win+Shift+T — OCR any region of your screen and copy the extracted text to the clipboard. Supports multiple languages. Part of PowerToys.",
    tags: ["ocr", "text extractor", "screenshot text", "copy text", "powertoys"], url: "/windows/#powertoys" },

  { title: "Sysinternals Suite", section: "Windows", category: "Tool",
    content: "Advanced Windows system utilities from Microsoft. Process Explorer, Process Monitor, Autoruns, TCPView, PsExec, BgInfo. Run live from \\\\live.sysinternals.com\\tools without installing.",
    tags: ["sysinternals", "process explorer", "process monitor", "autoruns", "tcpview", "microsoft"], url: "/windows/#sysinternals" },

  { title: "Process Explorer (Sysinternals)", section: "Windows", category: "Tool",
    content: "Advanced task manager showing parent-child process trees, loaded DLLs, open handles, and GPU/disk/network usage per process. Replace Task Manager entirely.",
    tags: ["process explorer", "task manager", "processes", "dll", "handles", "sysinternals"], url: "/windows/#sysinternals" },

  { title: "Process Monitor (Sysinternals)", section: "Windows", category: "Tool",
    content: "Real-time logging of every file system, registry, and network call made by every process. Indispensable for diagnosing mysterious Windows issues.",
    tags: ["process monitor", "registry", "file system", "network", "monitoring", "sysinternals"], url: "/windows/#sysinternals" },

  { title: "Autoruns (Sysinternals)", section: "Windows", category: "Tool",
    content: "Shows everything configured to auto-start with Windows — registry run keys, services, scheduled tasks, browser extensions. Disable or delete unwanted startup entries.",
    tags: ["autoruns", "startup", "autostart", "services", "scheduled tasks", "sysinternals"], url: "/windows/#sysinternals" },

  { title: "SystemInformer (Process Hacker)", section: "Windows", category: "Tool",
    content: "Formerly Process Hacker. Advanced open-source task manager with process tree, per-process CPU/memory/disk/network graphs, DLL and handle inspector, memory map viewer, and service management.",
    tags: ["systeminformer", "process hacker", "task manager", "performance", "monitoring", "open source"], url: "/windows/#systeminformer" },

  // ═══════════════════════════════════════════════════════════
  //  WINDOWS — File Explorer Alternatives
  // ═══════════════════════════════════════════════════════════
  { title: "xplorer2 — Dual-Pane File Manager", section: "Windows", category: "Tool",
    content: "Battle-tested dual-pane tabbed file manager with rich metadata columns, viewer pane, bookmarks, and fully keyboard-driven workflow. Lite edition is free.",
    tags: ["file manager", "dual pane", "xplorer2", "explorer alternative", "tabs"], url: "/windows/#file-explorers" },

  { title: "XYplorer — Portable File Manager", section: "Windows", category: "Tool",
    content: "Fully portable dual-pane file manager with built-in scripting engine, color and visual filters, multi-rename, and breadcrumb mini-tree. No installation needed.",
    tags: ["file manager", "dual pane", "xyplorer", "portable", "scripting", "explorer alternative"], url: "/windows/#file-explorers" },

  { title: "OneCommander — Modern File Manager", section: "Windows", category: "Tool",
    content: "Modern file manager with multi-pane column view, tab groups, file tagging, dark mode, and OneDrive/cloud integration. Free with optional Pro upgrade.",
    tags: ["file manager", "onecommander", "modern", "tabs", "cloud", "explorer alternative"], url: "/windows/#file-explorers" },

  { title: "Files App — Open Source Explorer", section: "Windows", category: "Tool",
    content: "Open-source modern replacement for Windows Explorer with fluent design, native tabs, dual pane, tags, archive support, and Git status in the UI.",
    tags: ["files app", "file manager", "open source", "tabs", "explorer alternative"], url: "/windows/#file-explorers" },

  // ═══════════════════════════════════════════════════════════
  //  WINDOWS — Screenshot Tools
  // ═══════════════════════════════════════════════════════════
  { title: "ShareX — Feature-Rich Screenshot Tool", section: "Windows", category: "Tool",
    content: "Free open-source screenshot powerhouse. Region, scrolling, or full-screen capture; annotation; screen recording; GIF creation; auto-upload to 80+ services. Also includes OCR and color picker.",
    tags: ["screenshot", "screen capture", "record", "gif", "sharex", "open source", "upload"], url: "/windows/#screenshot-tools" },

  { title: "Screenpresso — Screen Capture & Recording", section: "Windows", category: "Tool",
    content: "Lightweight freemium screenshot tool with built-in media library, scrolling capture, webcam overlay, and screen recording with audio.",
    tags: ["screenshot", "screenpresso", "recording", "scrolling capture", "video"], url: "/windows/#screenshot-tools" },

  { title: "Greenshot — Lightweight Screenshot", section: "Windows", category: "Tool",
    content: "Free open-source screenshot tool. Integrates with PrintScreen key, annotates, and exports directly to email, Office apps, a printer, or cloud. Very low resource usage.",
    tags: ["screenshot", "greenshot", "open source", "printscreen", "lightweight", "annotation"], url: "/windows/#screenshot-tools" },

  // ═══════════════════════════════════════════════════════════
  //  WINDOWS — Video & Media
  // ═══════════════════════════════════════════════════════════
  { title: "yt-dlp — Download YouTube Videos", section: "Windows", category: "Tool",
    content: "Download videos, audio, and full playlists from YouTube and 1,000+ other sites. Supports best-quality auto-merge, audio-only MP3, subtitles, SponsorBlock, and download speed limiting.",
    tags: ["youtube", "download", "video", "playlist", "mp3", "yt-dlp", "audio"], url: "/windows/#yt-dlp" },

  { title: "FFmpeg — Video Processing", section: "Windows", category: "Tool",
    content: "Swiss Army knife of video and audio processing. Convert formats, compress, trim, extract audio, merge streams, create animated GIFs. Used behind the scenes by yt-dlp.",
    tags: ["ffmpeg", "video", "convert", "compress", "trim", "audio", "gif", "media"], url: "/windows/#ffmpeg" },

  // ═══════════════════════════════════════════════════════════
  //  WINDOWS — Tips & Tricks
  // ═══════════════════════════════════════════════════════════
  { title: "Run Dialog Inline Autocomplete", section: "Windows", category: "Tip",
    content: "Enable inline autocomplete in the Win+R Run dialog: open Folder Options → General tab → check 'Use inline AutoComplete in File Explorer and Run dialog box'.",
    tags: ["run dialog", "autocomplete", "win+r", "folder options", "tip"], url: "/windows/#windows-tips" },

  { title: "Clipboard History (Win+V)", section: "Windows", category: "Tip",
    content: "Win+V opens a scrollable history of your last 25 clipboard items. Must first enable in Settings → System → Clipboard → Clipboard history. Pin important items to keep them across reboots.",
    tags: ["clipboard", "history", "win+v", "copy paste", "tip"], url: "/windows/#windows-tips" },

  { title: "Virtual Desktops", section: "Windows", category: "Tip",
    content: "Win+Ctrl+D creates a new virtual desktop. Win+Ctrl+← / → switches between them. Win+Tab opens Task View to manage all desktops. Separate work, personal, and project contexts.",
    tags: ["virtual desktop", "multiple desktops", "win+ctrl+d", "task view", "tip"], url: "/windows/#windows-tips" },

  { title: "God Mode Folder", section: "Windows", category: "Tip",
    content: "Create a folder named exactly GodMode.{ED7BA470-8E54-465E-825C-99712043E01C} to get one-place access to all 200+ Windows Control Panel settings.",
    tags: ["god mode", "control panel", "settings", "hidden", "tip"], url: "/windows/#windows-tips" },

  { title: "Win+X Power User Menu", section: "Windows", category: "Tip",
    content: "Win+X opens a quick-access power user menu with links to Device Manager, Disk Management, Event Viewer, Task Manager, Terminal (Admin), and more.",
    tags: ["win+x", "power user", "device manager", "admin", "tip"], url: "/windows/#windows-tips" },

  { title: "Emoji Picker (Win + .)", section: "Windows", category: "Tip",
    content: "Win+. or Win+; opens the emoji picker in any text field, system-wide. Also provides kaomoji, symbols, and GIFs.",
    tags: ["emoji", "win+.", "emoticon", "symbols", "gifs", "tip"], url: "/windows/#windows-tips" },

  { title: "Environment Variables Shortcut", section: "Windows", category: "Tip",
    content: "Open Environment Variables instantly: Win+R → type sysdm.cpl → Advanced tab → Environment Variables. Or search 'env' in the Start menu.",
    tags: ["environment variables", "path", "sysdm.cpl", "system properties", "tip"], url: "/windows/#windows-tips" },

  { title: "Open Task Manager Directly", section: "Windows", category: "Tip",
    content: "Ctrl+Shift+Esc opens Task Manager immediately, skipping the Ctrl+Alt+Del screen. Use the Startup tab to manage apps that auto-launch with Windows.",
    tags: ["task manager", "ctrl+shift+esc", "startup", "processes", "tip"], url: "/windows/#windows-tips" },

  // ═══════════════════════════════════════════════════════════
  //  ABOUT ME — Contact
  // ═══════════════════════════════════════════════════════════
  { title: "Contact — Lokesh Govindu", section: "About Me", category: "Contact",
    content: "Get in touch via email at lokeshgovindu@gmail.com, GitHub at github.com/lokeshgovindu, or LinkedIn at linkedin.com/in/lokeshgovindu.",
    tags: ["contact", "email", "github", "linkedin", "get in touch", "about"], url: "/about-me/#contact" },

  { title: "LinkedIn Profile", section: "About Me", category: "Contact",
    content: "Connect with Lokesh Govindu professionally on LinkedIn at linkedin.com/in/lokeshgovindu.",
    tags: ["linkedin", "profile", "connect", "professional", "social", "contact"], url: "/about-me/#contact" },

  { title: "GitHub Profile", section: "About Me", category: "Contact",
    content: "Browse repositories and open-source projects by Lokesh Govindu on GitHub at github.com/lokeshgovindu.",
    tags: ["github", "repositories", "open source", "code", "projects", "contact"], url: "/about-me/#contact" },

];







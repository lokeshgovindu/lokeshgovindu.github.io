<!-- Generated from docs/help/settings-reference.html by tools/generate-markdown-help.py. Do not edit. -->

[Manual index](README.md)

# Settings reference

**Every setting by the name it has in the file, with its default. For reading the JSON, or editing it by hand.**

[Settings](settings.md) is the page that shows the dialog tab by tab and explains the choices worth thinking about. **This page is the lookup table**: it exists for the moment you have `PasteJump.json` open and want to know what a key is called or what it was before you changed it.

## Where the file is

`PasteJump.json`, in the `data` folder beside `PasteJump.exe` — or wherever you have moved the data location, under **Settings, System**. [Clips and history](stores.md) covers the folder's other contents.

> **Note**
>
> **PasteJump reads the file at start-up and writes it on OK or Apply.** So edit it while PasteJump is not running, or your change will be overwritten the next time the dialog saves. A value it cannot parse is replaced with the default rather than rejected, and a key it does not recognise is ignored and left alone — so an old file from a newer version keeps its unknown keys rather than losing them.

> **Note**
>
> **Anything missing from the file takes its default**, which is what the table below lists. Deleting a key is therefore the way to reset one setting, and deleting the whole file resets everything.

**71 settings**, grouped by the tab of the Settings dialog each one appears on, and in the dialog's own order.

## Capture

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`MaxClips`** | int | `200` | Maximum clips kept in the working stack. |
| **`LimitMaxClips`** | bool | `true` | Whether MaxClips is enforced at all. |
| **`MonitorClipboard`** | bool | `true` | Watch the clipboard at all. |
| **`AllowDuplicateClips`** | bool | *type default* | Record an identical copy as a new clip rather than promoting the existing one. |
| **`StoreImages`** | bool | `true` | Store images from the clipboard. |

## History

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`HistoryRetentionDays`** | int | `180` | Days of history to keep. |
| **`RecordHistory`** | bool | `true` | Write captured clips to the long-term history archive as well as the stack. |
| **`PreviewMaxChars`** | int | `4096` | Characters of text kept in a clip's or history entry's `preview` column. |
| **`HistoryLoadLimit`** | int | `50000` | Most rows the history window will load at once. |
| **`HistoryPreviewMaxWidth`** | int | `640` | Widest an image is decoded for the history window's preview pane, in pixels. |
| **`ClipJoinSeparator`** | string | *computed* | What goes between clips when several are copied as one. |
| **`GridDensity`** | GridDensity | `Cozy` | Row spacing in the history list. |
| **`LegacyImportCompleted`** | bool | *type default* | Whether the legacy Clipjump import has already run, so it is not offered twice. |

## Paste Mode

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`PreserveClipPosition`** | bool | `true` | Reopen on the previously active clip. |
| **`OpenSearchImmediately`** | bool | *type default* | Open directly into search. |
| **`ResetFormatterOnEntry`** | bool | *type default* | Revert to the default formatter on each entry. |
| **`DefaultFormatterId`** | string | *computed* | Formatter id applied to every paste unless the user cycles it with `Z`. |
| **`PasteKeystroke`** | PasteKeystroke | `CtrlV` | Chord sent to make the target application paste. |
| **`WarnAboutClipboardManagerConflict`** | bool | `true` | Offer to switch to Shift+Insert at start-up when another clipboard manager is detected. |
| **`WarnAboutFilteredKeyboard`** | bool | `true` | Say so when the keyboard hook is receiving nothing in one application while working in the others. |
| **`TypeOutMaxChars`** | int | `10000` | The longest clip the type-out action - unbound by default - will type out, in characters. |

## Keys

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`PasteModeTriggerKey`** | string | *computed* | Letter that, held with Ctrl, opens paste mode. |
| **`PasteModeKeys`** | string | *computed* | Which letter fires which paste-mode action, as `name=letter` pairs: `back=C;newest=A;pin=P`. |

## Excluded Apps

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`IgnoredProcesses`** | List<string> | *empty list* | Skip capture entirely while one of these processes is in the foreground - password managers being the obvious case. |

## Appearance

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`OverlayPosition`** | PopupPosition | `Automatic` | Where the paste overlay is put on screen. |
| **`CopyNotificationPosition`** | PopupPosition | `MousePointer` | Where the copy notification is put on screen, using the same mechanism as OverlayPosition. |
| **`OverlayX`** | int | *type default* | Fixed overlay position in physical pixels, used when PopupPosition is Settings.PopupPosition.FixedPoint. |
| **`OverlayY`** | int | *type default* | Fixed overlay position in physical pixels, used when PopupPosition is Settings.PopupPosition.FixedPoint. *(shared with the setting above)* |
| **`Theme`** | string | *computed* | Colour scheme, by name. `System`, `Light`, `Dark`, or the name of any other theme - shipped or written by the user. |
| **`OverlayPreviewMaxWidth`** | int | `600` | Largest size, in device-independent pixels, at which the paste overlay draws an image preview. |
| **`OverlayPreviewMaxHeight`** | int | `400` | Largest size, in device-independent pixels, at which the paste overlay draws an image preview. *(shared with the setting above)* |
| **`OverlayFontFamily`** | string | *empty* | The font the paste overlay draws in. |
| **`OverlayFontSize`** | int | `12` | The overlay's text size in device-independent pixels. |
| **`OverlayPreviewChars`** | int | `400` | Characters of a text clip shown in the paste overlay before it is elided. |
| **`ShowOverlayKeyHint`** | bool | `true` | Show a one-line key reminder along the bottom of the paste overlay. |
| **`ShowOverlayPosition`** | bool | `true` | Show the `Clip 3 of 41` line at the top of the overlay. |
| **`ShowOverlayTextDetails`** | bool | `true` | Show lines and characters for a text clip. |
| **`ShowOverlayTextSize`** | bool | `true` | Show the byte count for a text clip. |
| **`ShowOverlayImageDetails`** | bool | `true` | Show pixel dimensions for an image, or for a copied image file. |
| **`ShowOverlayImageSize`** | bool | `true` | Show the byte count for an image. |
| **`ShowOverlayFileDetails`** | bool | `true` | Show a copied file's own details, such as the line count of a text file. |
| **`ShowOverlayFileSize`** | bool | `true` | Show the byte count for a file copy. |
| **`ShowOverlayTags`** | bool | `true` | Show the clip's tags. |
| **`ShowOverlaySource`** | bool | `true` | Show which application the clip was copied from. |
| **`ShowOverlayFormatter`** | bool | `true` | Show the paste format - Original, Plain text, and so on. |
| **`ShowOverlayPinned`** | bool | `true` | Show the `PINNED` chip. |
| **`ShowOverlayTimestamp`** | bool | `true` | Show when the clip was copied, at the right of the facts row. |
| **`ShowOverlayClipKind`** | bool | `true` | Show the clip's kind - `Text`, `Image`, `Files` - at the head of the overlay's facts row. |
| **`ShowCopyNotification`** | bool | `true` | Show a brief notification near the cursor after each copy, as Clipjump did. |
| **`CopyNotificationMs`** | int | `500` | How long the copy notification stays on screen, in milliseconds. 500 rather than 1,200. |
| **`BeepOnCopy`** | bool | *type default* | Sound a short tone on each capture. |
| **`BeepFrequencyHz`** | int | `1500` | Pitch of that tone in hertz. |
| **`BeepDurationMs`** | int | `150` | Length of that tone in milliseconds. |

## System

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`TrayLeftClick`** | TrayClickAction | `History` | What a left click on the tray icon does. |
| **`UpdateChannel`** | UpdateChannel | `Stable` | Which releases `Check for Updates` is willing to offer. |
| **`StartupNotice`** | StartupNotice | `EveryLaunch` | Whether PasteJump announces itself when it starts, since a tray-only application otherwise gives no sign of having started at all. |
| **`LastAnnouncedVersion`** | string | *empty* | The version that last announced itself, which is how StartupNotice.AfterUpdateOnly knows an update has happened. |
| **`PasteSettleDelayMs`** | int | `25` | Gap in milliseconds between putting a clip on the clipboard and sending Ctrl+V. |
| **`PasteSettleDelayPerApp`** | string | *empty* | Per-application overrides for PasteSettleDelayMs, as `name=ms` pairs: `winword.exe=80;ms-teams.exe=100`. |
| **`RunAtLogon`** | bool | *type default* | Start with Windows via a shortcut in the user's Startup folder. |
| **`TextEditor`** | string | *computed* | External editor used by the `H` key on a text clip. |
| **`ImageEditor`** | string | *computed* | External editor used by the `H` key on an image clip. |
| **`HistoryHotkey`** | string | *empty* | System-wide hotkey that opens the clipboard history window, e.g. `Ctrl+Shift+H`. |

## Advanced

| Name in the file | Type | Default | What it does |
| --- | --- | --- | --- |
| **`HistoryWindowWidth`** | int | `1260` | The clipboard history window's size, remembered between openings. |
| **`HistoryWindowHeight`** | int | `770` | The clipboard history window's size, remembered between openings. *(shared with the setting above)* |
| **`HistoryListWidth`** | int | `552` | How wide the clipboard list is, leaving the rest of the window to the preview. |
| **`HistoryWindowMaximised`** | bool | *type default* | Whether the history window was maximised when it was last closed. |
| **`ClipboardSettleMs`** | int | `120` | How long to let the clipboard settle after a change notification before reading it, in milliseconds. |
| **`ClipboardRepublishMs`** | int | `1000` | How long after storing a clip a second publish of the same content counts as the same copy, in milliseconds. |
| **`OverlayDeletedFlashMs`** | int | `1200` | How long the overlay shows `DELETED` after the `Delete` key, in milliseconds. `0` never shows it. |
| **`TypeOutCharDelayMs`** | int | *type default* | Pause between batches of characters when a clip is typed out by the unbound type-out action, in milliseconds. |

# Launch copy

Where to announce PasteJump, and the text to use. Written 2026-08-23, when `2026.1` went out and the project
had 0 stars.

**Order matters more than the words.** The evergreen entries cannot be used up, so they go first; a Show HN or
a Reddit post is a one-shot that a blank landing page wastes, and it cannot be re-spent.

> ## READ THIS FIRST — this plan predates the licence change (2026-09-08)
>
> PasteJump was open source under MIT when every word below was drafted, and it is now free-of-charge
> proprietary software with a private repository. **Three of these seven venues assumed source that no longer
> exists**, and the drafts have been corrected for the licence but not re-argued for the new position:
>
> - **Show HN (#5) is the one to reconsider, not just re-word.** Its whole angle is the DLP/UIPI
>   investigation — an engineering story told to an audience that will ask to read the code in the first
>   comment. "Closed source, trust me" is a weak answer to that question, and the thread is one-shot. It is
>   still postable; it is no longer clearly the right spend.
> - **r/opensource and r/coolgithubprojects are now off the list outright** — both require what this project
>   no longer publishes. Posting there would be answered by a rule, not a download.
> - **Awesome lists (#4) need their contribution rules checked for an open-source requirement** before a PR
>   is spent; several accept freeware, several do not.
>
> Conversely, **#7 got better**: Softpedia and MajorGeeks are freeware directories, and a free closed-source
> Windows utility is exactly their stock in trade. So is AlternativeTo (#2) — untick *Open Source*, keep
> *Free*.
>
> Nothing below claims MIT any more. Re-read the venue list before spending a one-shot.

| # | Where | Why it is in this order |
|---|---|---|
| 1 | **Clipjump's own audience** — its GitHub issues, the AutoHotkey forum thread | They already want this exact program. Abandoned April 2016 and people still ask for a successor. Reply where somebody is asking; do not bulk-post. |
| 2 | **[AlternativeTo](https://alternativeto.net/)** — as an alternative to Clipjump, Ditto, CopyQ, ClipboardFusion, Windows clipboard history | Search-intent traffic that keeps arriving for years. Highest return per hour on this list. |
| 3 | **winget** and **Scoop** | Distribution *is* discovery: `winget install PasteJump` removes the download-unzip-unblock friction entirely. Manifests are written - see `packaging/winget` and `packaging/scoop`. |
| 4 | **Awesome lists** — awesome-windows, awesome-windows-apps | A PR each, permanent, and they are what people browse when they want a tool of this kind. |
| 5 | **Show HN** | Spend once, after 1-4 and after the SourceForge page is filled. Lead with the engineering story, not the program - see below. |
| 6 | **Reddit** — r/Windows11, r/windows, r/software, r/csharp | Check each subreddit's self-promotion rule first. A removed post costs you that subreddit, and several want you to be an existing participant. **r/opensource and r/coolgithubprojects were dropped on 2026-09-08**: both require published source, so a post there is removed on a rule rather than judged on the program. |
| 7 | **Ghacks, Neowin; Softpedia, MajorGeeks listings** | They do cover small Windows utilities. One paragraph and the GIF is enough. |

**Skip:** Product Hunt (its audience skews SaaS and macOS; a free Windows keyboard utility lands flat) and
X/Twitter with no existing following.

---

## Two things to fix before spending #5 and #6

1. **SmartScreen will dominate the comments.** Say it first, in the post: unsigned, why (a signature that
   fails to validate looks worse than none), and that every release publishes SHA256s. Getting ahead of it
   converts an objection into evidence of care.
2. **The SourceForge page is blank.** Either fill it from `../sourceforge-page.md` or point every link at
   GitHub. With 0 stars the GitHub README and the tour GIF are doing all of the persuading.

---

## Show HN

**Do not lead with the program.** "I made a clipboard manager" competes with a hundred others and asks the
reader for a favour. The DLP investigation is real, unusual, and already written up - it earns the tool a look
instead of requesting one.

### Title

Show HN: PasteJump - a keyboard-driven clipboard manager, and why my hook went deaf in one browser

### Body

```
PasteJump is a clipboard manager for Windows built around one gesture: hold Ctrl, tap V to walk back
through what you have copied, release to paste. No window, no mouse. It is a ground-up reimplementation
of Clipjump, an AutoHotkey program abandoned in 2016, in C# on .NET 10.

The part I think is worth your time is a bug I could not explain for two days. PasteJump "stopped
working" in Edge - Ctrl+V did nothing there while working everywhere else, and copying kept working the
whole time.

It was not Edge, and it was not my program. Endpoint DLP software on that machine routes the watched
application's keyboard input through a component running at higher integrity than my process, and
Windows then excludes a lower-integrity low-level hook from that input by design. Measured: Edge
delivered 939 keystrokes to my hook one day and zero across 2,736 seconds of foreground the next, while
Windows Terminal delivered 4,899. A probe injecting Ctrl+Alt+J found SendInput reporting 6/6 events
accepted while WH_KEYBOARD_LL, raw input with RIDEV_INPUTSINK, and RegisterHotKey all saw nothing.

Four unrelated implementations fail identically at medium integrity - my .NET app, a probe making direct
user32 calls, the same gesture rewritten in ~700 lines of plain Win32 C++, and Clipjump itself. Running
elevated fixes it completely, which is what points at UIPI rather than at anything in the code. It is
also intermittent: the protection engages and disengages, so "it works sometimes" is exactly what you
would expect, and is why I spent a day looking for a race in my own code.

Two things I took from it. A rewrite in C++ would have bought nothing - the probes that measured it were
already direct calls to the same exports, and Windows sees a function pointer either way. And the
cheapest possible check was the one I did last: a second, unrelated clipboard manager failed in the same
application at the same time, which immediately makes the question "what is this machine doing" rather
than "what did I break".

Windows 10/11, x64, free, portable single exe. The builds are not signed with a paid certificate, so
SmartScreen will report an unknown publisher on first run - I publish a SHA256 for every file instead,
because a signature that fails to validate looks worse than none at all.

https://github.com/lokeshgovindu/PasteJump
```

### First comment, posted by you immediately after

```
Some detail that did not fit above, for anyone interested in the mechanics:

- The clipboard is never used as scratch space. The store is read once per change and every format is
  kept, so pasting into Excel gives back Excel's own Biff12 blob - 24 of 25 formats byte-identical on a
  real round trip, the one difference being a locale field Windows regenerates itself.
- Recognising our own clipboard writes cannot be done by content hash. A write does not read back as
  what was written: Windows regenerates CF_TEXT, CF_OEMTEXT and CF_LOCALE from the *pasting* thread's
  locale, so a paste came back as a brand-new clip. Found it by querying the store - two clips, same 66
  characters, differing in one byte pair: CF_LOCALE 0x4009 as captured against 0x0409 as synthesised.
- The hook callback blocks all keyboard input machine-wide, so every side effect is queued onto the
  dispatcher. p95 is 0.071 ms over 691 real keystrokes.
- Windows discards a hook that exceeds LowLevelHooksTimeout and never tells you - and IsInstalled keeps
  returning true. So "is it installed" cannot be the health check; the watchdog asks whether anything
  has been heard since Ctrl went down.

Happy to go into any of it.
```

**Timing:** a weekday, US morning. Be present for the first two hours - Show HN lives or dies on the author
answering comments.

---

## AlternativeTo

Add PasteJump, then list it as an alternative to **Clipjump** (the strongest match), Ditto, CopyQ,
ClipboardFusion, ArsClip, and Windows' built-in clipboard history.

```
PasteJump is a keyboard-driven clipboard manager for Windows, built around one gesture: hold Ctrl and tap
V to walk back through everything you have copied, then release to paste. There is no window to open and
no mouse involved.

Press F mid-gesture to search the stack as you type. Pin the clips you keep reaching for, filter by text,
image or file, or mark several and paste them joined. A history window gives full-text search over
everything you have copied, with image previews that zoom and pan.

Every clipboard format is kept, so a paste into Word or Excel arrives exactly as it left. Nineteen themes
ship and you can write your own. It is portable - one executable, no installer, and its data folder sits
beside it, so a USB stick carries your history.

PasteJump is a ground-up reimplementation of Clipjump, which was written in AutoHotkey and abandoned in
2016, rebuilt in C# on .NET 10. Free of charge (closed source). Windows 10 or 11, 64-bit.
```

Tick: Free, Portable, Windows. Do NOT tick Open Source. Categories: Clipboard Manager, Productivity, Utilities.

---

## Clipjump's SourceForge project page - a review

<https://sourceforge.net/projects/clipjump/>, Reviews tab, five stars - honestly earned, not tactically.

**URLs are prohibited in SourceForge reviews**, which is why this one names PasteJump and says where it lives
instead of linking. The name is distinctive enough for site search to find, and keeping the reader inside
SourceForge is friendlier on somebody else's project page anyway. Watch bare domains too - a moderation filter
that strips links will often treat `github.com/...` as one.

Plain hyphens rather than em-dashes, and no Markdown: the box is plain text, so `**bold**` would paste literally.

```
Clipjump did one thing better than anything else I have used: hold Ctrl, tap V to walk
back through the clip stack, let go to paste. No window, no mouse, no thinking about it.
I used it for years and it never once got in the way.

It has been unmaintained since 2016, and Avi Aryan's own issue #136 - "LOOKING FOR
MAINTAINERS/SUCCESSORS" - has people in it offering to pay for someone to carry it on. So
I wrote a successor and called it PasteJump: .NET 10 and WPF, Windows 10 and 11, free of charge
licensed, and hosted here on SourceForge as well as on GitHub under that same name. The
same gesture and the same instincts, plus full-text history search, tags, per-application
paste delays and themes.

To be straight about what it is: a reimplementation from observed behaviour, not a fork -
no Clipjump code was copied - and I am its author, so read this as a signpost rather than
an impartial review.

Thanks to Avi Aryan for the original. The idea was his; this just keeps it running on a
current runtime.
```

**The disclosure line is not trimmable.** It is what makes this a signpost rather than an advert on somebody
else's page, and it is what stopped the comment on Clipjump #136 being deleted. Same framing as the GitHub
comment and the Disqus one from 2026-08-24, so the three stay consistent if the pending one ever appears.

If asked whether it was written with AI, answer plainly yes and offer the test count as checkable. That is what
worked on issue #1; a hedge is what would come back.

---

## Press and listing sites

One short email. Attach nothing; link the GIF.

```
Subject: PasteJump 2026.1 - a keyboard-driven clipboard manager for Windows (free)

Hello,

I have released PasteJump 2026.1, a free clipboard manager for Windows built around a
single gesture: hold Ctrl, tap V to step back through everything you have copied, release to paste. No
window, no mouse.

It is a ground-up reimplementation of Clipjump - an AutoHotkey program that was popular and was abandoned
in 2016 - rebuilt in C# on .NET 10, and it keeps every clipboard format, so pasting into Word or Excel
arrives as it left. Portable: one executable, nothing installed.

Site, with a 60-second animated tour: https://lokeshgovindu.github.io/PasteJump/
Downloads and release notes: https://github.com/lokeshgovindu/PasteJump/releases
Manual: https://lokeshgovindu.github.io/PasteJump/help/overview.html

Happy to answer anything. The builds are unsigned, so SmartScreen reports an unknown publisher on a first
run; I publish a SHA256 for every file in the release notes.

Lokesh Govindu
```

---

## After any of this lands

Watch `docs/download-stats.csv` rather than the badge: the workflow records a count per asset per day and
commits only when one moves, so it is the only place a *trend* exists. Two cautions written down elsewhere and
worth repeating here - it counts anything that fetches a file, including drafts and your own verification, so
read the first numbers after a release as your own.

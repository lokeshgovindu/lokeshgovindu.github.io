---
title: DependencyGraph release notes
nav: my-work
ph_label: DependencyGraph &middot; Release notes
heading: What's new
ph_sub: Every DependencyGraph release, newest first.
description: Release notes for every version of DependencyGraph, the Visual Studio project reference graph extension.
---
<section class="tips-section">
<div class="container blog-post-content" markdown="1">
<a href="/my-work/dependencygraph/" class="back-link mb-4 d-inline-block"><i class="fa fa-arrow-left me-2"></i>About DependencyGraph</a>
&nbsp;&middot;&nbsp; <a href="/DependencyGraph/">Documentation</a>
&nbsp;&middot;&nbsp; <a href="https://marketplace.visualstudio.com/items?itemName=LokeshGovindu.DependencyGraph" target="_blank" rel="noopener">Visual Studio Marketplace</a>

## 2026.1.0.0 — 30 August 2026

The extension has been rebuilt around a new graph engine and a dockable tool window. If you have
been using the 2023 release, this is a different tool in most of the ways that matter.

### The window

The graph now opens in a **dockable tool window** instead of a modal dialog, so it no longer blocks
the IDE while it is up, and it is drawn with
[MSAGL](https://github.com/microsoft/automatic-graph-layout) rather than NodeNetwork. Labels stay
crisp when zoomed, node text scales with a configurable font size, and the command bar scrolls when
the window is too narrow for it.

### Five views

- **Deepest references only** — one edge per project, to its furthest dependency
- **All references** — every reference, direct and indirect
- **Direct references only**
- **Impact** — what depends on a project, rather than what it depends on
- **Entire solution** — every project and every reference at once, with projects nothing else
  references marked as entry points

### Reading a large solution

- **Solution folder boxes**, named, that collapse to a single node
- **Focus** — narrow the graph to projects you pick
- **Depth limiting**, measured along the shortest path to a project rather than the longest
- **Exclusions** by name pattern, for example `*.Tests;*.Benchmarks`
- **Cycle detection**
- A **legend**, and external references drawn distinctly

### Moving things around

Nodes and group boxes can be **dragged** where you want them. Positions **persist per solution**,
on disk, so they survive a rebuild of the graph and closing the solution. **Reset layout** puts
everything back.

### Other

- Each project's **target framework** in the tooltip and status bar, and optionally under the node
  name in the graph
- Richer tooltips: target framework, solution folder, reference counts, full path
- **Tools → Options** page for defaults — view, direction, depth, font size, exclusions
- Exports to **PNG**, **DGML** and **Graphviz DOT**; Graphviz itself is only needed for its own
  SVG/PNG export
- The extension's own icon on the Tools and Solution Explorer menu items
- Projects keyed by unique name, so two projects sharing a name in different solution folders no
  longer merge into one node
- Builds clean with no compiler or threading-analyzer warnings

### Fixed

- The graph window came up empty, with no project selected when it opened. The fault was
  entirely on the rendering side, which has been replaced. Verified against the solution from that
  report: 16 projects, 33 connections, drawn correctly.

### Known gaps

- The DGML and Graphviz DOT exports still use project *names* as node ids, so two projects with the
  same name in different solution folders merge into one node in those files. The graph itself does
  not have this problem.

## 2023.3.0.0 — 15 October 2023

- Save solution and project dependency graphs to DGML and Graphviz DOT.
- Show the reference count and referenced-by count for each project.
- Display the project name, nodes and connections in the status bar.

Saving to Graphviz output needs Graphviz's `dot.exe` on the `PATH`.

## 2023.2.0.2 — 26 August 2023

Initial release.

</div>
</section>

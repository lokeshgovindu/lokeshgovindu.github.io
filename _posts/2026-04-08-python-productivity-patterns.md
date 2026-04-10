---
layout: post
title: "Python Productivity Patterns for Everyday Scripts"
date: 2026-04-08 08:45:00 +0530
tags: [Python, Productivity, Best Practices]
---

Python is great for fast automation, but structure still matters. These patterns keep scripts clean and reusable.

## 1. Use a main entrypoint

```py
def main() -> None:
    print("Run task")


if __name__ == "__main__":
    main()
```

This avoids side effects and makes testing easier.

## 2. Parse arguments with argparse

```py
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--env", default="dev")
args = parser.parse_args()
```

Even tiny scripts benefit from explicit input handling.

## 3. Prefer pathlib over string paths

```py
from pathlib import Path

root = Path(".")
for file in root.glob("*.md"):
    print(file.name)
```

`pathlib` is safer and easier to read.

## 4. Log instead of print for non-trivial scripts

Structured logs make troubleshooting much easier when scripts grow.

## 5. Capture repeated steps as functions

Tiny utility functions improve reuse and reduce copy-paste bugs.

A script that is easy to understand today is much easier to maintain six months later.

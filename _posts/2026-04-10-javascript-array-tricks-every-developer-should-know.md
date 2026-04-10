---
layout: post
title: "JavaScript Array Tricks Every Developer Should Know"
date: 2026-04-10 10:00:00 +0530
tags: [JavaScript, Productivity, Best Practices]
---

Arrays are everywhere in JavaScript, and a few small patterns can significantly improve readability and performance.

## 1. Remove duplicates with Set

```js
const unique = [...new Set(items)];
```

Use this when order matters and you only need simple value uniqueness.

## 2. Chain map/filter with intent

```js
const activeNames = users
  .filter((user) => user.active)
  .map((user) => user.name);
```

Keep each step focused so future readers understand the data pipeline quickly.

## 3. Group items with reduce

```js
const byType = logs.reduce((acc, log) => {
  (acc[log.type] ||= []).push(log);
  return acc;
}, {});
```

This pattern is useful for dashboards, summaries, and reporting logic.

## 4. Prefer flatMap for transform + flatten

```js
const words = lines.flatMap((line) => line.split(" "));
```

It is cleaner than mapping to arrays and then calling `flat()`.

## 5. Use at(-1) for last element

```js
const lastItem = queue.at(-1);
```

This avoids the common `queue[queue.length - 1]` pattern and reads better.

Small array improvements compound over time. Clean list processing helps teams move faster with fewer bugs.

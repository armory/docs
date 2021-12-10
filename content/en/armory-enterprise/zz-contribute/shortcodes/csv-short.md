---
title: "Table from getCSV"
draft: true
description: "table from CSV shortcode"
---

## Table from CSV file

Shortcode reads a CSV and displays the contents in an HTML table.

Pass in delimiter and URL (either local file system or remote URL).

>`code` is not rendered as code when you use backticks in the CSV file. Surround code with `<code>some code</code>`.

### CSV without embedded HTML

{{% csv-table ";" "/static/csv/test.csv" %}}

### CSV with embedded HTML

{{% csv-table ";" "/static/csv/test2.csv" %}}
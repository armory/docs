---
title: Add an Image
description: >
   Add an image using the `figure` shortcode.
---

## Add an image to a page

The process is the same as making any other edit with some additional steps.

Add the images to the same folder as your markdown file. If you have only a single markdown file, create a directory - this is what Hugo calls a [leaf bundle](https://gohugo.io/content-management/page-bundles/#leaf-bundles). 

For example:

**Existing file: my-page.md**
1. Create a directory called "my-page".
1. Add a page named "index.md" and move the content from `my-file.md` to `index.md`.
1. Add the images to the `my-page` directory.



In the markdown file, you reference an image using the following Hugo shortcode:

{{</* figure src="filename.png" alt="description of the image" */>}}


See Hugo's `figure` [reference](https://gohugo.io/content-management/shortcodes/#figure) for the list of `figure` options.


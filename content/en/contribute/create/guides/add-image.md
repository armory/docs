---
title: Add an Image
description: >
   Add an image using the `figure` shortcode.
---

## Add an image to a page

The process is the same as making any other edit with some additional steps.
Add the image to the `static/images` folder in a directory that mirrors where the markdown file is.

1. If you are adding several images, put them in a folder based on the page name. For example, if you want to add a single image to `armory-admin/diagnostics-configure.md`, you can add your image to `static/images/armory-admin.``
   - If you want to add more than one image to `armory-admin/diagnostics-configure.md`, create a `diagnostics` folder under `armory-admin` and put the images there.
1. In the markdown file, you reference an image using the following Hugo shortcode:

   {{</* figure src="/images/<filename>.png" alt="<description of the image" */>}}

   If you added your image to a subfolder in static/images, include the subfolder in the path for the src like so: 

   {{</* figure src="/images/release/224/deck_2240_release_note.jpg" alt="Breadcrumbs for nested pipeline execution context" */>}}

   Note that you can reference an image using the standard Markdown format as well.



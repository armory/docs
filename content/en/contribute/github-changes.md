---
title: Make a Change Using the GitHub Web UI
weight: 3
description: >
   Use the GitHub web UI to edit a single page and create a pull request.

---

## Open a pull request (PR) on GitHub

1. Click the **Suggest an Edit** link on the documentation page you want to update. This takes you to the page's source file in GitHub.
1. Click the **Edit this file...** pencil icon to edit the file.

   ![EditFileIcon](/images/contribute/github-edit-file-icon.jpg)

1. Make your changes in the GitHub markdown editor. Be sure to follow the guidelines in the {{< linkWithTitle "contribute/docs-style-guide.md" >}}.
1. Fill in the **Propose file change** form.

   ![ProposeFileChange](/images/contribute/github-propose-file-change-form.jpg)

   1. Explain what your file change is about in a short summary.

   2. Provide a clear description of your change. Do not to leave this field blank. It is helpful to reviewers to have additional context about what you changed.

1. Click **Propose file change**. This takes you to the **Comparing changes** screen so you can review your changes.

1. Click **Create pull request**. This takes you to the **Open a pull request** form.

1. Fill in the **Open a pull request** form.

   ![OpenPullRequest](/images/contribute/github-open-pull-request.jpg)

   1. The **Title** defaults to the file change summary. Update the title so it follows the `<type>(<scope>): <subject>` format. Make sure you include a space after the colon. For example:

      ```
      docs(fix): fix a typo
      ```

      The Armory docs repository uses a PR title checker, so your PR fails the required checks if the title is not in the correct format.
      - docs(fix):
      - docs(feat):
      - docs(refactor):

      Basically, you can put whatever word you want between the parentheses, but the single word should reflect what the PR is doing (fix, feat, refactor) or the content area (plugins, dinghy, overview, etc).

   2. The **Leave a comment** field defaults to the file change description. PR descriptions are the first step to helping reviewers and project maintainers understand why your change was made. Do not leave this field blank. Provide as much description as possible. A good description helps get your PR merged faster!
   3. Leave the **Allow edits from maintainers** checkbox selected.

1. Click the **Create pull request** button.

   Congratulations! You can view your submitted pull request on the **Pull requests** [tab](https://github.com/armory/docs/pulls).

## Address feedback in GitHub

The Armory documentation team reviews docs pull requests. If you have a specific person in mind, [tag that person in the issue comments](https://github.blog/2011-03-23-mention-somebody-they-re-notified/) using the @ symbol and then their GitHub username. Reviewers can request changes, leave comments, or approve the pull request.

## What to do if a reviewer asks for changes

1. Go to the **Files changed** tab in GitHub.
1. Make the requested changes.
1. Commit the changes.



---
title: Guidelines for Reviewing Pull Requests
linkTitle: Reviewer Guidelines
---

## Review a pull request

Anyone can review a documentation pull request (PR). Visit the [Pull requests](https://github.com/armory/docs/pulls) section in the Armory Docs repository to see a list of all currently open pull requests.

Reviewing documentation pull requests is a great way to get started contributing to the Armory documentation. It helps you to learn the content and builds rapport with other contributors.

## {{% heading "prereq" %}}

1. Familiarize yourself with [Reviewing changes in pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests)
1. Read the {{< linkWithTitle "docs-style-guide.md" >}} so that you can leave informed feedback.
1. Review the [Code of Conduct]({{< ref "code-of-conduct" >}}) and ensure that you abide by it at all times.

## Best practices

* Be polite, helpful, and considerate of others.
* Comment on positive aspects of a PR, as well as changes.
*  Be empathetic and mindful of how your changes or review may be received.
*  Ask clarifying questions if something in a PR is unclear.
*  Assume positive intent.
*  If you are an experienced contributor, consider pairing with new contributors whose work requires extensive changes.
*  Ask your fellow contributors how they work best and what communication style they prefer.

## Start the review process

1. Go to (<https://github.com/armory/docs/pulls>) to see a list of all current open PRs in the `armory/docs` repository.

1. Filter the open PRs using one or all of the following labels:

   PRs have two states, one is **ready for review** and the other is a **draft Pull request**

   If a PR is classified as a [draft pull request](https://github.blog/2019-02-14-introducing-draft-pull-requests/), this means the contributor would like feedback on their PR throughout the review process, and that the PR is **not ready for review or merging**.

   Reviewers should encourage new contributors to make use of **draft PRs** when appropriate.

   If a PR is **ready for review**, reviewers should proceed to the next step in the review process.

   - Once you've found a PR to review, understand the change by:

     1.  Reading the PR description to learn why the PR was made, and read any linked issues attached to the PR
     1.  Reading comments left by other reviewers
     1.  Clicking the **Files changed** tab to see any files and lines changed

1. Go to the **Files changed** tab and begin your review

   1.  Click on the + symbol beside the line you want to comment on.
   1.  Fill in any comments you have about the line in question, and click either, **Add a single comment** (if you have only one comment to make on the PR) or **Start a review** (if you have multiple comments)
   1.  When you've finished reviewing the PR, click **Review changes** at the top of the page. Here, you can add a summary of your review (and leave some positive comments and thanks for the contributor!), approve the PR, comment or request changes as needed. New contributors should always choose **Comment**.

## Reviewer checklist

When reviewing a PR, use the following questions as a starting point:

1. Are there any obvious errors in grammar or language?
1. Are there words, phrases, or terms that should be replaced with a non-discriminatory alternative?
1. Does the word choice, punctuation, and capitalization follow the {{< linkWithTitle "docs-style-guide.md" >}}?
1. Are there long sentences which could be shorter or made less complex?
1. Are there long paragraphs which would work better as a bulleted list or table?
1. Is the content technically correct?
1. If the content is a task or tutorial, do the steps work? Additionally, does the content follow the defined content structure for its type?

## Other

For small issues with a PR, like typos or whitespace, prefix your comments with "nit:". This lets the author know the issue is non-critical.

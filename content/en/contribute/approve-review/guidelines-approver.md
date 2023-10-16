---
title: Guidelines for Approving Pull Requests
linkTitle: Approver Guidelines
---

## {{% heading "prereq" %}}

You should be familiar with the content in the {{< linkWithTitle "guidelines-reviewer.md" >}} and understand how to apply those guidelines to your review/approval.

## Best practices

- Be polite and considerate.
- If you are asking for a lot of changes on a review, make sure at least one comment is a positive one.
- Make sure your review comments are **con**structive not **de**structive.
- Do not turn a review into a sparring match.
- If you are a Committer or very experienced Contributor and you see a PR from a new Contributor that needs a lot of changes, consider reaching out to that new Contributor and offer to discuss and/or have a pair writing session.
- Avoid changing PR content other than typos or broken links.
- Ask clarifying questions in a way that doesn't put the author on the defensive
- If you think there's a better way to present content, mention it in your review and then ask what the author thinks.
- If you notice style guide violations, politely point out the issue, or use the GitHub **Insert a suggestion** [functionality](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request#adding-line-comments-to-a-pull-request) to suggest a change, and then link to the relevant section in the style guide to explain why you are suggesting the change. The most common style guide violation is using passive voice instead of active voice.
- For PRs written by the engineers, wait until all the technical reviews and feedback from those reviews is done before copy editing and pushing commits to the PR. If you want to change or enhance the content, let the author know before you start.


## Approval checklist

1. Do all the items listed in the [Reviewer checklist]({{< ref "guidelines-reviewer#reviewer-checklist" >}}).
1. Ensure there is [good SEO content](#approver-seo-checklist)
1. Test that the content renders correctly (use the [Netlify deploy preview](https://docs.netlify.com/site-deploys/deploy-previews/)).
1. Make sure the content is accurate, concise, and well-organized.
1. If a task or tutorial, the steps work.

## SEO guidelines

https://developers.google.com/search/docs/beginner/seo-starter-guide for in-depth SEO guidelines and explanations.

### Page file names

Use [simple, human-readable, and logical URL paths for your pages](https://developers.google.com/search/docs/advanced/guidelines/url-structure) and provide clear and direct internal links within the site.

### Page titles

Google analyzes the content of the page, catalogs images and video files embedded on the page, and otherwise tries to understand the page.

When listing search results, Google truncates longer page titles but still finds keywords in the entire title when building the index.

**Create short, meaningful titles that accurately reflect the page content.** Include relevant keywords. Do not sacrifice accuracy (or keyword) for brevity. Armory's priority is accurate/descriptive page titles, but do your best to keep them a manageable length.

### Approver SEO checklist

To improve our placement in search rankings, keep these in mind when editing and approving PRs:

1. Title should be descriptive and contain keywords if possible (Spinnaker, Kubernetes, AWS, Armory Platform, etc). Use natural language and ensure that the content of the page is clearly expressed.  Notes:
    - titles should be no longer than _60 characters_  _maximum_. 55 is preferred. This includes the standard &quot;| Armory docs&quot; that is appended
    - Go from unbranded to branded terms as appropriate (e.g., don&#39;t lead with Armory, lead with terms that are generally searched for)
    - All titles should be unique.
    - The title should not be the exact same as the title (H1) on the page.
1. Front matter `description`  turns into a `meta` tag when compiled; should be no longer than 160 characters and also contain keywords because search engines look for this meta description. Notes:
    - Make sure that the language is natural and clearly describes what the user will find on the page.
    - Do not make it a duplicate of the title.
    - Make it enticing and clear - e.g., what you will learn, what problems it solves,  etc.
1. H2 and H3 tags should be contain keywords if it makes sense; header tags send valuable ranking signals to Google and provide context to bots
    - &quot;Overview of pipelines&quot; rather than &quot;Overview&quot;
    - &quot;Prerequisites for deploying to …&quot; rather than &quot;Prerequisites&quot;  (Yes, it may be repetitive but SEO rankings are voodoo)
1. Short intro sections directly below header tags (1-2 sentences is enough) that include the keyword target
1. Link to other relevant content using keyword-focused anchor text
    - Anchor text sends ranking signals to Google. When you use keywords in the anchor text, that reinforces the keyword targeting of the linked page. Plus, it can be clearer for users and shows them exactly what the link they're clicking focuses on.
    - In general, internal links between content are powerful for SEO. When you link from a high-ranking, high-traffic page to another page, it passes some of that page's power on to other areas of the site.
    - You can use the `linkWithTitle` shortcode to insert the page title as the link text
1. Page URLs
    - Ensure that the url is human readable and clearly conveys the page content. If/as applicable include the priority keyword in the url.
    - use lower case only and hyphens
1. Images
    - Ensure that all images have alt tags that are clear descriptions of what the images express. Include keyword(s) if/as appropriate.
    - Ensure that the image name is human readable and conveys what the image is
1. SEO resources
    - [https://developers.google.com/search/docs/beginner/seo-starter-guide](https://developers.google.com/search/docs/beginner/seo-starter-guide)





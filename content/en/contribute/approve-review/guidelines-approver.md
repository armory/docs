---
title: Guidelines for Approving Pull Requests
linkTitle: Approver Guidelines
---

## {{% heading "prereq" %}}

You should be familiar with the content in the {{< linkWithTitle "contribute/approve-review/guidelines-reviewer.md" >}} guide and understand how to apply those guidelines to your review/approval.

## Best practices

- Be polite and considerate.
- If you are asking for a lot of changes on a review, make sure at least one comment is a positive one.
- Make sure your review comments are **con**structive not **de**structive.
- Do not turn a review into a sparring match.
- If you are a Committer or very experienced Contributor and you see a PR from a new Contributor that needs a lot of changes, consider reaching out to that new Contributor and offer to discuss and/or have a pair writing session.
- Avoid changing PR content other than typos or broken links.
- Ask clarifying questions in a way that doesn't put the author on the defensive
- If you think there's a better way to present content, mention it in your review and then ask what the author thinks.
- If you notice style guide violations, politely point out the issue, or use the GitHub  **Insert a suggestion** functionality to suggest a change, and then link to the relevant section in the style guide to explain why you are suggesting the change. The most common style guide violation is using passive voice instead of active voice.
- For PRs written by the engineers, wait until all the technical reviews and feedback from those reviews is done before copy editing and pushing commits to the PR. If you want to change or enhance the content, let the author know before you start.


**Approval checklist:**

- Adheres to our style guide
- Good SEO content
- Renders correctly (use the deploy preview)
- Content is accurate and well-organized
- If a task or tutorial, the steps work

## SEO guidelines

### Page file names

Use [simple, human-readable, and logical URL paths for your pages](https://developers.google.com/search/docs/advanced/guidelines/url-structure) and provide clear and direct internal links within the site.

### Page titles

Google analyzes the content of the page, catalogs images and video files embedded on the page, and otherwise tries to understand the page.
When listing search results, Google truncates longer page titles but still finds keywords in the entire title when building the index.
**Create short, meaningful titles that accurately reflect the page content.** Include relevant keywords. Do not sacrifice accuracy (or keyword) for brevity.
Armory's priority is accurate/descriptive page titles, but do your best to keep them a manageable length.

## Approver checklist
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
1. H1 tags: this is for the title on the page and there should only ever be one H1 on the page.
1. H2 or other H tags should be contain keywords if it makes sense; header tags send valuable ranking signals to Google and provide context to bots
    - &quot;Overview of pipelines&quot; rather than &quot;Overview&quot;
    - &quot;Prerequisites for deploying to …&quot; rather than &quot;Prerequisites&quot;  (Yes, it may be repetitive but SEO rankings are voodoo)
1. Short intro sections directly below header tags (1-2 sentences is enough) that include the keyword target
1. Link to other relevant content  using keyword-focused anchor text
    -   When referencing a piece about how Spinnaker and Kubernetes work together, use this type of internal link: &quot;Learn more about [_how Spinnaker and Kubernetes work together_](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/) to...&quot; rather than &quot;Learn more [_here_](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/).&quot; Anchor text sends ranking signals to Google. When you use keywords in the anchor text, that reinforces the keyword targeting of the linked page. Plus, it can be clearer for users and shows them exactly what the link they&#39;re clicking will focus on. In addition, this is extremely important for accessibility.
    - In general, internal links between content are powerful for SEO. When you link from a high-ranking, high-traffic page to another page, it passes some of that page&#39;s &quot;power&quot; on to other areas of the site.
    - Linking with different words based will also add more context to the page for the link - e.g., with the example above: &quot;Learn more about [_how Spinnaker and Kubernetes work together_](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/) to...&quot; could be changed to a more specific &quot;Learn more about [_how Spinnaker and Kubernetes compare to (x)_](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/)_._&quot;
    - You can use the `linkWithTitle` shortcode to insert the page title as the link text
1. Page URLs
    - Ensure that the url is human readable and clearly conveys the page content. If/as applicable include the priority keyword in the url.
    - use lower case only and hyphens
1. Images
    - Ensure that all images have alt tags that are clear descriptions of what the images express. Include keyword(s) if/as appropriate.
    - Ensure that the image name is human readable and conveys what the image is, e.g., &quot;pipelines-workflow-for-spinnaker.jpg&quot; vs &quot;image.jpg&quot;
1. SEO resources
    - [https://developers.google.com/search/docs/beginner/seo-starter-guide](https://developers.google.com/search/docs/beginner/seo-starter-guide)
    - [https://github.com/armory-io/docs-team/blob/master/seo/BestPractices/3Q-guidelines.md](https://github.com/armory-io/docs-team/blob/master/seo/BestPractices/3Q-guidelines.md)



## Content Guidelines and SEO Best Practices for Armory from 3Q Digital



**Note** from Aimee-&gt; the guidelines below came from 3QDigital, and they seem pretty generic. Checkout https://developers.google.com/search/docs/beginner/seo-starter-guide for in-depth SEO guidelines and explanations.

### Overview

Expertise, authoritativeness and trustworthiness (E.A.T.) are the three

most important aspects of a website that Google uses to evaluate its

quality. While content isn&#39;t the only thing that matters for your SEO strategy,

there&#39;s no substitute for unique, high-quality, intent-driven content.

Content should be written for the appropriate audience first and

foremost. The following recommendations should never be used at the

expense of writing quality and aim to make the content more easily

digestible for humans and bots. Below are some best practices for a

successful content strategy:



### Formatting



-   Break content into easily scannable sections using headers and subheaders to improve user experience and establish hierarchy

(headers should be tagged as H2s and H3s)



-   This is particularly important at the beginning of the page. Armory&#39;s competitors are using this tactic successfully and have earned top rankings for high search volume keywords.



-   Address the main points in the first paragraph, or even 1-2 sentences, below each heading and then go into detail afterwards (this helps with making the content easy for bots to understand and can help with ranking in featured snippets).



-   We recommend using this type of intro content below header tags throughout the page. This style gives Armory the best chances of breaking into the top spots for valuable keywords and puts us in a good position to earn featured snippets and answer boxes.



-   Use keyword targets in the headings and throughout the text



-   This is especially important in those intro paragraphs and header tags mentioned above. Header tags send valuable ranking signals to Google and provide context to bots.



-   Leverage bulleted/numbered lists when applicable



-   Armory already does this throughout the content, but leading with some intro text will provide more context. These types of lists should also use keywords whenever possible.



### Content



-   Use relevant keywords throughout the text, but ensure that the

content still sounds natural



-   Link to other relevant content on the site using keyword-focused

anchor text (ex: When referencing a piece about how Spinnaker and

Kubernetes work together, we\&#39;d recommend using this type of

internal link: \&quot;Learn more about [*how Spinnaker and Kubernetes

work

together*](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/)

to\...\&quot; rather than &quot;Learn more

[*here*](https://www.armory.io/blog/why-spinnaker-and-kubernetes-work-together-seamlessly/).&quot;)



- Anchor text sends ranking signals to Google. When you use keywords in the anchor text, that reinforces the keyword targeting of the linked page. Plus, it can be clearer for users and shows them exactly what the link they&#39;re clicking will focus on.



- In general, internal links between content are powerful for SEO. When you link from a high-ranking, high-traffic page to another page, it passes some of that page&#39;s &quot;power&quot; on to other areas of the site.



-   Below subheadings, answer the main questions right away in the first

couple sentences, then go into more detail. This helps with user

experience and improves bots&#39; understanding of the content.



### Quick Checklist



Every article should include:



-   Keyword-focused metadata



-   Keyword-focused H1 tag (not exactly duplicative of the title tag)



-   Meta description (ideally below 160 characters)



-   Clear header tags tagged based on priority and hierarchy



-   Keywords in the header tags (avoid generic header tags like

&quot;Overview&quot; or &quot;Requirements&quot; and opt for something that utilized the

keywords like &quot;Overview of Pipelines&quot; or &quot;Requirements to build a

pipeline&quot;)



-   Short intro sections directly below header tags (1-2 sentences is

enough) that include the keyword target



-   Internal links within the text to other relevant articles (when

applicable)



-   Links should always use keyword-focussed anchor text



[ArmorySEOBestPractices4Content.pdf](https://static.slab.com/prod/uploads/n4300ziu/posts/attachments/sb80Qtt2_zUDwojKsSEhXkTb.pdf)



https://docs.readthedocs.io/en/stable/guides/technical-docs-seo-guide.html
https://idratherbewriting.com/2013/09/22/how-to-search-engine-optimize-your-help-content-or-documentation/
https://www.ditawriter.com/dita-technical-documentation-and-seo/
https://backlinko.com/app/uploads/pdf/seo-this-year.pdf
---
title: GitHub Webhook Approval Tutorial
linktitle: GitHub
exclude_search: true
description: >
  Tutorial
---

## Objectives



## {{% heading "prereq" %}}

- You have read the webhook approval [introductory page]({{< ref "cdaas-webhooks" >}}).
- You are familiar with webhooks in GitHub. See GitHub's [Webhooks and events](https://docs.github.com/en/developers/webhooks-and-events/webhooks/about-webhooks) guide for details.





## GitHub

- Create personal access token in GitHub repo so GH can talk to Borealis
- Register token in Borealis



## Troubleshooting

### `404: Not Found`

```
404 Not Found: [{"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/repos#create-a-repository-dispatch-event"}]', type='org.springframework.web.client.HttpClientErrorException$NotFound', nonRetryable=false
```

This is a confusing error that occurs if the user is not authenticated.
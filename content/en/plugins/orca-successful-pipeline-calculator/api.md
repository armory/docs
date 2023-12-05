---
title: Armory SPE Calculator API Usage
linkTitle: API Usage
weight: 10
description: >
   Learn how to retrieve SPE count using the REST API
---

## {{% heading "prereq" %}}

* You have installed the [Orca SPE Calculator Plugin]({{< ref "/plugins/orca-successful-pipeline-calculator" >}}})
* You're able to call Orca's endpoint service endpoint (by default `http://spin-orca:8083`)

### Path 
`/insights/pipelines/statuses/count`

| Parameter | Type                  | Description                      | Optional | Default Value |
|-----------|-----------------------|----------------------------------|----------|---------------|
| from      | Date (yyyy-MM-dd)     | Starting Date                    | Yes      | 30 days ago   |
| to        | Date (yyyy-MM-dd)     | End Date                         | Yes      | Today         |
| limit     | Number                | Max Number of results            | Yes      | 1000          |
| offsetId  | Number                | Starting Id (Exclusive)          | Yes      | nil           |
| descOrder | Boolean               | Sort results in descending order | Yes      | false         |
| status    | SUCCEEDED \| TERMINAL | Status of the aggregate          | Yes      | SUCCEEDED     |

### Response
## JSON Structure Documentation

### Root Object
| Field   | Type   | Description                          |
|---------|--------|--------------------------------------|
| records | Array  | Array of record objects              |
| limit   | Number | Limit on the number of records       |
| count   | Number | Total number of records              |
| from    | String | Start date for the record collection |
| to      | String | End date for the record collection   |

### Record Object
Each object in the `records` array has the following structure:

| Field  | Type   | Description                                             |
|--------|--------|---------------------------------------------------------|
| id     | Number | Unique identifier of the record                         |
| status | String | Status of the record (e.g., "SUCCEEDED")                |
| date   | Number | Date of the record in milliseconds since epoch          |
| count  | Number | Count associated with the record                        |
| day    | String | The day corresponding to the record (yyyy-MM-dd format) |

## Example

```json
{
    "records": [
        {
            "id": [id],
            "status": "[status]",
            "date": [UNIX milliseconds],
            "count": [count],
            "day": "yyyy-MM-dd"
        },
        ...
    ],
    "limit": [limit],
    "count": [count],
    "from": "yyyy-MM-dd",
    "to": "yyyy-MM-dd"
}

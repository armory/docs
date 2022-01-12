---
title: v1.0.2 Armory Agent Service (2022-01-12)
toc_hide: true
version: 01.00.02

---

Currently if an operation on the agent fail the agent returns a 500 error no matter which type of error it was; for example if the operation fails because of permissions (403 status code) the agent will return the 500 status code.
With this release it is being taking the actual status code error from the response of kubernetes rest api and return it back, so the response will contains the exact status code if an error is presented while performing the operation

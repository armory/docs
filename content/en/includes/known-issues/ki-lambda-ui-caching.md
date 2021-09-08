#### Lambda UI issue

There is a [UI bug](https://github.com/spinnaker/spinnaker/issues/6271) related to the caching agent that prevents Lambda functions from being displayed in the UI when there are no other clusters associated with the Application.  In other words, in order for the function to show up in "Functions" tab, there needs to be a cluster (such as an AWS ASG/EC2 instance) deployed for that application.

**Affected versions**: 2.23.0 (1.23.0) - 2.26.1
**Fixed version**: 2.26.2

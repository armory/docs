
After plugin installation finishes, you need to create an [AWS Simple Notification Service](https://docs.aws.amazon.com/sns/latest/dg/welcome.html) **Standard** topic for your Spinnaker or Armory CD instance. See the AWS SNS [Creating an Amazon SNS topic](https://docs.aws.amazon.com/sns/latest/dg/sns-create-topic.html) for instructions.

In the **Details** section:

* **Type**: Select **Standard**
* **Name**: Create a meaningful name, such as `AWS Event Cache Plugin`

In the **Access policy**  section:

Select **Advanced** and add the following policy:

```json
   {
     "Version": "2008-10-17",
     "Statement": [
       {
         "Sid": "AWSConfigSNSPolicy",
         "Effect": "Allow",
         "Principal": {
            "Service": "config.amazonaws.com"
         },
         "Action": "sns:Publish",
         "Resource": "arn:aws:sns:us-west-2:568975057762:config-topic-568975057762"
         }
     ]
   }
```

Your Spinnaker or Armory CD instance needs to subscribe to the topic you created. See [Subscribing to an Amazon SNS topic](https://docs.aws.amazon.com/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html) for how to create your subscription. **You need your Gate endpoint** when you create the subscription.

* **Protocol**: Select either `HTTP` or `HTTPS` depending on your Gate endpoint.
* **Endpoint**: This is your Gate endpoint.

{{< figure src="/plugins/aws-event-cache/media/sns-step3.png" height="80%" weight="80%" >}}
 
After you create your subscription, you should see it in your AWS SNS **Subscriptions** list. The status should be `Confirmed`. If you don’t see the `Confirmed` after 1 or 2 minutes, ensure your Spinnaker or Armory CD service is running. Verify your Gate endpoint and make sure the plugin installation succeeded.

{{< figure src="/plugins/aws-event-cache/media/sns-step4.png" height="80%" weight="80%" >}}


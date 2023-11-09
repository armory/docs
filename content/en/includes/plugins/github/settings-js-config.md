* `deck.settings-local.js`: Copy the contents of your existing `setting-local.js` to this section. 
Add `githubWorkflow` to the `triggerTypes` array to enable the GitHub Workflow trigger option.
Add `githubEvent` to the `triggerTypes` array to enable the GitHub event trigger option for GitHub Deployment events.

    For example:

    {{< highlight yaml "linenos=table, hl_lines=24-25" >}}
    spec:
      spinnakerConfig:
        profiles:
          spinnaker:
            github:
              plugin:
                accounts: []
            spinnaker:
              extensibility:
                repositories:
                  repository:
                    enabled: true
                    url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
          deck:
            settings-local.js: |
              window.spinnakerSettings = {
                ... (content omitted for brevity)
                triggerTypes: [
                  'artifactory',
                  'concourse',
                  'cron',
                  'docker',
                  'git',
                  'githubWorkflow',
                  'githubEvent',
                  'helm',
                  'jenkins',
                  'nexus',
                  'pipeline',
                  'plugin',
                  'pubsub',
                  'travis',
                  'webhook',
                  'wercker',
                ]
                ... (content omitted for brevity)
            }
    {{< /highlight >}}


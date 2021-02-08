# Overview

This is the repo for Armory documentation (https://docs.armory.io). We welcome contributions from people outside of Armory.

The site is hosted by [Netlify](https://www.netlify.com/), which generates a preview build for every pull request. Install [Hugo](https://gohugo.io/) if you want to compile and run the project locally. The Hugo extended version is specified in `netlify.toml` (currently 0.71.1).

The latest version of the docs website is the `master` branch. Previous releases point to branches that start with `release-`.

The site has built-in support for [Mermaid](https://mermaid-js.github.io/mermaid/), which is a Javascript based diagramming and charting tool that uses Markdown-inspired text definitions and a renderer to create and modify complex diagrams. <i>Diagramming and documentation costs precious developer time and gets outdated quickly. But not having diagrams or docs ruins productivity and hurts organizational learning. Mermaid addresses this problem by cutting the time, effort and tooling that is required to create modifiable diagrams and charts, for smarter and more reusable content. The text definitions for Mermaid diagrams allows for it to be updated easily, it can also be made part of production scripts (and other pieces of code). So less time needs to be spent on documenting, as a separate and laborious task. Even non-programmers can create diagrams through the Mermaid Live Editor.</i>

Mermaid resources:
- [Quick Start](https://mermaid-js.github.io/mermaid/getting-started/n00b-gettingStarted.html)
- [Tutorials](https://mermaid-js.github.io/mermaid/getting-started/Tutorials.html)
- [Mermaid Live Editor](https://mermaid-js.github.io/mermaid-live-editor/) - create your diagrams visually and copy the generated Mermaid code to your page

## Cloning the project

If you work for Armory, see the internal docs for how to contribute content.

People who are not part of the Armory organization need to create a fork of this repo. See the GitHub.com help [docs](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-forks) for how to fork a repo.

Clone your forked repo:

```bash
git clone git@github.com:<github-username>/docs.git
```

Armory docs uses the [Docsy](https://docsy.dev) theme as a submodule. You have to update the submodule if you want to build locally.

```bash
cd docs
git submodule update --init --recursive --depth 1
```

Set this docs repo as the upstream remote:

```bash
git remote add upstream https://github.com/armory/docs.git
```

Confirm your origin and upstream repositories:

```bash
git remote -v
```

Output is similar to:

```bash
origin	git@github.com:<github-username>/docs.git (fetch)
origin	git@github.com:<github-username>/docs.git (push)
upstream	https://github.com/armory/docs.git (fetch)
upstream	https://github.com/armory/docs.git (push)
```

## Update your local repository

Make sure your local repository is current before you start making changes. Fetch commits from your fork's `origin/master` and `spinnaker/spinnaker.github.io`'s `upstream/master`:

   ```bash
   git fetch origin
   git fetch upstream
   ```

## Create a working branch

Make sure you are in your `master` branch before you create your working
branch. You can use `git branch` to see which branch you are in.

```bash
git branch
```

The output lists your local branches. There is an `*` next to the branch you are in.

```bash
working-branch-1
working-branch-2
* master
```

If you are not in `master`, execute `git checkout master` to go to your `master` branch. See the [Understanding history: What is a branch?](https://git-scm.com/docs/user-manual#what-is-a-branch) section of the _Git User Manual_ for more information.

Create a new working branch based on `upstream/master`.

```bash
git checkout -b <your-working-branch> upstream/master
```

Since `git` tracks changes to `upstream\master`, you don't need to rebase your fork before you create a working branch.

Content is in `content/en/docs`. Make your changes to the desired file.

Use the `git status` command at any time to see what files you've changed.

If you have installed [Hugo](https://gohugo.io/getting-started/installing/) and want to preview your changes locally, run from the repo root:

```
hugo server
```

## Commit your changes

Check which files you need to commit:

```bash
git status
```

Output is similar to:

```bash
On branch <your-working-branch>
Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git restore <file>..." to discard changes in working directory)

modified:   content/en/docs/spinnaker/armory-halyard.md

no changes added to commit (use "git add" and/or "git commit -a")
```

Create a commit:

```bash
git commit -a -m "<your-commit-subject>" -m "<your-commit-description>"
```

- `-a`: Commit all staged changes.
- `-m`: Use the given `<your-commit-subject>` as the commit message. If multiple `-m` options are given, their values are concatenated as separate paragraphs.

Your commit messages must be 50 characters or less. Do not use any [GitHub
Keywords](https://help.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword) in your commit message. You can add those to the pull request description later.

Push your working branch and its new commit to your remote fork:

```bash
git push origin <your-working-branch>
```

You can commit and push many times before you create your PR.

## Create your pull request

See the GitHub [docs](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork) for how to create a pull request from a fork.

## Troubleshooting

If you run into a situation where the theme says it's been modified but you and the branch you're working on didn't modify the theme (i.e. you run `git status` and see this:https://s.armory.io/4guJmdAq), try updating the submodules:

```bash
git submodule update --init --recursive
```

## Monitoring

The Armory documentation uses New Relic to monitor the website status and other metrics.

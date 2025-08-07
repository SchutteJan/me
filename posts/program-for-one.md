---
date: 2025-09-15
title: Program for one, Please
---

For those that genuinely love the process of programming it can be a scary thought that crafting code by hand could be
made completely obsolete by AI/LLMs in the near future. Programming like this might just one day turn back into a hobby.
That said, it can also be a blessing not to have to think about every little detail. I've been enjoying how easy it is
to learn new languages and frameworks and find myself validating ideas quickly using LLMs.

There is a particular class of software that is now easier and more fun to build than ever: small, sometimes one-off
programs that are very specialized to you or the situation you're in. One example of such programs is the "new tab" page
in the browser. In the extension marketplace you'll find a million "new tab" extensions with all kinds of designs and
features. Personally I found none that appealing. What you want on that page is super personal, and the chances of finding an
existing extension that has the exact features you want and looks pleasing to you are near zero (unless what you want is
a blank page). Today, to build one yourself you don't even need to have that much free time, your coding agent can build
it for you while you are working on other things.

For my "new tab" page I started with an overview of our open-source repos and their stargazer count (we had recently
gotten a big jump in stars without realizing it and wanted a simple way to monitor that count). Then I added the open
PRs in a table so I can quickly navigate to them. Next up was an hourly weather overview so I know if I need to bring a
jacket when I go out for lunch. And my least creative addition was a "quote of the day" section on top.

<picture>
    <source media="(prefers-color-scheme: light)" srcset="/posts/new-tab-light.webp">
    <source media="(prefers-color-scheme: dark)" srcset="/posts/new-tab-dark.webp">
    <img alt="Screenshot" src="/posts/new-tab-light.webp">
</picture>

The method I found to work best is to keep the project as simple as possible. There are no build steps, linters, tests,
pre-commit hooks, CI/CD, there are no frameworks or even dependencies. All I have is one `index.html`, one font file,
and a few plain Javascript files for each "feature". I set these constraints in the beginning and it seems that it helps
prevent the LLM from over-engineering.

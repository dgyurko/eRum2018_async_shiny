# eRum2018_async_shiny
Shiny demo named "Going async with Shiny" for the eRum 2018 event.

The async version of `Shiny` addresses the blocking behaviour between different user sessions. The blocking persists for the same user, which is an intentional [decision](https://github.com/rstudio/promises/issues/23) by Joe Cheng.

## How the app works?

Buttons simulate processes that run for a certain amount of time either **synchronously**, or **asynchronously**. When tasks are done a `verbatimTextOutput` is rendered, and the background color changes to green for 2 seconds.

![](/images/demo.gif)

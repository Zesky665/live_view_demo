# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "With Phoenix Live View", line_two: "Writing haiku in Real Time", line_three: "Is a piece of cake", author: "Tester_1"})

    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "This is a demo", line_two: "Of my Haiku Writing App", line_three: "For Phoenix Phenzy", author: "Zesky665"})

    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "Visiting a page", line_two: "Updates without refresh", line_three: "It must be LiveView", author: "Mike Buhot"})

    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "Phoenix is real cool", line_two: "Speedy, performant, easy", line_three: "My new go to tool", author: "Steve Albrechtsen"})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

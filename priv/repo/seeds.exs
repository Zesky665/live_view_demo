# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "With Phoenix Live View", line_two: "Writing haiku in Real Time", line_three: "Is a piece of cake", author: "Tester_1"})

    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "With Phoenix Live View", line_two: "Writing haiku in Real Time", line_three: "Is a piece of cake", author: "Tester_2"})

    LiveViewDemo.Repo.insert!(%LiveViewDemo.Poems.Haiku{line_one: "With Phoenix Live View", line_two: "Writing haiku in Real Time", line_three: "Is a piece of cake", author: "Tester_3"})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

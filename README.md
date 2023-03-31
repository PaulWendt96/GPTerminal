## Summary
`ask_gpt.py`   -- thin wrapper around chatGPT. expects input from stdin
`summarize.sh` -- feed article to stdin and gets GPT to summarize it for you
`bugs/bugs`    -- generate a (static) bug-finding prompt for a file. tries to determine file type from an extension mapping.
`fix_failures` -- repo which contains `fix_failing_bash_script`. this is mostly a test idea. the idea is
                  to run a failing bash script and capture the stdout + stderr logs. From there, the
                  script will generate a prompt asking GPT to try and figure out what went wrong. The
                  reason this isn't better is because there are a bunch of ways to ask this question
                  Ideally I'd like a better prompt that always outputs code (e.g. I want to be able to
                  `fix failing_script.sh | ask_gpt > fixed.sh && ./fixed.sh`). If that gets good enough,
                  rename it `fix`
`personalities`
  `opinion.sh` -- I tried to make this an opinionated personality, but it just turns out to be
                  overly excited and happy to comply by the content filter. It also knows full well
                  that it is an AI even though I explicitly tell it to pretend it is human
  `pirate.sh`  -- Prompt generator to add a Pirate flair to ChatGPT's output. Still want to improve
                  the prompt for this one

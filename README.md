## Most important command
`ask_gpt.py`   -- thin wrapper around chatGPT. expects input from stdin. you'll need OPENAI_KEY set as an environment variable

## Bash helpers
`fix`       -- will ask GPT to correct a failing command (this requires rerunning the command + capturing stdout/stderr)
`run`       -- to run GPT's suggested fix
`hang`      -- to get GPT's input on why a command you just ran and had to ctrl+c out of was hanging
`bash_code` -- try to determine a bash code from NLP (e.g. `bash_code "status code"` returns "$?")

## Coding helpers
`bugs`      -- find bugs (`bugs <file> | ask_gpt`)
`explain`   -- explain what a file does (`explain <file> | ask_gpt`)

## Data Engineering Helpers
`guess_column` -- guess the purpose of a column in a table
`guess_schema` -- guess what each column in a table represents
`guess_table`  -- guess the overarching purpose of a table

## Personalities
`personality` -- augment a prompt with a personality, e.g. `echo "say hello" | personality "pretentious intellectual" | ask_gpt`
`prompt_engineer` -- will try to improve a prompt, e.g. `echo "output all responses as a sonnet" | prompt_engineer | ask_gpt`

## Other fun stuff
`recommend` -- give me some unfiltered recommendations, e.g. `echo "vacation destinations" | recommend | ask_gpt`

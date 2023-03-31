## GPTerminal: Interact with ChatGPT through your terminal
This repo contains a number of scripts I use to interact with ChatGPT through my terminal.
I initially did this out of curiosity, but I've found interacting with ChatGPT in the terminal to be very powerful. 

## Setup
1. Get an OpenAI API key. Add it to your environment with the name `OPENAI_KEY`.
2. Symlink the `ask_gpt.py` file to somewhere in your $PATH. The command I ran to do this was:

   `ln -s $(pwd)/ask_gpt.py /usr/local/bin/ask_gpt`

   The command you need to run might vary based on what your PATH looks like.

3. Test the program: echo "hello world" | ask_gpt
4. Run `cat symlink.txt | ./symlinker.sh` to set up neccessary symlinks


## Commands in this repository
### Coding helpers
`bugs`      -- find bugs (`bugs <file> | ask_gpt`)
`explain`   -- explain what a file does (`explain <file> | ask_gpt`)

### Personalities
`personality` -- augment a prompt with a personality, e.g. `echo "say hello" | personality "pretentious intellectual" | ask_gpt`
`prompt_engineer` -- will try to improve a prompt, e.g. `echo "output all responses as a sonnet" | prompt_engineer | ask_gpt`

### Bash helpers
`fix`       -- will ask GPT to correct a failing command (this requires rerunning the command + capturing stdout/stderr)
`run`       -- to run GPT's suggested fix
`hang`      -- to get GPT's input on why a command you just ran and had to ctrl+c out of was hanging
`bash_code` -- try to determine a bash code from NLP (e.g. `bash_code "status code"` returns "$?")


### Other fun stuff
`recommend` -- give me some unfiltered recommendations, e.g. `echo "vacation destinations" | recommend | ask_gpt`


## Other interesting commands
echo "Can you describe the purpose of this repository based on its directory structure?" $(tree)| ask_gpt
echo "What can you tell about me from 250 random lines of my bsah history?" $(history | cut -d " " -f2- | sort | uniq | shuf -n 250) | ask_gpt

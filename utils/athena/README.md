##
Make GPT guess what each column in an Athena table represents

TODO:
  - fold tabledoc.sh and columndoc.sh into one script (can add additional CLI flag for specifying column(s))

```bash
# link everything up
ls *.sh | sed 's/\.sh//g' | xargs -I{} ln -s $(pwd)/{}.sh /usr/local/bin/{}
```

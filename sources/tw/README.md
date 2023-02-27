# Translation Words

All the markdown files are under the bible folder. 
There are three subfolders:
- kt
- names
- other

For each folder, run the script "load.sh" in that folder.
For example:

```sh
cd bible/kt
sh ../../load.sh kt > ../../kt.sql
```

This work is automated in the `run.sh` script. 
It will create a single file of SQL insert statements to 
load the data.
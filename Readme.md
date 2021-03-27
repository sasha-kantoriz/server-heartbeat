1. Create virtual environment: `python3 -m venv .`
2. Install Ansible package: `./bin/pip install -r requirements.txt`
3. Write inventory file
3. Role invokation:

`playbook.yml` contains play that run ansible role on specified hosts
Role contains stages:
- __Setup__: creates directories for logs on remote servers and ansible server (`tags: setup`)
- __Pre__: collects pre-checks logs (`tags: pre`)
- __Patching__: package manager and packages system editions (`tags: patching`)
- __Post__: collects post-checks logs (`tags: post`)
- __Logs__: collects system metrics (`tags: logs`)
- __Fetch__: Downloads logs files from remote servers to ansible server (`tags: fetch`)
- __CSV__: Serializes logs output to CSV files and downloads them to ansible server (`tags: csv`)
- __Diff__: 
Remote logs directories, ansible server logs dir, enabled package manager repos, excluded packages variables can be edited at `vars/main.yml`

All new line symbols(`\n`) in output for each entry in CSV files are replaced with `%%` 

Role invokation: `bin/ansible <playbook.yml> -i <hosts> [--tags <comma separated tags list>]`
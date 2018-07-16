# Sinatra boilerplate
A boilerplate that makes easier to satisfy [The Twelve-Factor App](https://12factor.net)

## I. Codebase
Just keep your codebase tracked within git

## II. Dependencies
Dependencies are handled through bundle

```bash
bundle install --path .bundle
```

## III. Config
Environment variables are handled through dotenv

There are two files to achieve this

`.env.base` tracked. its a file that defines a default value for every env var that your app needs
```bash
LANG=es
```

`.env` not tracked it only exists each deploy and overwrites `.env.base` defined keys
```bash
LANG=en
```

## IV. Backing services
Store URL/credentials in your config

`.env.base`
```bash
MONGO_URL=mongodb://localhost/mydb
```

## V. Build, release, run
Code releases are handled with a bash script `deploy.sh` that creates a folder under a specified release path (defaults to ./releases).

Each code release bundles the current config, source code and gem dependencies into a single unique system folder

```bash
export RELEASE_PATH=<release_path>
./deploy.sh
```

The last deploy will always be accesible via `$RELEASE_PATH/current` which is a soft link to `$RELEASE_PATH/<release-isodatetime>`

**Staging**

stage | location
--- | ---
build stage | `$REPO_PATH`
release stage | `$RELEASE_PATH/<release-isodatetime>`
run stage | `$RELEASE_PATH/current`

## VI. Processes
just follow [it](https://12factor.net/processes)

## VIII. Port binding
within a release/run stage path run

```bash
bundle exec thin -R config.ru -C thin.yml
```

**Note**
`thin.yml` is a thin configuration file that is always present whit the contents of `$REPO_PATH/thin.yml.sample`. to override this config file, create your own `$REPO_PATH/thin.yml`

# Sinatra boilerplate
A boilerplate that makes easier to satisfy [The Twelve-Factor App](https://12factor.net)

## I. Codebase
Just keep your codebase tracked within git

## II. Dependencies
Dependencies are handled through bundle

```bash
bundle install --path .bundle
```

### III. Config
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

# Prettier

As stated on the [official website](https://prettier.io/):

> What is Prettier?
>
> - An opinionated code formatter
> - Supports many languages
> - Integrates with most editors

But most importantly for us, it supports

> [Markdown](https://commonmark.org/), including [GFM](https://github.github.com/gfm) and [MDX v1](https://mdxjs.com/)

# Usage

## Check format

```bash
prettier --check /path/to/docs
```

## Reformat

```bash
prettier --write /path/to/docs
```

# Dockerfile usage

## Building

```bash
docker build . --tag prettier:latest
```

## Running

### Check format

```bash
docker run --rm -v "$(pwd):/work" prettier:latest --check /path/to/docs
```

### Reformat

```bash
docker run --rm -v "$(pwd):/work" prettier:latest --write /path/to/docs
```

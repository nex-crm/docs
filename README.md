# Nex Docs

Public developer documentation and API reference for Nex, built with
[Mintlify](https://mintlify.com/docs).

Nex is where AI workflows become reliable business software — the workflow
execution and context layer for AI-native business operations. This site
documents the Developer API that lets you ingest context, query the knowledge
graph, and ground your own agents in it.

## Layout

- `index.mdx` — landing page
- `api-reference/` — API reference: `introduction.mdx`, `openapi.json`, and
  per-endpoint MDX pages
- `llms.txt` — condensed API reference for LLM consumption
- `docs.json` — Mintlify site configuration and navigation

## Local development

This repo uses **bun** (see `packageManager` in `package.json`). The
`mintlify` CLI is invoked by the scripts and must be installed globally:

```bash
bun install
bun add -g mintlify
```

Preview the site locally (serves at `http://localhost:3000`):

```bash
bun run dev
```

## Other scripts

```bash
bun run validate-openapi   # validate api-reference/openapi.json
bun run update-api-docs    # regenerate endpoint pages from the OpenAPI spec
```

See [API_AUTOMATION.md](API_AUTOMATION.md) for how the OpenAPI-driven pages
are generated and kept in sync.

## Publishing

Pushes to `main` are deployed automatically by Mintlify.

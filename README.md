# Haiku Collection

A growing chronicle of humanity's technological journey, told in seventeen syllables at a time.

Each haiku is pinned to a date and a single word. No explanation is given. The reader is invited to look up what was happening in the world that day and find the connection — or to simply let the poem stand on its own.

## Reading

Browse the [haikus](haikus/) directory by year. Each filename carries a date and a word. That's all the context you get.

## Structure

```
haikus/
  YYYY/
    MM-DD-word.md
```

## Automation note (for agents running scheduled tasks)

This repository is updated by a Cowork scheduled task. The Cowork sandbox mounts this folder over FUSE with a policy that blocks `unlink()`, which leaves git lock files stranded and breaks subsequent git operations. **Before running any git command in the sandbox, source the setup script once per session:**

```bash
source .cowork/setup.sh
```

That activates a thin `git` wrapper (`.cowork/git-safe`) which clears stale locks before and after each git invocation. Outside the Cowork sandbox the setup script is a no-op, so it's safe to source anywhere.

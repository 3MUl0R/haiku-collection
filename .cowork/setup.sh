# Source this in a Cowork sandbox session before doing any git work in this repo.
#
#     source .cowork/setup.sh
#
# It defines `git` as a shell function that routes through .cowork/git-safe,
# which handles the FUSE-mount unlink restriction (see git-safe for details).
#
# The function only activates inside the Cowork sandbox — sourcing this file
# on the user's Mac is a no-op.

# Locate the repo root relative to this script.
_cowork_setup_dir="$( cd "$( dirname "${BASH_SOURCE[0]:-$0}" )" && pwd )"
COWORK_REPO_DIR="$( cd "$_cowork_setup_dir/.." && pwd )"
export COWORK_REPO_DIR

# Detect whether we're running inside the Cowork sandbox. The sandbox uses
# /sessions/<session-id> as $HOME; the user's Mac doesn't.
case "${HOME:-}" in
  /sessions/*)
    _cowork_in_sandbox=1
    ;;
  *)
    _cowork_in_sandbox=0
    ;;
esac

if [ "$_cowork_in_sandbox" = "1" ]; then
  # Define git() as a function that calls the safe wrapper.
  git() {
    "$COWORK_REPO_DIR/.cowork/git-safe" "$@"
  }

  # One-time cleanup of any stale locks left over from previous sessions.
  "$COWORK_REPO_DIR/.cowork/git-safe" --clear-locks-only

  echo "cowork/setup.sh: git wrapper active (sandbox detected)"
else
  echo "cowork/setup.sh: not in Cowork sandbox; no wrapper needed"
fi

unset _cowork_setup_dir _cowork_in_sandbox

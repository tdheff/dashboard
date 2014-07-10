#!/usr/bin/env bash
# Base16 Melon - Mate Terminal color scheme install script
# Tommy Heffernan

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Melon Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-melon-dark"
[[ -z "$DCONFTOOL" ]] && DCONFTOOL=dconf
[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/mate/terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

dset() {
  local key="$1"; shift
  local val="$1"; shift

  "$DCONFTOOL" write "$PROFILE_KEY/$key" "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONFTOOL" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONFTOOL" write "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append /org/mate/terminal/global/profile-list "$PROFILE_SLUG"

dset visible-name "'$PROFILE_NAME'"
dset palette "'#25242e:#c7503e:#317891:#69b0c7:#ABB242:#C2214F:#3ec780:#c0b1a1:#827873:#c7503e:#317891:#69b0c7:#ABB242:#C2214F:#3ec780:#ffeacf'"
dset background-color "'#25242e'"
dset foreground-color "'#c0b1a1'"
dset bold-color "'#c0b1a1'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"

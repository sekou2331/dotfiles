# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  echo "dir = $_dir"
  if [ -d "$_dir" ]; then
      echo "$_dir is a dir"
    if [ -d "$_dir/pre" ]; then
        echo "in pre"
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        echo "that has to source $config"
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      echo "in post"
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        echo "that has to source $config"
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Fish completion script for brew-cask(1)

function __fish_brew_cask_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'cask' ]
    return 0
  end
  return 1
end

function __fish_brew_cask_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_brew_cask_casks
  set -l taps (brew --repository)/Library/Taps
  set -l casks (find $taps -type d -name Casks)
  for caskdir in $casks
    find $caskdir -name "*.rb" -print | sed 's/.rb$//' | sed "s|^.*/||"
  end
end

function __fish_brew_cask_caskroom
  ls /usr/local/Caskroom/
end

function __fish_brew_cask_installed_casks
  cask list -1
end


############
# commands #
############


# audit
complete -f -c cask -n '__fish_brew_cask_needs_command' -a audit -d 'Check casks'
complete -f -c cask -n '__fish_brew_cask_using_command audit' -a '(__fish_brew_cask_casks)'

# cat
complete -f -c cask -n '__fish_brew_cask_needs_command' -a cat -d 'Display cask'
complete -f -c cask -n '__fish_brew_cask_using_command cat' -a '(__fish_brew_cask_casks)'

# cleanup
complete -f -c cask -n '__fish_brew_cask_needs_command' -a cleanup -d 'Clean up cached downloads and tracker symlinks'
complete -f -c cask -n '__fish_brew_cask_using_command cleanup' -l outdated -d 'Only clean up cached downloads older than 10 days old'
complete -f -c cask -n '__fish_brew_cask_using_command cleanup' -a '(__fish_brew_cask_installed_casks)'

# create
complete -f -c cask -n '__fish_brew_cask_needs_command' -a create -d 'Generate a Cask definition file'

# doctor
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'doctor dr' -d 'Check for configuration issues'

# edit
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'edit' -d 'Open cask definition file for editing'
complete -f -c cask -n '__fish_brew_cask_using_command edit' -a '(__fish_brew_cask_casks)'

# fetch
complete -f -c cask -n '__fish_brew_cask_needs_command' -a fetch -d 'Download resources for cask'
complete -f -c cask -n '__fish_brew_cask_using_command fetch' -l force -d 'Force re-download even if the resources are already cached'
complete -f -c cask -n '__fish_brew_cask_using_command fetch' -a '(__fish_brew_cask_casks)'

# help
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'help' -d 'Display help'

# home
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'home homepage' -d 'Open cask\'s homepage'
complete -c cask -n '__fish_brew_cask_using_command home' -a '(__fish_brew_cask_casks)'

# info
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'info abv' -d 'Display information about cask'
complete -c cask -n '__fish_brew_cask_using_command info' -a '(__fish_brew_cask_casks)'

# install
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'install' -d 'Install cask'
complete -f -c cask -n '__fish_brew_cask_using_command install' -l force -d 'Force install'
complete -c cask -n '__fish_brew_cask_using_command install' -a '(__fish_brew_cask_casks)'

# install
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'reinstall' -d 'Reinstalls cask'
complete -f -c cask -n '__fish_brew_cask_using_command install' -l force -d 'Force reinstall'
complete -c cask -n '__fish_brew_cask_using_command install' -a '(__fish_brew_cask_casks)'

# list
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'list ls' -d 'List all installed casks'
complete -f -c cask -n '__fish_brew_cask_using_command list' -s 1 -d 'Always format the output in a single column'
complete -f -c cask -n '__fish_brew_cask_using_command ls' -s 1 -d 'Always format the output in a single column'
complete -f -c cask -n '__fish_brew_cask_using_command list' -s l -d 'Give a more detailed listing'
complete -f -c cask -n '__fish_brew_cask_using_command ls' -s l -d 'Give a more detailed listing'
complete -c cask -n '__fish_brew_cask_using_command list' -a '(__fish_brew_cask_casks)'
complete -c cask -n '__fish_brew_cask_using_command ls' -a '(__fish_brew_cask_casks)'

# search
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'search -S' -d 'Display all casks or search by name'

# uninstall
complete -f -c cask -n '__fish_brew_cask_needs_command' -a 'uninstall remove rm' -d 'Uninstall cask'
complete -f -c cask -n '__fish_brew_cask_using_command uninstall' -a '(__fish_brew_cask_installed_casks)'
complete -f -c cask -n '__fish_brew_cask_using_command remove' -a '(__fish_brew_cask_installed_casks)'
complete -f -c cask -n '__fish_brew_cask_using_command rm' -a '(__fish_brew_cask_installed_casks)'
complete -f -c cask -n '__fish_brew_cask_using_command uninstall' -l force -d 'Uninstall even cask not present'
complete -f -c cask -n '__fish_brew_cask_using_command remove' -l force -d 'Uninstall even cask not present'
complete -f -c cask -n '__fish_brew_cask_using_command rm' -l force -d 'Uninstall even cask not present'

# zap
complete -f -c cask -n '__fish_brew_cask_needs_command' -a zap -d 'Unconditionally remove all files associated with casks'
complete -c cask -n '__fish_brew_cask_using_command zap' -a '(__fish_brew_cask_caskroom)'

# outdated
complete -f -c cask -n '__fish_brew_cask_needs_command' -a outdated -d 'Display all the installed Casks that have newer versions'
complete -c cask -n '__fish_brew_cask_using_command outdated' -a '(__fish_brew_cask_caskroom)'

############
# switches #
############

# --version
complete -f -c cask -n '__fish_brew_cask_needs_command' -l version -d 'displays the Homebrew-Cask version'

# --force
complete -f -c cask -n '__fish_brew_cask_needs_command' -l force -d 'Force install cask even exists'

# --skip-cask-deps
complete -f -c cask -n '__fish_brew_cask_needs_command' -l skip-cask-deps -d 'Skip Cask dependencies when installing'

# --require-sha
complete -f -c cask -n '__fish_brew_cask_needs_command' -l require-sha -d ' Abort Cask installation if the Cask does not have a checksum defined'

# --caskroom
complete -f -c cask -n '__fish_brew_cask_needs_command' -l caskroom -d 'Set  location  of  the  Caskroom, where all binaries are stored'

# --verbose
complete -f -c cask -n '__fish_brew_cask_needs_command' -l verbose -d 'Give additional feedback during installation'

# --appdir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l appdir -d 'Target location for Application links'

# --colorpickerdir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l colorpickerdir -d 'Target location for Color Picker links'

# --prefpanedir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l prefpanedir -d 'Target location for Preference Pane links'

# --qlplugindir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l qlplugindir -d 'Target location for QuickLook Plugin links'

# --dictionarydir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l dictionarydir -d 'Target location for Dictionaries'

# --fontdir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l fontdir -d 'Target location for Font links'

# --servicedir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l servicedir -d 'Target location for Service links'

# --input_methoddir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l input_methoddir -d 'Target location for Input Method links'

# --internet_plugindir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l internet_plugindir -d 'Target location for Internet Plugin links'

# --audio_unit_plugindir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l audio_unit_plugindir -d 'Target location for Audio Unit Plugins'

# --vst_plugindir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l vst_plugindir -d 'Target location for VST Plugins'

# --vst3_plugindir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l vst3_plugindir -d 'Target location for VST3 Plugins'

# --screen_saverdir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l screen_saverdir -d 'Target location for Screen Saver links'

# --no-binaries
complete -f -c cask -n '__fish_brew_cask_needs_command' -l no-binaries -d 'Do not link ahelpera executables to /usr/local/bin'

# --binarydir
complete -f -c cask -n '__fish_brew_cask_needs_command' -l binarydir -d 'Target location for ahelpera executable links'

# --debug
complete -f -c cask -n '__fish_brew_cask_needs_command' -l debug -d 'Output debugging information'

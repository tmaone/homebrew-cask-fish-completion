class CaskFishCompletion < Formula
   desc "Fish completion for the brew-cask command"
   homepage "https://github.com/tmaone/homebrew-cask-fish-completion"
   version '0.0.1'
   url "https://github.com/tmaone/homebrew-cask-fish-completion/archive/#{version}.tar.gz"

   head do
     url "https://github.com/tmaone/homebrew-cask-fish-completion.git"
   end

   bottle :unneeded
   depends_on "fish"

   def install
      fish_function.install "cask.fish"
      fish_completion.install "cask-completion.fish" => "cask.fish"
   end
 end

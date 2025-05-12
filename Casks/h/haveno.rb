cask "haveno" do
  version "1.0.0"
  sha256 "4f19c69f113d2fe51d863cb5bebe5607916f30c76a1c021598b364931c1f7db9"

  url "https://github.com/KewbitXMR/haveno-app/releases/download/v#{version}/Haveno-Multi-Platform-MacOS-Homebrew-v#{version}.zip",
      verified: "github.com/KewbitXMR/haveno-app/"
  name "Haveno"
  desc "Client for the P2P decentralised exchange built on Tor and Monero"
  homepage "https://haveno.com/"

  depends_on macos: ">= :catalina"

  app "Haveno.app"

  preflight do
    system_command "/usr/bin/env",
                   args: ["bash", staged_path.parent/"cask-scripts/install-dependancies.sh"],
                   sudo: true
  end

  postflight do
    system_command "/usr/bin/env",
                   args: ["bash", staged_path.parent/"cask-scripts/start-helpers.sh"]
  end

  uninstall_preflight do
    system_command "/usr/bin/env",
                   args: ["bash", staged_path.parent/"cask-scripts/uninstall-deps.sh"],
                   sudo: true
  end

  zap trash: [
    "~/.haveno",
    "~/Library/Preferences/org.haveno.plist",
  ]
end

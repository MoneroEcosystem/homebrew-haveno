cask "haveno" do
  version "1.0.0"
  sha256 "64d1b7f6bbdd94872a5040ca4146074d9b5e58edb5bd0a5846378bfe9dea8958"

  url "https://github.com/KewbitXMR/haveno-app/releases/download/v#{version}/Haveno-Multi-Platform-MacOS-v#{version}.zip",
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
                   args: ["bash", staged_path.parent/"start-helpers.sh"]
  end

  uninstall_preflight do
    system_command "/usr/bin/env",
                   args: ["bash", staged_path.parent/"scripts/uninstall-deps.sh"],
                   sudo: true
  end

  zap trash: [
    "~/.haveno",
    "~/Library/Preferences/org.haveno.plist",
  ]
end
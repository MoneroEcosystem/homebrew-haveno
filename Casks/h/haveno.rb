cask "haveno" do
  version "1.0.0ls
  "
  sha256 "fca4bbc82bcc64693bdfd5d0de73beb40864ae855ac879ddbb1cf4a476fe2a5a"

  url "https://github.com/KewbitXMR/haveno-app/releases/download/v#{version}/Haveno-Multi-Platform-MacOS-Homebrew-v#{version}.zip",
      verified: "github.com/KewbitXMR/haveno-app/"
  name "Haveno"
  desc "Client for the P2P decentralised exchange built on Tor and Monero"
  homepage "https://haveno.com/"

  depends_on macos: ">= :catalina"

  app "Haveno.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "-r", "com.apple.quarantine", "#{appdir}/Haveno.app"]
  end

  zap trash: [
    "~/Library/Application Support/HavenoX",
    "~/Library/Application Support/com.haveno.haveno",
  ]
end

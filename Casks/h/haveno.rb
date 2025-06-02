cask "haveno" do
  version "1.0.0"
  
  sha256 "d50cca4ccfb48a997acb43d9c77c54138ec062268851a233a39268ab4944e4b9"

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

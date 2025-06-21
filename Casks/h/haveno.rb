cask "haveno" do
  version "1.0.0"
  
  sha256 "c2b48c83773fb56008af87357731febd3d9fa4254d07874dd88eb7e0544fedce"

  url "https://github.com/KewbitXMR/haveno-app/releases/download/v#{version}/haveno-macos-homebrew-cask-v#{version}.zip",
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

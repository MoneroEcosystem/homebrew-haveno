cask "haveno" do
    version "1.0.0"
    sha256 "your_sha256_checksum"
  
    url "https://dist.haveno.com/haveno-app-universal-v1.0.0.tar.gz"
    name "Haveno"
    desc "A P2P decenralised exchange built on Tor and Monero."
    homepage "https://haveno.com"
  
    # Install the .app file
    app "Haveno.app"
  
    # Ensure non-GUI dependencies are installed
    depends_on formula: "haveno-daemon"
  
    # Preflight script to install additional dependencies
    preflight do
      system_command "/usr/bin/env",
                     args: ["bash", "#{staged_path}/scripts/install-dependancies.sh"],
    end
  
    # Postflight script for any additional setup
    postflight do
      system_command "/usr/bin/env",
                     args: ["bash", "#{staged_path}/scripts/post-install.sh"]
    end
  
    # Optional cleanup during uninstall
    uninstall_preflight do
      system_command "/usr/bin/env",
                     args: ["bash", "#{staged_path}/scripts/uninstall-deps.sh"],
                     sudo: true
    end
  
    zap trash: "~/Library/Preferences/com.yourapp.plist"
  end
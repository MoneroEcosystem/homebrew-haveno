class HavenoDaemon < Formula
    desc "Haveno - A client for the peer to peer decentralized exchange daemon for Monero"
    homepage "https://haveno.com"
    url "https://dist.haveno.com/haveno-daemon-v1.0.0.tar.gz"
    sha256 "SHA256_SUM"
    license "AGPL-3.0"
  
    depends_on "openjdk@21"
  
    def install
      libexec.install Dir["*"]
      (bin/"haveno-daemon").write <<~EOS
        #!/bin/bash
        exec java $JAVA_OPTS -jar #{libexec}/haveno-daemon.jar $HAVENO_DAEMON_ARGS "$@"
      EOS
    end
  
    plist_options startup: true
  
    def plist
      <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
          <dict>
            <key>Label</key>
            <string>com.haveno.daemon</string>
            <key>ProgramArguments</key>
            <array>
              <string>#{opt_bin}/haveno-daemon</string>
            </array>
            <key>EnvironmentVariables</key>
            <dict>
              <key>JAVA_OPTS</key>
              <string>$JAVA_OPTS</string>
              <key>HAVENO_DAEMON_ARGS</key>
              <string>$HAVENO_DAEMON_ARGS</string>
            </dict>
            <key>RunAtLoad</key>
            <true/>
            <key>KeepAlive</key>
            <true/>
            <key>StandardErrorPath</key>
            <string>/var/log/haveno-daemon/error.log</string>
            <key>StandardOutPath</key>
            <string>/var/log/haveno-daemon/output.log</string>
          </dict>
        </plist>
      EOS
    end
  
    test do
      system "#{bin}/haveno-daemon", "--version"
    end
  end
  
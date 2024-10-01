class HavenoSeednode < Formula
    desc "Haveno - A peer-to-peer decentralized exchange seednode for Monero"
    homepage "https://haveno.com"
    url "https://dist.haveno.com/haveno-seednode-v1.0.0.tar.gz"
    sha256 "SHA256_SUM"
    license "AGPL-3.0"
  
    depends_on "openjdk@21"
  
    def install
      libexec.install Dir["*"]
      # Seednode 1
      (bin/"haveno-seednode1").write <<~EOS
        #!/bin/bash
        exec java $JAVA_OPTS -jar #{libexec}/haveno-seednode.jar $SEEDNODE1_EXECUTION_ARGS "$@"
      EOS
      # Seednode 2
      (bin/"haveno-seednode2").write <<~EOS
        #!/bin/bash
        exec java $JAVA_OPTS -jar #{libexec}/haveno-seednode.jar $SEEDNODE2_EXECUTION_ARGS "$@"
      EOS
    end
  
    plist_options startup: true
  
    def plist
      <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
          <dict>
            <!-- Seednode 1 -->
            <key>Label</key>
            <string>com.haveno.seednode1</string>
            <key>ProgramArguments</key>
            <array>
              <string>#{opt_bin}/haveno-seednode1</string>
            </array>
            <key>EnvironmentVariables</key>
            <dict>
              <key>JAVA_OPTS</key>
              <string>$JAVA_OPTS</string>
              <key>SEEDNODE1_EXECUTION_ARGS</key>
              <string>$SEEDNODE1_EXECUTION_ARGS</string>
            </dict>
            <key>RunAtLoad</key>
            <true/>
            <key>KeepAlive</key>
            <true/>
            <key>StandardErrorPath</key>
            <string>/var/log/haveno-seednode1/error.log</string>
            <key>StandardOutPath</key>
            <string>/var/log/haveno-seednode1/output.log</string>
  
            <!-- Seednode 2 -->
            <key>Label</key>
            <string>com.haveno.seednode2</string>
            <key>ProgramArguments</key>
            <array>
              <string>#{opt_bin}/haveno-seednode2</string>
            </array>
            <key>EnvironmentVariables</key>
            <dict>
              <key>JAVA_OPTS</key>
              <string>$JAVA_OPTS</string>
              <key>SEEDNODE2_EXECUTION_ARGS</key>
              <string>$SEEDNODE2_EXECUTION_ARGS</string>
            </dict>
            <key>RunAtLoad</key>
            <true/>
            <key>KeepAlive</key>
            <true/>
            <key>StandardErrorPath</key>
            <string>/var/log/haveno-seednode2/error.log</string>
            <key>StandardOutPath</key>
            <string>/var/log/haveno-seednode2/output.log</string>
          </dict>
        </plist>
      EOS
    end
  
    test do
      system "#{bin}/haveno-seednode1", "--version"
      system "#{bin}/haveno-seednode2", "--version"
    end
  end
  
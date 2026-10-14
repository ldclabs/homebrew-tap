cask "dmsg-desktop" do
  version "0.1.0"
  sha256 "4149a162b837c965942238444c4eea09c2ff8620e34d04070ad6399dbc69bdbe"

  url "https://github.com/ldclabs/ic-panda/releases/download/dmsg-v#{version}/dMsg-mac-arm64.dmg"
  name "dMsg"
  desc "Desktop workspace and approvals for dMsg"
  homepage "https://dmsg.net"

  auto_updates true
  depends_on arch: :arm64
  depends_on formula: "dmsg"
  depends_on :macos

  app "dMsg.app"

  # The formula's dmsg owns the daemon and its login registration; ~/.dmsg
  # holds the vault and stays.
  zap trash: [
    "~/Library/Application Support/dMsg",
    "~/Library/Logs/dMsg",
    "~/Library/Preferences/net.dmsg.desktop.plist",
    "~/Library/Saved Application State/net.dmsg.desktop.savedState",
  ]
end

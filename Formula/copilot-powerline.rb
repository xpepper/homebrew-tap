class CopilotPowerline < Formula
  desc "A fast, customizable powerline status line for GitHub Copilot CLI"
  homepage "https://github.com/xpepper/copilot-powerline"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.7.1/copilot-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "2443f523948f19a30fa5e4b5109f67b06200ef1ed61ffa916174813570981459"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.7.1/copilot-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "5b587d803f627fb72c85385ef3e8f6e2e7fb2199aab4ee3ee220fbb2eb28d900"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.7.1/copilot-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d9c1d6726ce54547698003340cbca46ccce4a7e1e000e2ebc28825c2b79a114"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.7.1/copilot-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2951d02237988e173bb89c1ce5bcbae33b8669d69457816740c433dc8484a8fe"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "copilot-powerline"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "copilot-powerline"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "copilot-powerline"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "copilot-powerline"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

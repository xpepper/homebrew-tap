class CopilotPowerline < Formula
  desc "A fast, customizable powerline status line for GitHub Copilot CLI"
  homepage "https://github.com/xpepper/copilot-powerline"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.12.0/copilot-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "4da3116f6aefc8d561f19349c97c4082418aa8e7de820ba128b03d8fa9454e35"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.12.0/copilot-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "f67ae1b3be0f88e8804ffd043a7d7eaf6136150967251d2a919035997864956c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.12.0/copilot-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "004954532691ae633f48e979dc4f72732c8db23f21a975944b2f722d607cb218"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.12.0/copilot-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3e55d6d5ebe2165a6c9a0e5241adfafaa8305d63e521721330a1b0ba9badc625"
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

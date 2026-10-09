class CopilotPowerline < Formula
  desc "A fast, customizable powerline status line for GitHub Copilot CLI"
  homepage "https://github.com/xpepper/copilot-powerline"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.5.0/copilot-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "5203ecb47a90a7c5a1e3f74231dfd2d43710ba75c1264f5de5b4d1f07c30de53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.5.0/copilot-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "eeda60c892299d171d9806643ae4f0535515d97a7c7f08d7fdfc47980212e3aa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.5.0/copilot-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0ba9b7530ae063eb078bbbda7552540315a04ec8d424bae60a245163e2b0e726"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.5.0/copilot-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ab0101228534a65658402e200319e4c2bf208339db292105cb312301d7ec7b1"
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

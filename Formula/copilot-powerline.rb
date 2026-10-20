class CopilotPowerline < Formula
  desc "A fast, customizable powerline status line for GitHub Copilot CLI"
  homepage "https://github.com/xpepper/copilot-powerline"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.13.0/copilot-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "e9d77c581b101be45461504e0644c453a449b0ca3cd156f67d346401a8233914"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.13.0/copilot-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "5a400cd6c316319f1afed4a03404e18ada9084e3646f7dccabd182e605b3ad0a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.13.0/copilot-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7bf22035e9613028fcfead3e908254a7fdfe26796c6a8201aa4d88d49490edd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.13.0/copilot-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "39d98309402b05fc680a84c515fd1ea55dfa6082e170c3c0924e3f1e3addabb4"
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

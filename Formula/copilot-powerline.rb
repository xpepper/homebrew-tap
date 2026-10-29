class CopilotPowerline < Formula
  desc "A fast, customizable powerline status line for GitHub Copilot CLI"
  homepage "https://github.com/xpepper/copilot-powerline"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.14.0/copilot-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "e606b398d5492ef658c0d9198028ab28f18c4fde85e97cd6b7dce9de8222336b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.14.0/copilot-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "755d81f5bb684776c8e10a0fdd966124d1a7aee3c2a7ef9a38aefb055f2fe504"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.14.0/copilot-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa5b8ec261a8f84573da71cb0cc7c7b3702be6d4352db8a07ea275450c2372c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/copilot-powerline/releases/download/v0.14.0/copilot-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c1dc8476c64ccd8a474524eb88f4eb59c4552a90b1a1c0f704ce88fd349398a3"
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

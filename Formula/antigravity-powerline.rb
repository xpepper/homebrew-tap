class AntigravityPowerline < Formula
  desc "A fast, customizable powerline status line for Google Antigravity CLI"
  homepage "https://github.com/xpepper/antigravity-powerline"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/antigravity-powerline/releases/download/v0.3.0/antigravity-powerline-aarch64-apple-darwin.tar.xz"
      sha256 "768fe895dcb9e6552320e110bd572668d37f4264807d1508656680709f724522"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/antigravity-powerline/releases/download/v0.3.0/antigravity-powerline-x86_64-apple-darwin.tar.xz"
      sha256 "60e6d614cbd3fe3297a9bb1477e275e298bb2d99a196cb119ef5a5f1fbb8e8bb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xpepper/antigravity-powerline/releases/download/v0.3.0/antigravity-powerline-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e967ef345d8abfce42e3ace2c32885d96c36fa657fadc66c6fae516a92082eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xpepper/antigravity-powerline/releases/download/v0.3.0/antigravity-powerline-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ce4b518c596e875175a074990c33e83d5374278329f19784b13e118b752b58a"
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
      bin.install "antigravity-powerline"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "antigravity-powerline"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "antigravity-powerline"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "antigravity-powerline"
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

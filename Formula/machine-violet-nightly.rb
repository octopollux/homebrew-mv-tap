class MachineVioletNightly < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.1.0-nightly.20261120-0613"

  license "MIT"

  conflicts_with "machine-violet", because: "both install the machine-violet executable"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "727efc05dd52eedf930cb345b1ecf34c50d6dfc99402e05d5c47676379877080"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "f26704087833b61f5430b8a18b5e73e0a29cbaa304618aa8122991ac25dfdf11"
    end
  end

  def install
    # Install the whole extracted tree. The binary resolves prompts/,
    # themes/, systems/, worlds/, personalities/, config/, assets/,
    # the vendored codex/ runtime and node_modules/ (sharp) relative
    # to its own location, and reads version.json for --version.
    # Cherry-picking a subset silently breaks those at runtime —
    # notably ChatGPT sign-in, which spawns codex/vendor/.../bin/codex.
    libexec.install Dir["*"]

    chmod 0755, libexec/"MachineViolet"
    # Expose as lowercase `machine-violet` for CLI convention.
    # A symlink (not write_env_script) keeps process.execPath pointing
    # into libexec, which is what the colocated asset + codex lookups
    # resolve against.
    bin.install_symlink libexec/"MachineViolet" => "machine-violet"
  end

  test do
    assert_match "MachineViolet", shell_output("#{bin}/machine-violet --version")
  end
end

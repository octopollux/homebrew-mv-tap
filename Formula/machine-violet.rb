class MachineViolet < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.1.1"
  version_scheme 1
  license "MIT"

  conflicts_with "machine-violet-nightly", because: "both install the machine-violet executable"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/v1.1.1/machine-violet-1.1.1-darwin-arm64.tar.gz"
      sha256 "3f5048202f1297b2449cb92b298c22f7e09a2a3889b73fb2f55a9764c718069c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/v1.1.1/machine-violet-1.1.1-linux-x64.tar.gz"
      sha256 "7b8d9d5f39a8f3d82e67af06a87e78dd6845f92f1015c86b8d4aa5cd9f7d813b"
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

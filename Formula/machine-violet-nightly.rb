class MachineVioletNightly < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.1.0-nightly.20261018-0619"

  license "MIT"

  conflicts_with "machine-violet", because: "both install the machine-violet executable"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "dc51f09d73924d8af4b9b3a6d8e65d2ed47d4c3366b74f69696590b2bd274581"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "7d7a8b8c273f13a63d36c37b4234bdc62e27762bd3e47ef47fb01f257d17c971"
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

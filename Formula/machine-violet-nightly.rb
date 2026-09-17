class MachineVioletNightly < Formula
  desc "AI Dungeon Master for tabletop RPGs"
  homepage "https://github.com/octopollux/machine-violet"
  version "1.1.0-nightly.20260917-0623"

  license "MIT"

  conflicts_with "machine-violet", because: "both install the machine-violet executable"

  on_macos do
    on_arm do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-darwin-arm64.tar.gz"
      sha256 "a93d7584d77f3a4898e61bc13fe0ce787aff63e7e2835e3fc4d919452326ac08"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/octopollux/machine-violet/releases/download/nightly/machine-violet-nightly-linux-x64.tar.gz"
      sha256 "97a751786a70158d5f134e69f5df825098fdacc9402447b86d58c3b91fce0996"
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

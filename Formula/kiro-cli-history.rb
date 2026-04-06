class KiroCliHistory < Formula
  desc "Terminal UI for fuzzy-searching, browsing, and resuming Kiro CLI conversations"
  homepage "https://github.com/prabhugr/kiro-cli-history"
  url "https://github.com/prabhugr/kiro-cli-history/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cd13c46ff971694e69201577cf9506980ae4ce5ae97f9dc44852f8280166eb23"
  license "MIT"

  depends_on "python@3"

  def install
    libexec.install "kiro_history.py"

    (bin/"kiro-cli-history").write <<~EOS
      #!/usr/bin/env python3
      import os, sys
      sys.path.insert(0, "#{libexec}")

      try:
          from kiro_history import main
      except ImportError:
          print("Missing dependency: textual")
          print("Run: pip3 install textual")
          sys.exit(1)

      main()
    EOS
    chmod 0755, bin/"kiro-cli-history"
  end

  def caveats
    <<~EOS
      kiro-cli-history requires the 'textual' Python package:
        pip3 install textual
    EOS
  end

  test do
    system "true"
  end
end

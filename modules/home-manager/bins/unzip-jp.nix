{pkgs, ...}:

pkgs.writeShellScriptBin "unar-jp" ''
#!/bin/bash
${pkgs.unar}/bin/unar -e Shift_JIS "$1"
''

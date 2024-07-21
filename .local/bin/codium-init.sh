#!/bin/bash

# List of extensions to be installed
extensions=(
    "streetsidesoftware.code-spell-checker"
    "file-icons.file-icons"
    "ms-toolsai.jupyter"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-slideshow"
    "jeffersonqin.latex-snippets-jeff"
    "james-yu.latex-workshop"
    "hamza-aziane.obsidian-dark"
    "lucasfa.octaveexecution"
    "ms-python.python"
)

# Check if code (VS Code) or codium (VSCodium) is installed
if command -v code > /dev/null; then
    editor_cmd="code"
elif command -v codium > /dev/null; then
    editor_cmd="codium"
else
    echo "Visual Studio Code or VSCodium is not installed or not in the PATH."
    exit 1
fi

# Install each extension
for ext in "${extensions[@]}"; do
    echo "Installing $ext..."
    $editor_cmd --install-extension "$ext"
done

echo "All extensions have been installed."

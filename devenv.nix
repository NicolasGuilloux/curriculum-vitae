{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [ 
    git
    claude-code
    gh
  ];

  # https://devenv.sh/languages/
  languages.texlive.enable = true;
  languages.texlive.packages = [
    # Packages actually required by awesome-cv template
    "enumitem"
    "xifthen" 
    "xstring"
    "ifmtarg"
    "fontawesome6"
    "sourcesanspro" 
    "tcolorbox"
    "roboto"
    "tikzfill"
    "geometry"
    "fancyhdr" 
    "xcolor"
    "ragged2e"
    "fontspec"
    "unicode-math"
    "lualatex-math"
    "parskip"
    "hyperref"
    "bookmark"
    "setspace"
    "etoolbox"
    "currfile"
    "datenumber"
  ];

  # https://devenv.sh/scripts/
  scripts.build.exec = ''
    if [ ! "$1" ]; then
      echo "This script requires the filepath"
      exit 1
    fi

	  mkdir -p ./build
    export SOURCE_DATE_EPOCH=$(date +%s -r $1)
	  lualatex --interaction=nonstopmode --halt-on-error --output-directory=./build $1
  '';

  scripts.build_all.exec = ''
    echo "Building the regular CV"
    build ./src/cv/NicolasGuilloux_CV.tex

    echo "Building the anonymized CV"
    build ./src/cv/NicolasGuilloux_CV_anonymized.tex
    
    echo "Building the Skills sheet"
    build ./src/skills_sheet/skills_sheet.tex
  '';


  scripts.create_tag.exec = ''
    TAG_NAME=$(date +%F)
    echo "Creating $TAG_NAME"
    git tag -d $TAG_NAME &> /dev/null
    git tag $TAG_NAME
    git push origin $TAG_NAME -f
  '';

  enterShell = ''
    echo "#####################################"
    echo "# Nicolas Guilloux's CV environment #"
    echo "#####################################"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks.latexindent.enable = true;
  git-hooks.hooks.latexindent.settings.flags = "-c ./build/latexindent/";

  # See full reference at https://devenv.sh/reference/options/
}

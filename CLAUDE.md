# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX-based curriculum vitae (CV) project using the Awesome CV template. The repository maintains both a personal website (Hugo-based) and a professional CV in LaTeX format. The primary focus is on the CV generation system.

## Build System

The project uses devenv.sh (Nix-based development environment) for dependency management and build automation.

### Core Commands

- **Build CV**: `devenv shell build_cv` - Compiles the LaTeX CV to PDF using lualatex
- **Enter development shell**: `devenv shell` - Loads the development environment with all dependencies

### Build Process Details

The build process:
1. Creates a `./build` directory
2. Compiles `NicolasGuilloux_CV.tex` using lualatex with specific flags:
   - `--interaction=nonstopmode` - Non-interactive mode
   - `--halt-on-error` - Stop on first error
   - `--output-directory=./build` - Output to build directory

## Project Structure

### LaTeX CV System
- `NicolasGuilloux_CV.tex` - Main CV document (French)
- `NicolasGuilloux_CV_anonymized.tex` - Anonymized version (French)
 wan- `resume/` directory contains modular CV sections:
  - `experience.tex` - Professional experience
  - `education.tex` - Educational background  
  - `projects.tex` - Projects
  - `extracurricular.tex` - Extra activities
  - `skills.tex` - Technical skills
- `build/` - Generated PDF output directory

## Development Environment

The project uses devenv.sh with:
- TexLive with latexmk package
- Git integration
- Claude Code CLI tool pre-installed

## CI/CD

### GitHub Actions
- **Build workflow** (`.github/workflows/build.yml`): Triggers on pushes/PRs to CV-related branches
- **Release workflow** (`.github/workflows/release.yml`): Creates releases when CV tags are pushed
- Both workflows use Nix/devenv for consistent builds and upload PDF artifacts

### Branch Strategy
- CV work happens on: `curriculum-vitae` branch and branches matching `cv/**` or `cv_**`
Other branches should be ignored as they are orphans. 

## Known Issues and Solutions

### Document Configuration
- Main CV uses `libs/awesome-cv/awesome-cv` document class (note: this references the git submodule path)
- The template supports both French (`\usepackage[french]{babel}`) and other languages
- Custom page margins are configured via geometry package

## Key Configuration Files

- `devenv.nix` - Development environment configuration with TexLive Full and build scripts
- `devenv.yaml` - devenv.sh project settings  
- `.gitmodules` - Git submodule configuration for awesome-cv template
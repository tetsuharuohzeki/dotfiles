package main

import (
	"errors"
	"flag"
	"log"
	"os"
	"path/filepath"
	"runtime"
)

type pathPair struct {
	Source string
	Link   string
}

type config struct {
	Source      string
	Link        string
	IsXdgConfig bool
}

var isClean bool
var isDryRun bool
var useBash bool

func main() {
	flag.BoolVar(&isClean, "clean", false, "clean links which are set up by this script")
	flag.BoolVar(&isDryRun, "dry-run", false, "dry-run")
	flag.BoolVar(&useBash, "enable-bash", false, "Create a link for bash configration")
	flag.Parse()

	list := []config{
		{"git/.gitconfig", ".gitconfig", false},
		{"git/.gitignore_global", ".gitignore_global", false},
		{"ssh/", ".ssh/", false},
		{"mercurial/.hgrc", ".hgrc", false},
		{"mercurial/.hgignore_global", ".hgignore_global", false},
		{"zsh/.zshrc", ".zshrc", false},
		{"zsh/.zprofile", ".zprofile", false},
		{"zsh/.zshenv", ".zshenv", false},
		{"zsh/zfunc", ".zfunc", false},
	}

	if useBash {
		list = append(
			list,
			config{"bash/.bash_profile", ".bash_profile", false},
			config{"bash/.bashrc", ".bashrc", false},
		)
	}

	const platformSpecificGitConfig = ".gitconfig_os"
	switch runtime.GOOS {
	case "darwin":
		list = append(list, config{"git/.gitconfig_darwin", platformSpecificGitConfig, false})
	default:
		list = append(list, config{"git/.gitconfig_empty", platformSpecificGitConfig, false})
	}

	run(list)
}

func run(manifest []config) {
	if isDryRun {
		log.Println("### This is running as dry-run mode. This will not cause any actual change. ###")
	}

	cwd, err := getCwd()
	if err != nil {
		log.Fatal(err)
		return
	}

	home, err := getHome()
	if err != nil {
		log.Fatal(err)
		return
	}

	xdgConfigHome := getXdgConfigHome()

	log.Printf("$HOME: %v", home)
	log.Printf("$XDG_CONFIG_HOME: %v", xdgConfigHome)

	list := make([]pathPair, len(manifest))

	for i, v := range manifest {
		var path pathPair
		if v.IsXdgConfig {
			path = *resolvePath(cwd, xdgConfigHome, &v)
		} else {
			path = *resolvePath(cwd, home, &v)
		}
		list[i] = path
	}

	notFound := false
	for _, path := range list {
		if !isFileExists(path.Source) {
			notFound = true
			log.Printf("Error: not found a source: %v", path.Source)
		}
	}

	if notFound {
		return
	}

	for _, path := range list {
		rmSymlink(&path, isDryRun)
	}

	if !isClean {
		// We need reverse traversal to handle the following case:
		//
		// ```
		// - bar/
		//   - foo.txt
		// ```
		//
		// If the manifest is `["foo.txt", "bar"]`,
		// then, the removing order is foo.txt -> bar.
		// But if we symlink with the order which is same with removing,
		// we might not be able to link to foo.txt because there has not been linked to bar yet.
		l := len(list)
		for i := range list {
			path := list[(l-1)-i]
			createSymlink(&path, isDryRun)
		}
	}
}

func getCwd() (string, error) {
	c, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	cwd, err := filepath.Abs(c)
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	return cwd, nil
}

const xdgConfigHomeEnvKey = "XDG_CONFIG_HOME"

func getXdgConfigHome() string {
	v := os.Getenv(xdgConfigHomeEnvKey)
	if v == "" {
		log.Println("try to use `~/.config` as $XDG_CONFIG_HOME")

		home, err := getHome()
		if err != nil {
			log.Fatal(err)
		}

		l, err := filepath.Abs(home + "/.config")
		if err != nil {
			log.Fatal(err)
		}

		v = l
	}

	path, err := filepath.Abs(v)
	if err != nil {
		log.Fatal(err)
	}

	return path
}

func getHome() (string, error) {
	isWin := runtime.GOOS == "windows"
	var HomeKey string
	if isWin {
		HomeKey = "USERPROFILE"
	} else {
		HomeKey = "HOME"
	}

	h := os.Getenv(HomeKey)
	home, err := filepath.Abs(h)
	if home == "" {
		err = errors.New("not found $" + HomeKey)
	}

	return home, err
}

func resolvePath(cwd string, home string, t *config) *pathPair {
	f, err := filepath.Abs(cwd + "/" + t.Source)
	if err != nil {
		log.Fatal(err)
		return nil
	}

	l, err := filepath.Abs(home + "/" + t.Link)
	if err != nil {
		log.Fatal(err)
		return nil
	}

	return &pathPair{
		Source: f,
		Link:   l,
	}
}

func rmSymlink(t *pathPair, isDryRun bool) bool {
	if !isDryRun {
		if err := os.Remove(t.Link); err != nil {
			log.Printf("Error: %v", err)
			return false
		}
	}

	log.Printf("Remove: %v", t.Link)
	return true
}

func createSymlink(t *pathPair, isDryRun bool) bool {
	if !isDryRun {
		if err := os.Symlink(t.Source, t.Link); err != nil {
			log.Printf("Error: %v", err)
			return false
		}
	}

	log.Printf("Create symlink (link -> source): %v -> %v", t.Link, t.Source)
	return true
}

func isFileExists(filename string) bool {
	_, err := os.Stat(filename)
	return err == nil
}

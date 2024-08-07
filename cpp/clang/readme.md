# How to setup clang in your project
To begin with, these configs are based on clang tools 17+ versions, so in order to work with it you should update your clang tools (For installation example in docker you can refer to [reach-tools](https://github.com/emlid/reach-tools/blob/master/docker/Dockerfile)) project).

Next, you should add code-quality as a submodule in the root of your project
```bash
git submodule add git@github.com:emlid/code-quality.git code-quality
```

To launch checks you can use scripts with providing directories to check like that:
```bash
./code-quality/cpp/clang/clang-tidy.sh --include-dirs="include src examples"
```

Also you can use `--exclude-dirs` in case you want to ignore directories:
```bash
./code-quality/cpp/clang/clang-format.sh --include-dirs="include src examples" --exclude-dirs="include/stash"
```

To fully automize the process you can setup your `Makefile` like that:
```bash
clang-tidy: CMAKE_FLAGS += -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
clang-tidy: all
	./code-quality/cpp/clang/clang-tidy.sh --include-dirs="include src examples"

clang-format:
	./code-quality/cpp/clang/clang-format.sh --include-dirs="include src examples"

clang-format-fix:
	./code-quality/cpp/clang/clang-format.sh --fix --include-dirs="include src examples"
```

Again, for a full setup example you can see [reach-tools](https://github.com/emlid/reach-tools) project. In case of questions do not hesitate to ask `@aleksandr.kovalenok` in Slack.

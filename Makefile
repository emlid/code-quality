FE_NODE_ESLINT_DEPENDENCIES := @vue/cli-plugin-eslint @vue/eslint-config-typescript eslint-config-airbnb-base
FE_NODE_STYLELINT_DEPENDENCIES := stylelint-config-standard

hint:
	( \
		echo "Actions:"; \
		echo "  make fe – link front end configuration files to the root of the project"; \
	)

.PHONY: fe
fe:
	( \
		npm install --prefix ../ --save-dev $(FE_NODE_ESLINT_DEPENDENCIES) $(FE_NODE_STYLELINT_DEPENDENCIES); \
		echo "npm dependencies successfully installed"; \
		ln fe/.stylelintrc ../.stylelintrc; \
		ln fe/.eslintrc.js ../.eslintrc.js; \
		ln fe/.editorconfig ../.editorconfig; \
		echo "Front end configuration files are successfully linked!"; \
	)

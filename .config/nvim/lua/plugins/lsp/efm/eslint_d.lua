return {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true,
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	rootMarkers = { ".eslintrc.js", ".eslintrc.json" },
}
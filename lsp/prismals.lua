return {
    cmd = { "prisma-language-server", "--stdio" },
    filetypes = { "prisma" },
    root_markers = { ".git", "package.json" },
    settings = {
        prisma = {
            prismaFmtBinPath = "",
            prismaSchemaPath = "prisma/schema.prisma",
        },
    },
}

-- автодополнение: blink.cmp (стандарт LazyVim). Obsidian-ссылки и теги приходят через LSP-источник.
-- Перенесено из старого nvim-cmp конфига: <C-j>/<C-k> для навигации по списку.
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
    },
  },
}

return {
  {
    "nvim-lua/plenary.nvim",
    config = function()
      vim.api.nvim_create_user_command("GenCommitMsg", function()
        local out = vim.fn.systemlist("~/bin/gen-commit-msg 2>/dev/null")
        if vim.v.shell_error ~= 0 then
          vim.notify(table.concat(out, "\n"), vim.log.levels.ERROR)
          return
        end
        if vim.bo.filetype == "gitcommit" then
          vim.api.nvim_buf_set_lines(0, 0, 1, false, { out[1] })
        else
          vim.api.nvim_put(out, "l", true, true)
        end
        vim.notify("Commit message generated.")
      end, {})

      vim.keymap.set("n", "<leader>gc", ":GenCommitMsg<CR>", {
        silent = true,
        desc = "Generate commit message via OpenRouter",
      })
    end,
  },
}

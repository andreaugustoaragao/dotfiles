local function print_filetype()
    local filetype = vim.bo.filetype
    if filetype and filetype ~= '' then
        --  print("File type: " .. filetype)
    else
        -- print("No file type detected")
    end
end

return { print_filetype = print_filetype }

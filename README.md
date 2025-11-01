# deepl.nvim

A Neovim plugin for translating text in-place using the DeepL API. Select any text in your editor and translate it instantly without leaving your workflow.

## Requirements

- Neovim >= 0.7.0
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) (for `plenary.curl`)
- [curl](https://curl.se/) available in your $PATH
- DeepL API key (see [DeepL API](https://www.deepl.com/en/products/api))

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "alassek/deepl.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    api_token = os.getenv("DEEPL_API_TOKEN"),
  }
}
```

## Configuration

### Setup Options

```lua
require('deepl').setup({
  api_token = '',                   -- Your DeepL API token (required)
  target_lang = 'EN-US',            -- Default target language
  model_type = 'quality_optimized', -- Translation model type
  formality = 'default',            -- Formality level
})
```

### Available Options

#### Target Languages

Supported target languages include:
- `EN-US` - English (American)
- `EN-GB` - English (British) 
- `DE` - German
- `FR` - French
- `ES` - Spanish
- `IT` - Italian
- `JA` - Japanese
- `ZH-HANS` - Chinese (Simplified)
- `ZH-HANT` - Chinese (Traditional)

See the [DeepL API documentation](https://developers.deepl.com/docs/getting-started/supported-languages) for the
complete list.

#### Model Types

- `quality_optimized`
- `prefer_quality_optimized`
- `latency_optimized`

#### Formality Levels

- `default`
- `more`
- `less`
- `prefer_more`
- `prefer_less`

## Usage

### Basic Translation

1. Select text in visual mode (`v`, `V`, or `Ctrl-v`)
2. Run `:Translate` to translate to your default target language
3. The selected text will be replaced with the translation

### Specify Source Language

If DeepL can't detect the source language correctly, specify it manually:

```vim
:Translate DE
```

This tells DeepL that the source text is in German.

### Interactive Configuration

Use the `:DeepL` command to access configuration menus:

```vim
:DeepL                " Open main configuration menu
:DeepL target_language " Directly open target language selection
:DeepL model          " Directly open model type selection  
:DeepL formality      " Directly open formality selection
```

### Buffer-Local Settings

Interactive configuration will set buffer-local settings. This means if you switch buffers you will revert to the global
configuration. Global settings can be updated dynamically via `vim.g.deepl_formality` etc.

```lua
-- Change target language globally
vim.g.deepl_target_language = "FR"

-- Set for current buffer only
vim.b.deepl_formality = "more"
vim.b.deepl_model_type = "latency_optimized"
```

## API Token Setup

### DeepL Free vs Pro

The plugin automatically detects your account type based on your API token:
- Free API tokens end with `:fx` 
- Pro API tokens don't have this suffix

### Environment Variable (Recommended)

For security, store your API token in an environment variable:

```bash
export DEEPL_API_TOKEN="your-token-here"
```

Then in your Neovim config:

```lua
api_token = os.getenv("DEEPL_API_TOKEN")
```

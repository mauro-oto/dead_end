## HEAD (unreleased)

## 1.0.1

- Fix performance issue when evaluating multiple block combinations (https://github.com/zombocom/dead_end/pull/35)

## 1.0.0

- Gem name changed from `syntax_search` to `dead_end` (https://github.com/zombocom/syntax_search/pull/30)
- Moved `syntax_search/auto` behavior to top level require (https://github.com/zombocom/syntax_search/pull/30)
- Error banner now indicates when missing a `|` or `}` in addition to `end` (https://github.com/zombocom/syntax_search/pull/29)
- Trailing slashes are now handled (joined) before the code search (https://github.com/zombocom/syntax_search/pull/28)

## 0.2.0

- Simplify large file output so minimal context around the invalid section is shown (https://github.com/zombocom/syntax_search/pull/26)
- Block expansion is now lexically aware of keywords (def/do/end etc.) (https://github.com/zombocom/syntax_search/pull/24)
- Fix bug where not all of a source is lexed which is used in heredoc detection/removal (https://github.com/zombocom/syntax_search/pull/23)

## 0.1.5

- Strip out heredocs in documents first (https://github.com/zombocom/syntax_search/pull/19)

## 0.1.4

- Parser gem replaced with Ripper (https://github.com/zombocom/syntax_search/pull/17)

## 0.1.3

- Internal refactor (https://github.com/zombocom/syntax_search/pull/13)

## 0.1.2

- Codeblocks in output are now indented with 4 spaces and "code fences" are removed (https://github.com/zombocom/syntax_search/pull/11)
- "Unmatched end" and "missing end" not generate different error text instructions (https://github.com/zombocom/syntax_search/pull/10)

## 0.1.1

- Fire search on both unexpected end-of-input and unexected end (https://github.com/zombocom/syntax_search/pull/8)

## 0.1.0

- Initial release
